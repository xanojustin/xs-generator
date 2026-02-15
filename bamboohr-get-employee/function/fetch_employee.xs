function "fetch_employee" {
  description = "Fetch employee information from BambooHR API"
  input {
    text employee_id
  }
  stack {
    precondition ($input.employee_id != "") {
      error_type = "inputerror"
      error = "Employee ID is required"
    }

    var $api_key {
      value = $env.bamboohr_api_key
    }

    var $subdomain {
      value = $env.bamboohr_subdomain
    }

    var $url {
      value = "https://api.bamboohr.com/api/gateway.php/" ~ $subdomain ~ "/v1/employees/" ~ $input.employee_id ~ "/?fields=firstName,lastName,department,jobTitle,workEmail,hireDate,employmentStatus"
    }

    var $auth_header {
      value = "Authorization: Basic " ~ ($api_key ~ ":x"|base64_encode)
    }

    api.request {
      url = $url
      method = "GET"
      headers = [$auth_header, "Accept: application/json"]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $employee {
          value = $api_result.response.result
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFound"
          value = "Employee not found"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "BambooHR API returned status " ~ ($api_result.response.status|to_text)
        }
      }
    }
  }
  response = $employee
}
