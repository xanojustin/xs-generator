function "cache_operations" {
  description = "Perform Redis cache operations - get, set, delete, increment, decrement"
  input {
    text operation {
      description = "Operation to perform: get, set, delete, incr, decr, demo"
    }
    text? key {
      description = "Cache key (required for get, set, delete, incr, decr)"
    }
    json? value {
      description = "Value to cache (required for set operation)"
    }
    int? ttl {
      description = "Time to live in seconds (optional, default 3600)"
    }
    int? amount {
      description = "Amount to increment/decrement (optional, default 1)"
    }
  }
  stack {
    var $op { value = $input.operation|to_lower|trim }
    
    conditional {
      if ($op == "demo") {
        function.run "run_demo" {} as $demo_result
        var $result { value = $demo_result }
      }
      elseif ($op == "set") {
        precondition ($input.key != null) {
          error = "Key is required for set operation"
        }
        precondition ($input.value != null) {
          error = "Value is required for set operation"
        }
        
        var $cache_ttl {
          value = ($input.ttl != null) ? $input.ttl : 3600
        }
        
        redis.set {
          key = $input.key
          data = $input.value
          ttl = $cache_ttl
        }
        
        var $result {
          value = {
            operation: "set",
            key: $input.key,
            status: "success",
            ttl: $cache_ttl
          }
        }
      }
      elseif ($op == "get") {
        precondition ($input.key != null) {
          error = "Key is required for get operation"
        }
        
        redis.get { key = $input.key } as $cached_value
        
        var $result {
          value = {
            operation: "get",
            key: $input.key,
            found: ($cached_value != null),
            value: $cached_value
          }
        }
      }
      elseif ($op == "delete") {
        precondition ($input.key != null) {
          error = "Key is required for delete operation"
        }
        
        redis.del { key = $input.key }
        
        var $result {
          value = {
            operation: "delete",
            key: $input.key,
            status: "deleted"
          }
        }
      }
      elseif ($op == "incr") {
        precondition ($input.key != null) {
          error = "Key is required for incr operation"
        }
        
        var $incr_amount {
          value = ($input.amount != null) ? $input.amount : 1
        }
        
        redis.incr {
          key = $input.key
          by = $incr_amount
        } as $new_value
        
        var $result {
          value = {
            operation: "incr",
            key: $input.key,
            by: $incr_amount,
            new_value: $new_value
          }
        }
      }
      elseif ($op == "decr") {
        precondition ($input.key != null) {
          error = "Key is required for decr operation"
        }
        
        var $decr_amount {
          value = ($input.amount != null) ? $input.amount : 1
        }
        
        redis.decr {
          key = $input.key
          by = $decr_amount
        } as $new_value
        
        var $result {
          value = {
            operation: "decr",
            key: $input.key,
            by: $decr_amount,
            new_value: $new_value
          }
        }
      }
      else {
        var $result {
          value = {
            error: "Unknown operation",
            provided: $op,
            valid_operations: ["get", "set", "delete", "incr", "decr", "demo"]
          }
        }
      }
    }
  }
  response = $result
}
