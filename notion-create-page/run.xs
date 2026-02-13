task "notion_create_page_job" {
  description = "Scheduled job to create Notion pages from pending tasks queue. Runs every hour to process tasks marked for Notion creation."

  stack {
    debug.log {
      value = "Starting Notion page creation job"
      description = "Log job start"
    }

    var $database_id {
      value = $env.notion_database_id
      description = "Get Notion database ID from environment"
    }

    conditional {
      description = "Check if database ID is configured"
      if ($database_id == "" || $database_id == null) {
        debug.log {
          value = "notion_database_id not configured, skipping job"
          description = "Log missing config"
        }

        return {
          value = {status: "skipped", reason: "notion_database_id not configured"}
        }
      }
    }

    db.query "notion_tasks_queue" {
      description = "Get pending tasks queued for Notion creation"
      where = $db.notion_tasks_queue.status == "pending"
      sort = {created_at: "asc"}
      return = {
        type: "list"
        paging: {
          page: 1
          per_page: 10
        }
      }
    } as $pending_tasks

    var $task_count {
      value = $pending_tasks|count
      description = "Count pending tasks"
    }

    debug.log {
      value = "Found " ~ $task_count ~ " pending tasks to create in Notion"
      description = "Log pending task count"
    }

    conditional {
      description = "Process tasks if any exist"
      if ($task_count > 0) {
        var $processed_count {
          value = 0
          description = "Track successfully processed tasks"
        }

        var $failed_count {
          value = 0
          description = "Track failed tasks"
        }

        foreach ($pending_tasks) {
          each as $task {
            try_catch {
              description = "Create Notion page for task"
              try {
                function.run "notion/create_page" {
                  description = "Call Notion API to create page"
                  input = {
                    database_id: $database_id
                    title: $task.title
                    content: $task.description
                    status: $task.status
                    priority: $task.priority
                    tags: $task.tags
                  }
                } as $notion_result

                db.edit "notion_tasks_queue" {
                  description = "Mark task as completed"
                  field_name = "id"
                  field_value = $task.id
                  data = {
                    status: "completed"
                    notion_page_id: $notion_result.page_id
                    notion_url: $notion_result.url
                    processed_at: now
                  }
                } as $updated_task

                math.add $processed_count {
                  value = 1
                  description = "Increment processed count"
                }

                debug.log {
                  value = "Created Notion page for task " ~ $task.id ~ " - URL: " ~ $notion_result.url
                  description = "Log successful creation"
                }
              }

              catch {
                db.edit "notion_tasks_queue" {
                  description = "Mark task as failed"
                  field_name = "id"
                  field_value = $task.id
                  data = {
                    status: "failed"
                    error_message: $error.message
                    processed_at: now
                  }
                } as $failed_task

                math.add $failed_count {
                  value = 1
                  description = "Increment failed count"
                }

                debug.log {
                  value = "Failed to create Notion page for task " ~ $task.id ~ " - Error: " ~ $error.message
                  description = "Log failure"
                }
              }
            }
          }
        }

        debug.log {
          value = "Job complete. Processed: " ~ $processed_count ~ ", Failed: " ~ $failed_count
          description = "Log job completion summary"
        }

        return {
          value = {
            status: "completed"
            total_tasks: $task_count
            processed: $processed_count
            failed: $failed_count
          }
        }
      }

      else {
        debug.log {
          value = "No pending tasks to process"
          description = "Log empty queue"
        }

        return {
          value = {status: "completed", message: "No pending tasks"}
        }
      }
    }
  }

  schedule = [{starts_on: 2026-02-13 00:00:00+0000, freq: 3600}]

  history = "inherit"
}
