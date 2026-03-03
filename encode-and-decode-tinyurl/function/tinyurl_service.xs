function "tinyurl_service" {
  input {
    text operation
    text url?
    text tinyurl?
  }
  stack {
    // Base62 characters for encoding
    var $base62 { value = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" }
    
    // In-memory storage for URL mappings (key: shortKey, value: original URL)
    var $url_map { value = {} }
    var $key_counter { value = 1000000 }
    
    // Variables for encoding/decoding
    var $result { value = {} }
    var $new_key { value = "" }
    var $n { value = 0 }
    var $remainder { value = 0 }
    var $char { value = "" }
    var $padding { value = "" }
    var $i { value = 0 }
    var $padding_needed { value = 0 }
    var $short_url { value = "" }
    var $short_key { value = "" }
    var $original_url { value = "" }
    var $parts { value = [] }
    var $existing_key { value = "" }
    var $found { value = false }
    var $entry_value { value = "" }
    
    // Encode operation
    conditional {
      if ($input.operation == "encode") {
        // Check if URL is provided
        precondition ($input.url != null && $input.url != "") {
          error_type = "inputerror"
          error = "URL is required for encode operation"
        }
        
        // Check if URL already exists in map by iterating
        // (In real scenario, we'd use a reverse index)
        var.update $found { value = false }
        var.update $existing_key { value = "" }
        
        foreach ($url_map) {
          each as $map_key {
            var.update $entry_value { value = $url_map|get:$map_key }
            conditional {
              if ($entry_value == $input.url) {
                var.update $existing_key { value = $map_key }
                var.update $found { value = true }
              }
            }
          }
        }
        
        conditional {
          if ($found) {
            // Return existing short URL
            var.update $short_url { value = "http://tinyurl.com/" ~ $existing_key }
            var.update $result { 
              value = {
                operation: "encode",
                original_url: $input.url,
                tinyurl: $short_url,
                short_key: $existing_key
              }
            }
          }
          else {
            // Generate new short key using base62 encoding
            var.update $new_key { value = "" }
            var.update $n { value = $key_counter }
            
            // Convert counter to base62 (max 6 iterations for our counter range)
            for (6) {
              each as $idx {
                conditional {
                  if ($n > 0) {
                    var.update $remainder { value = $n % 62 }
                    var.update $char { value = $base62|substr:$remainder:1 }
                    var.update $new_key { value = $char ~ $new_key }
                    var.update $n { value = ($n / 62)|floor }
                  }
                }
              }
            }
            
            // Ensure key is at least 6 characters with zero padding
            conditional {
              if (($new_key|strlen) < 6) {
                var.update $padding_needed { value = 6 - ($new_key|strlen) }
                var.update $padding { value = "" }
                for (6) {
                  each as $pidx {
                    conditional {
                      if ($pidx < $padding_needed) {
                        var.update $padding { value = $padding ~ "0" }
                      }
                    }
                  }
                }
                var.update $new_key { value = $padding ~ $new_key }
              }
            }
            
            // Store mapping
            var.update $url_map { value = $url_map|set:$new_key:$input.url }
            var.update $key_counter { value = $key_counter + 1 }
            
            var.update $short_url { value = "http://tinyurl.com/" ~ $new_key }
            var.update $result { 
              value = {
                operation: "encode",
                original_url: $input.url,
                tinyurl: $short_url,
                short_key: $new_key
              }
            }
          }
        }
      }
      elseif ($input.operation == "decode") {
        // Check if tinyurl is provided
        precondition ($input.tinyurl != null && $input.tinyurl != "") {
          error_type = "inputerror"
          error = "TinyURL is required for decode operation"
        }
        
        // Extract short key from tinyurl
        var.update $parts { value = $input.tinyurl|split:"/" }
        var.update $short_key { value = $parts|last }
        
        // Look up original URL
        var.update $original_url { value = $url_map|get:$short_key }
        
        conditional {
          if ($original_url == null || $original_url == "") {
            var.update $result {
              value = {
                operation: "decode",
                tinyurl: $input.tinyurl,
                error: "URL not found"
              }
            }
          }
          else {
            var.update $result {
              value = {
                operation: "decode",
                tinyurl: $input.tinyurl,
                short_key: $short_key,
                original_url: $original_url
              }
            }
          }
        }
      }
      else {
        throw {
          name = "InvalidOperation"
          value = "Invalid operation. Use 'encode' or 'decode'"
        }
      }
    }
  }
  response = $result
}
