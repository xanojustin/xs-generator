function "enrich_company" {
  input {
    text domain
  }
  stack {
    precondition ($input.domain != null && $input.domain != "") {
      error_type = "inputerror"
      error = "Domain is required"
    }

    var $api_url {
      value = "https://company.clearbit.com/v2/companies/find?domain=" ~ $input.domain
    }

    api.request {
      url = $api_url
      method = "GET"
      headers = [
        "Authorization: Bearer " ~ $env.clearbit_api_key
      ]
      timeout = 30
    } as $api_result

    conditional {
      if ($api_result.response.status == 200) {
        var $company_data { value = $api_result.response.result }
        
        var $enriched {
          value = {
            domain: $input.domain,
            name: $company_data|get:"name":"",
            legal_name: $company_data|get:"legalName":"",
            description: $company_data|get:"description":"",
            logo: $company_data|get:"logo":"",
            website: $company_data|get:"url":"",
            founded_year: $company_data|get:"foundedYear":null,
            employees: $company_data|get:"metrics"|get:"employees":null,
            employees_range: $company_data|get:"metrics"|get:"employeesRange":"",
            industry: $company_data|get:"category"|get:"industry":"",
            sector: $company_data|get:"category"|get:"sector":"",
            tags: $company_data|get:"tags":[],
            location: {
              city: $company_data|get:"geo"|get:"city":"",
              state: $company_data|get:"geo"|get:"state":"",
              country: $company_data|get:"geo"|get:"country":"",
              postal_code: $company_data|get:"geo"|get:"postalCode":""
            },
            linkedin: $company_data|get:"linkedin"|get:"handle":"",
            twitter: $company_data|get:"twitter"|get:"handle":"",
            facebook: $company_data|get:"facebook"|get:"handle":"",
            enriched_at: now
          }
        }
      }
      elseif ($api_result.response.status == 404) {
        throw {
          name = "NotFound"
          value = "Company not found for domain: " ~ $input.domain
        }
      }
      elseif ($api_result.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid Clearbit API key"
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Clearbit API error: " ~ ($api_result.response.status|to_text)
        }
      }
    }
  }
  response = $enriched
}
