function "send_datadog_metric" {
  description = "Send a custom metric to Datadog monitoring service"
  input {
    text metric_name filters=trim
    decimal metric_value
    text metric_type?="gauge" filters=trim
    text[] tags?
  }
  stack {
    var $api_key {
      value = $env.datadog_api_key
    }
    
    var $site {
      value = "datadoghq.com"
    }
    
    conditional {
      if ($env.datadog_site != null && $env.datadog_site != "") {
        var.update $site {
          value = $env.datadog_site
        }
      }
    }
    
    var $url {
      value = "https://api." ~ $site ~ "/api/v1/series"
    }
    
    var $timestamp {
      value = now|to_seconds
    }
    
    var $payload {
      value = {
        series: [
          {
            metric: $input.metric_name,
            points: [[$timestamp, $input.metric_value]],
            type: $input.metric_type,
            tags: $input.tags ?? []
          }
        ]
      }
    }
    
    api.request {
      url = $url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "DD-API-Key: " ~ $api_key
      ]
    } as $api_result
    
    precondition ($api_result.response.status == 200 || $api_result.response.status == 202) {
      error_type = "standard"
      error = "Datadog API request failed: " ~ ($api_result.response.status|to_text)
    }
  }
  response = {
    success: true,
    metric: $input.metric_name,
    value: $input.metric_value,
    status: $api_result.response.status
  }
}
