function "calculator" {
  description = "Basic calculator supporting add, subtract, multiply, divide operations"

  input {
    text operation filters=trim|lower
    decimal a
    decimal b
  }

  stack {
    // Validate operation
    var $valid_operations { value = ["add", "subtract", "multiply", "divide"] }
    var $is_valid {
      value = (($valid_operations|filter:$$ == $input.operation)|count) > 0
    }

    conditional {
      if (!$is_valid) {
        return {
          value = {
            error: "Invalid operation. Supported: add, subtract, multiply, divide"
          }
        }
      }
    }

    // Handle division by zero check
    conditional {
      if ($input.operation == "divide" && $input.b == 0) {
        return {
          value = {
            error: "Cannot divide by zero"
          }
        }
      }
    }

    // Perform calculation based on operation
    var $calc_result { value = 0 }

    conditional {
      if ($input.operation == "add") {
        var.update $calc_result { value = $input.a + $input.b }
      }
      elseif ($input.operation == "subtract") {
        var.update $calc_result { value = $input.a - $input.b }
      }
      elseif ($input.operation == "multiply") {
        var.update $calc_result { value = $input.a * $input.b }
      }
      elseif ($input.operation == "divide") {
        var.update $calc_result { value = $input.a / $input.b }
      }
    }

    // Build response
    var $func_response {
      value = {
        operation: $input.operation,
        a: $input.a,
        b: $input.b,
        result: $calc_result
      }
    }
  }

  response = $func_response
}
