function "lookup_ip" {
  description = "Look up geolocation data for an IP address using IPinfo API"
  input {
    text ip?="" filters=trim
  }
  stack {
    var $api_key { value = $env.IPINFO_API_KEY }
    
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "IPINFO_API_KEY environment variable is required"
    }
    
    var $url { value = "" }
    
    conditional {
      if ($input.ip != null && $input.ip != "") {
        var.update $url { value = "https://ipinfo.io/" ~ $input.ip ~ "/json?token=" ~ $api_key }
      }
      else {
        var.update $url { value = "https://ipinfo.io/json?token=" ~ $api_key }
      }
    }
    
    api.request {
      url = $url
      method = "GET"
      headers = ["Accept: application/json"]
      timeout = 30
    } as $api_result
    
    precondition ($api_result.response.status == 200) {
      error_type = "standard"
      error = "IPinfo API error: " ~ ($api_result.response.status|to_text)
    }
    
    var $ip_data { value = $api_result.response.result }
    
    var $ip_info {
      value = {
        ip: $ip_data.ip,
        city: $ip_data.city,
        region: $ip_data.region,
        country: $ip_data.country,
        loc: $ip_data.loc,
        org: $ip_data.org,
        postal: $ip_data.postal,
        timezone: $ip_data.timezone,
        hostname: $ip_data.hostname ?? null,
        privacy: $ip_data.privacy ?? null
      }
    }
  }
  response = $ip_info
}
