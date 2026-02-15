run.job "BambooHR Get Employee" {
  main = {
    name: "fetch_employee"
    input: {
      employee_id: ""
    }
  }
  env = ["bamboohr_api_key", "bamboohr_subdomain"]
}
