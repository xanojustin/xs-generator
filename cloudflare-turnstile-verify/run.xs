run.job "Cloudflare Turnstile Token Verification" {
  main = {
    name: "verify_turnstile_token"
    input: {
      token: "YOUR_TURNSTILE_TOKEN"
      remoteip: "127.0.0.1"
    }
  }
  env = ["cloudflare_turnstile_secret_key"]
}
