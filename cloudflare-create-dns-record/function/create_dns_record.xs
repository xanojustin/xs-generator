function "create_dns_record" {
  description = "Create a DNS record in Cloudflare"
  input {
    text zone_id filters=trim
    text record_type filters=trim { description = "DNS record type (A, AAAA, CNAME, MX, TXT, etc.)" }
    text name filters=trim { description = "DNS record name (subdomain or @ for root)" }
    text content filters=trim { description = "Record content (IP address, target domain, etc.)" }
    int ttl?=1 { description = "TTL in seconds (1 for automatic)" }
    bool proxied?=true { description = "Whether to proxy through Cloudflare" }
  }
  stack {
    precondition ($input.zone_id != "") {
      error_type = "inputerror"
      error = "zone_id is required"
    }

    precondition ($input.name != "") {
      error_type = "inputerror"
      error = "name is required"
    }

    precondition ($input.content != "") {
      error_type = "inputerror"
      error = "content is required"
    }

    var $allowed_types {
      value = ["A", "AAAA", "CNAME", "MX", "TXT", "NS", "SRV", "PTR", "CERT", "DNSKEY", "DS", "NAPTR", "SMIMEA", "SSHFP", "TLSA", "URI"]
    }

    precondition ($allowed_types|contains:$input.record_type) {
      error_type = "inputerror"
      error = "Invalid record_type. Must be one of: A, AAAA, CNAME, MX, TXT, NS, SRV, PTR, CERT, DNSKEY, DS, NAPTR, SMIMEA, SSHFP, TLSA, URI"
    }

    var $api_url {
      value = "https://api.cloudflare.com/client/v4/zones/" ~ $input.zone_id ~ "/dns_records"
    }

    var $payload {
      value = {
        type: $input.record_type,
        name: $input.name,
        content: $input.content,
        ttl: $input.ttl,
        proxied: $input.proxied
      }
    }

    api.request {
      url = $api_url
      method = "POST"
      params = $payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.cloudflare_api_token
      ]
      timeout = 30
    } as $api_result

    var $response_status {
      value = $api_result.response.status
    }

    var $response_body {
      value = $api_result.response.result
    }

    conditional {
      if (`$response_status >= 200 && $response_status < 300`) {
        conditional {
          if ($response_body.success == true) {
            var $result {
              value = {
                success: true,
                message: "DNS record created successfully",
                record: $response_body.result
              }
            }
          }
          else {
            var $error_messages {
              value = $response_body.errors|map:$$.message
            }
            throw {
              name = "CloudflareAPIError"
              value = "Cloudflare API returned errors: " ~ ($error_messages|join:", ")
            }
          }
        }
      }
      elseif (`$response_status == 400`) {
        throw {
          name = "BadRequestError"
          value = "Invalid request: " ~ ($response_body.errors|json_encode)
        }
      }
      elseif (`$response_status == 401`) {
        throw {
          name = "AuthenticationError"
          value = "Authentication failed. Check your Cloudflare API token."
        }
      }
      elseif (`$response_status == 403`) {
        throw {
          name = "PermissionError"
          value = "Permission denied. Ensure your API token has DNS edit permissions for this zone."
        }
      }
      elseif (`$response_status == 404`) {
        throw {
          name = "NotFoundError"
          value = "Zone not found. Check your zone_id."
        }
      }
      else {
        throw {
          name = "APIError"
          value = "Unexpected error (HTTP " ~ ($response_status|to_text) ~ "): " ~ ($response_body|json_encode)
        }
      }
    }
  }
  response = $result
}
