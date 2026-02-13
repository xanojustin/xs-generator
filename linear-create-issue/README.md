# Linear Create Issue

A Xano Run Job that creates issues in Linear using the GraphQL API.

## What It Does

This run job creates a new issue in your Linear workspace with customizable fields including title, description, team assignment, labels, priority, and assignee.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `linear_api_key` | Your Linear API key (found in Linear Settings > API) |

## How to Use

### Basic Usage

The run job executes the `linear_create_issue` function with configurable inputs:

```xs
run.job "Linear Create Issue" {
  main = {
    name: "linear_create_issue"
    input: {
      title: "Fix login bug"
      description: "Users reporting 500 error on login page"
      priority: 2
    }
  }
  env = ["linear_api_key"]
}
```

### Function Inputs

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `title` | text | Yes | The issue title |
| `description` | text | No | Issue description/body |
| `team_id` | text | No | Team ID to assign the issue to |
| `state_id` | text | No | Workflow state ID (backlog, todo, etc.) |
| `assignee_id` | text | No | User ID to assign the issue to |
| `label_ids` | text[] | No | Array of label IDs to apply |
| `priority` | int | No | Priority: 0=none, 1=urgent, 2=high, 3=medium, 4=low |

### Priority Levels

- `0` - No priority
- `1` - Urgent
- `2` - High
- `3` - Medium
- `4` - Low

## File Structure

```
linear-create-issue/
├── run.xs              # Run job configuration
├── function/
│   └── linear_create_issue.xs  # Function implementation
└── README.md           # This file
```

## Response

On success, returns:

```json
{
  "success": true,
  "issue": {
    "id": "issue-uuid",
    "identifier": "TEAM-123",
    "title": "Issue Title",
    "url": "https://linear.app/team/issue/TEAM-123",
    "state": { "name": "Backlog" },
    "priority": 2,
    "createdAt": "2024-01-15T10:30:00.000Z"
  },
  "message": "Issue created successfully: TEAM-123"
}
```

## Getting a Linear API Key

1. Go to Linear → Settings → API
2. Generate a new Personal API Key
3. Save it as `linear_api_key` in your environment variables

## API Reference

Uses the Linear GraphQL API: https://api.linear.app/graphql
