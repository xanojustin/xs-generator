task "sync_user_activity" {
  description = "Scheduled task to sync recent user activity to Klaviyo. Queries users who had activity in the last hour and syncs their profiles and recent events."

  stack {
    debug.log {
      description = "Log task start"
      value = {
        task: "sync_user_activity",
        started_at: now,
        message: "Starting user activity sync to Klaviyo"
      }
    }

    var $one_hour_ago {
      description = "Calculate timestamp for 1 hour ago"
      value = (now|transform_timestamp:"1 hour ago":"UTC")
    }

    var $profiles_synced {
      description = "Counter for synced profiles"
      value = 0
    }

    var $events_synced {
      description = "Counter for synced events"
      value = 0
    }

    var $errors {
      description = "Array to collect any errors"
      value = []
    }

    db.query "user_activity" {
      description = "Query user activity from the last hour"
      where = $db.user_activity.created_at >= $one_hour_ago
      sort = {user_activity.created_at: "desc"}
      return = {type: "list", paging: {page: 1, per_page: 100, totals: true}}
    } as $recent_activities

    var $activity_count {
      description = "Count of activities found"
      value = $recent_activities|count
    }

    debug.log {
      description = "Log activities found"
      value = {
        activities_found: $activity_count,
        since: $one_hour_ago
      }
    }

    conditional {
      description = "Process activities if any found"
      if ($activity_count > 0) {
        foreach ($recent_activities) {
          each as $activity {
            try_catch {
              description = "Attempt to sync each activity"
              try {
                function.run "klaviyo_create_profile" {
                  description = "Create or update Klaviyo profile for user"
                  input = {
                    email: $activity.email,
                    first_name: $activity.first_name,
                    last_name: $activity.last_name,
                    external_id: $activity.user_id|to_text
                  }
                } as $profile_result

                conditional {
                  description = "Increment profile counter on success"
                  if ($profile_result.success) {
                    math.add $profiles_synced {
                      value = 1
                    }
                  }
                }

                function.run "klaviyo_track_event" {
                  description = "Track the activity as a Klaviyo event"
                  input = {
                    email: $activity.email,
                    event_name: $activity.activity_type,
                    timestamp: $activity.created_at,
                    properties: $activity.metadata,
                    profile_properties: {
                      first_name: $activity.first_name,
                      last_name: $activity.last_name
                    }
                  }
                } as $event_result

                conditional {
                  description = "Increment event counter on success"
                  if ($event_result.success) {
                    math.add $events_synced {
                      value = 1
                    }
                  }
                }
              }

              catch {
                debug.log {
                  description = "Log sync error for this activity"
                  value = {
                    error: "Failed to sync activity",
                    activity_id: $activity.id,
                    error_message: $error.message
                  }
                }

                array.push $errors {
                  value = {
                    activity_id: $activity.id,
                    error: $error.message
                  }
                }
              }
            }
          }
        }
      }
    }

    db.add "sync_log" {
      description = "Log the sync operation results"
      data = {
        sync_type: "klaviyo_user_activity",
        started_at: $one_hour_ago,
        completed_at: now,
        profiles_synced: $profiles_synced,
        events_synced: $events_synced,
        activities_found: $activity_count,
        errors: $errors,
        status: (($errors|count) == 0) ? "success" : "partial"
      }
    } as $sync_log_entry

    debug.log {
      description = "Log task completion"
      value = {
        task: "sync_user_activity",
        completed_at: now,
        activities_found: $activity_count,
        profiles_synced: $profiles_synced,
        events_synced: $events_synced,
        errors_count: $errors|count,
        sync_log_id: $sync_log_entry.id
      }
    }

    var $task_result {
      description = "Build task result summary"
      value = {
        success: true,
        message: "User activity sync completed",
        activities_found: $activity_count,
        profiles_synced: $profiles_synced,
        events_synced: $events_synced,
        errors_count: $errors|count
      }
    }
  }

  schedule = [{starts_on: 2026-02-13 07:00:00+0000, freq: 3600}]

  history = "inherit"
}
