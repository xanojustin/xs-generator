// WorkOS Create Organization Run Job
// Creates a new organization in WorkOS for enterprise SSO provisioning
run.job "WorkOS Create Organization" {
  main = {
    name: "create_workos_organization"
    input: {
      name: "Acme Corporation"
      domain: "acme.com"
      external_id: "acme-corp-001"
      metadata: {
        plan: "enterprise",
        region: "us-west"
      }
    }
  }
  env = ["WORKOS_API_KEY"]
}
