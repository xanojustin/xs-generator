function "enrich_company" {
  description = "Enrich company data using Clearbit API"
  input {
    text domain filters=trim { description = "Company domain to enrich (e.g., 'stripe.com')" }
    text company_name? filters=trim { description = "Optional company name to help with matching" }
    text enrich_type?="company" filters=trim { description = "Type of enrichment: 'company' or 'combined' (company + people)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.CLEARBIT_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "CLEARBIT_API_KEY environment variable not configured"
    }

    // Validate domain is provided
    precondition ($input.domain != null && $input.domain != "") {
      error_type = "inputerror"
      error = "Domain is required"
    }

    // Clean the domain (remove protocol and path if present)
    var $clean_domain {
      value = $input.domain|replace:"https://":""|replace:"http://":""|replace:"www.":""|split:"/"|first|trim
    }

    // Build the request URL
    var $endpoint {
      value = "https://company.clearbit.com/v2/companies/find?domain=" ~ $clean_domain
    }

    // Send the request to Clearbit
    api.request {
      url = $endpoint
      method = "GET"
      headers = [
        "Authorization: Bearer " ~ $api_key
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $company_data { value = null }
    var $error_message { value = null }
    var $name { value = null }
    var $legal_name { value = null }
    var $logo { value = null }
    var $description { value = null }
    var $industry { value = null }
    var $employees { value = null }
    var $location { value = null }
    var $website { value = null }
    var $twitter_handle { value = null }
    var $linkedin_handle { value = null }
    var $founded_year { value = null }
    var $raised { value = null }
    var $tech_stack { value = [] }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $company_data { value = $response_body }
        
        // Extract company fields
        conditional {
          if ($response_body|get:"name" != null) {
            var $name { value = $response_body|get:"name" }
          }
        }
        
        conditional {
          if ($response_body|get:"legalName" != null) {
            var $legal_name { value = $response_body|get:"legalName" }
          }
        }
        
        conditional {
          if ($response_body|get:"logo" != null) {
            var $logo { value = $response_body|get:"logo" }
          }
        }
        
        conditional {
          if ($response_body|get:"description" != null) {
            var $description { value = $response_body|get:"description" }
          }
        }
        
        conditional {
          if ($response_body|get:"category" != null) {
            var $category_obj { value = $response_body|get:"category" }
            conditional {
              if ($category_obj|get:"industry" != null) {
                var $industry { value = $category_obj|get:"industry" }
              }
            }
          }
        }
        
        conditional {
          if ($response_body|get:"metrics" != null) {
            var $metrics { value = $response_body|get:"metrics" }
            conditional {
              if ($metrics|get:"employees" != null) {
                var $employees { value = $metrics|get:"employees" }
              }
            }
            conditional {
              if ($metrics|get:"raised" != null) {
                var $raised { value = $metrics|get:"raised" }
              }
            }
          }
        }
        
        conditional {
          if ($response_body|get:"geo" != null) {
            var $geo { value = $response_body|get:"geo" }
            var $location_parts { value = [] }
            
            conditional {
              if ($geo|get:"city" != null) {
                var $location_parts { value = $location_parts|append:($geo|get:"city") }
              }
            }
            
            conditional {
              if ($geo|get:"state" != null) {
                var $location_parts { value = $location_parts|append:($geo|get:"state") }
              }
            }
            
            conditional {
              if ($geo|get:"country" != null) {
                var $location_parts { value = $location_parts|append:($geo|get:"country") }
              }
            }
            
            var $location { value = $location_parts|join:", " }
          }
        }
        
        conditional {
          if ($response_body|get:"site" != null) {
            var $site { value = $response_body|get:"site" }
            conditional {
              if ($site|get:"phoneNumbers" != null) {
                var $phone_numbers { value = $site|get:"phoneNumbers" }
              }
            }
          }
        }
        
        conditional {
          if ($response_body|get:"site" != null) {
            var $site { value = $response_body|get:"site" }
            conditional {
              if ($site|get:"url" != null) {
                var $website { value = $site|get:"url" }
              }
            }
          }
        }
        
        conditional {
          if ($response_body|get:"twitter" != null) {
            var $twitter { value = $response_body|get:"twitter" }
            conditional {
              if ($twitter|get:"handle" != null) {
                var $twitter_handle { value = $twitter|get:"handle" }
              }
            }
          }
        }
        
        conditional {
          if ($response_body|get:"linkedin" != null) {
            var $linkedin { value = $response_body|get:"linkedin" }
            conditional {
              if ($linkedin|get:"handle" != null) {
                var $linkedin_handle { value = $linkedin|get:"handle" }
              }
            }
          }
        }
        
        conditional {
          if ($response_body|get:"foundedYear" != null) {
            var $founded_year { value = $response_body|get:"foundedYear" }
          }
        }
        
        conditional {
          if ($response_body|get:"tech" != null) {
            var $tech { value = $response_body|get:"tech" }
            conditional {
              if ($tech|get:"categories" != null) {
                var $tech_stack { value = $tech|get:"categories" }
              }
            }
          }
        }
      }
      elseif ($api_result.response.status == 404) {
        var $success { value = false }
        var $error_message { value = "Company not found for domain: " ~ $clean_domain }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "Clearbit API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $result { value = $api_result.response.result }
            conditional {
              if ($result|get:"error" != null) {
                var $error_message {
                  value = $result|get:"error"
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    domain: $clean_domain,
    company: {
      name: $name,
      legal_name: $legal_name,
      logo: $logo,
      description: $description,
      industry: $industry,
      employees: $employees,
      founded_year: $founded_year,
      funding_raised: $raised,
      location: $location,
      website: $website,
      twitter_handle: $twitter_handle,
      linkedin_handle: $linkedin_handle,
      tech_stack: $tech_stack
    },
    raw_data: $company_data,
    error: $error_message
  }
}
