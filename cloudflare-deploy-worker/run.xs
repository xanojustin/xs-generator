run.job "Deploy Cloudflare Worker" {
  main = {
    name: "deploy_worker"
    input: {
      script_name: "hello-world"
      script_content: "addEventListener('fetch', event => { event.respondWith(handleRequest(event.request)); }); async function handleRequest(request) { return new Response('Hello from Xano!', { status: 200 }); }"
    }
  }
  env = ["cloudflare_api_token", "cloudflare_account_id"]
}
