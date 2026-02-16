# Railway Deploy Service - Xano Run Job

Deploy Docker container services to [Railway](https://railway.app/) - a popular platform for deploying applications with zero configuration.

## What This Run Job Does

This run job automates the deployment of a Docker container to Railway:

1. **Creates a new service** in your Railway project
2. **Configures the service source** with your Docker image
3. **Sets environment variables** (optional)
4. **Triggers a deployment** to make your service live

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `railway_api_token` | Railway API authentication token | [Railway Dashboard](https://railway.app/account/tokens) → Generate Token |

## Required Inputs

| Input | Type | Description | Example |
|-------|------|-------------|---------|
| `project_id` | text | Your Railway project ID | `abc123-def456-ghi789` |
| `service_name` | text | Name for the new service | `my-api-service` |
| `image` | text | Docker image to deploy | `nginx:latest`, `node:18-alpine` |
| `env_vars` | json (optional) | Environment variables | `{ "PORT": "8080", "NODE_ENV": "production" }` |

## How to Use

### 1. Get Your Railway Project ID

Navigate to your Railway project and copy the project ID from the URL:
```
https://railway.app/project/abc123-def456-ghi789
#                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#                    This is your project_id
```

### 2. Generate a Railway API Token

1. Go to [Railway Account Settings](https://railway.app/account/tokens)
2. Click "New Token"
3. Copy the token value

### 3. Set Environment Variable

```bash
export railway_api_token="your-railway-token-here"
```

### 4. Run the Job

Using Xano CLI:
```bash
xano run execute --job railway-deploy-service
```

Or via Xano Run API:
```bash
curl -X POST "https://app.dev.xano.com/api:run/railway-deploy-service" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_XANO_TOKEN" \
  -d '{
    "project_id": "your-project-id",
    "service_name": "my-api",
    "image": "node:18-alpine",
    "env_vars": {
      "PORT": "3000",
      "NODE_ENV": "production"
    }
  }'
```

## Response

```json
{
  "success": true,
  "service": {
    "id": "srv-abc123",
    "name": "my-api"
  },
  "deployment": {
    "id": "dep-def456",
    "status": "BUILDING"
  },
  "message": "Service deployed successfully to Railway"
}
```

## Use Cases

- **CI/CD Pipelines**: Automatically deploy services after tests pass
- **Preview Environments**: Spin up temporary services for PR reviews
- **Microservices**: Deploy multiple services from a monorepo
- **Scheduled Redeployments**: Update services with latest images

## File Structure

```
railway-deploy-service/
├── run.xs                      # Run job configuration
├── function/
│   └── deploy_railway_service.xs  # Main deployment logic
└── README.md                   # This file
```

## Notes

- The Railway API uses GraphQL, not REST
- Deployment status will be `BUILDING` initially - check Railway dashboard for full status
- Environment variables are upserted (created or updated if they exist)
- Service names must be unique within a project

## Links

- [Railway Documentation](https://docs.railway.app/)
- [Railway API Reference](https://docs.railway.app/reference/public-api)
- [Xano Run Documentation](https://docs.xano.com/run)
