# Cloudflare Deploy Worker

A Xano Run Job that deploys Cloudflare Worker scripts via the Cloudflare API.

## What It Does

This run job deploys JavaScript-based Cloudflare Workers directly from Xano. Cloudflare Workers is a serverless compute platform that runs code on Cloudflare's edge network.

## Use Cases

- Deploy edge functions from your Xano backend
- Automate worker deployments in CI/CD pipelines
- Dynamically generate and deploy workers based on user input
- Manage multiple worker scripts programmatically

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `cloudflare_api_token` | Cloudflare API Token with Workers Scripts:Edit permission | Cloudflare Dashboard → My Profile → API Tokens |
| `cloudflare_account_id` | Your Cloudflare Account ID | Cloudflare Dashboard → right sidebar on any domain |

## Creating a Cloudflare API Token

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Click your profile icon → "My Profile"
3. Go to "API Tokens" tab
4. Click "Create Token"
5. Use the "Custom token" template
6. Set permissions:
   - **Account** → **Workers Scripts** → **Edit**
   - **Zone** → **Workers Routes** → **Edit** (optional, if managing routes)
7. Set Account Resources to include your account
8. Create the token and copy it for use as `cloudflare_api_token`

## How to Use

### As a Run Job

The run job is configured in `run.xs` with example inputs. Update the `input` block with your worker details:

```xs
run.job "Deploy Cloudflare Worker" {
  main = {
    name: "deploy_worker"
    input: {
      script_name: "my-worker"
      script_content: "addEventListener('fetch', event => { ... })"
    }
  }
}
```

### Calling the Function Directly

```xs
function.run "deploy_worker" {
  input = {
    script_name: "api-gateway",
    script_content: "export default { async fetch(request) { return new Response('Hello!'); } }"
  }
} as $result
```

### Response

On success, returns:
```json
{
  "success": true,
  "script_name": "my-worker",
  "message": "Worker deployed successfully",
  "api_response": { ... }
}
```

## Example Worker Scripts

### Simple Hello World
```javascript
export default {
  async fetch(request) {
    return new Response('Hello from Xano!', { status: 200 });
  }
};
```

### API Gateway with Routing
```javascript
export default {
  async fetch(request) {
    const url = new URL(request.url);
    
    if (url.pathname === '/api/users') {
      return new Response(JSON.stringify({ users: [] }), {
        headers: { 'Content-Type': 'application/json' }
      });
    }
    
    return new Response('Not Found', { status: 404 });
  }
};
```

### With Environment Variables
```javascript
export default {
  async fetch(request, env) {
    const apiKey = env.API_KEY;
    return new Response(`Key starts with: ${apiKey.substring(0, 4)}`);
  }
};
```

## Error Handling

The function handles common error cases:

- **400 Bad Request**: Invalid script syntax or malformed request
- **401 Unauthorized**: Invalid API token
- **404 Not Found**: Account not found or Workers not enabled
- **API Error**: Other Cloudflare API errors with full details

## File Structure

```
cloudflare-deploy-worker/
├── run.xs                    # Run job configuration
├── function/
│   └── deploy_worker.xs      # Deployment function
└── README.md                 # This file
```

## API Reference

This uses the Cloudflare Workers Scripts API:
- **Endpoint**: `PUT /client/v4/accounts/{account_id}/workers/scripts/{script_name}`
- **Docs**: https://developers.cloudflare.com/api/operations/worker-script-upload-worker

## Limitations

- Script size is limited to Cloudflare's worker size limits (approx 1-5MB depending on plan)
- Does not manage worker routes (bind domains to workers separately)
- Does not support WASM modules in this basic implementation
- Environment variables/bindings must be configured separately in Cloudflare Dashboard

## Related

- [Cloudflare Workers Documentation](https://developers.cloudflare.com/workers/)
- [Cloudflare API Documentation](https://developers.cloudflare.com/api/)
