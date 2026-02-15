# BambooHR Get Employee Run Job

This Xano Run Job fetches employee information from the BambooHR API.

## What It Does

The run job calls the BambooHR API to retrieve employee details including:
- First and last name
- Department
- Job title
- Work email
- Hire date
- Employment status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `bamboohr_api_key` | Your BambooHR API key (found in Account > API Keys) |
| `bamboohr_subdomain` | Your BambooHR subdomain (e.g., `yourcompany` in `yourcompany.bamboohr.com`) |

## How to Use

### Run the job with an employee ID:

```bash
xano run execute --job=bamboohr-get-employee --input='{"employee_id": "12345"}'
```

Or via the Xano Run API:

```bash
curl -X POST https://app.dev.xano.com/api:run/v1/jobs \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "job": "bamboohr-get-employee",
    "input": {
      "employee_id": "12345"
    }
  }'
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `employee_id` | text | Yes | The BambooHR employee ID to look up |

## Response

Returns a JSON object with employee details:

```json
{
  "firstName": "John",
  "lastName": "Doe",
  "department": "Engineering",
  "jobTitle": "Senior Developer",
  "workEmail": "john.doe@example.com",
  "hireDate": "2020-01-15",
  "employmentStatus": "Active"
}
```

## Error Handling

- **400 Bad Request**: Employee ID is missing
- **404 Not Found**: Employee ID does not exist
- **500 Internal Error**: API request failed

## BambooHR API Documentation

For more information, see the [BambooHR API documentation](https://documentation.bamboohr.com/docs/getting-started).
