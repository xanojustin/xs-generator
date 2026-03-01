function "evaluate_division" {
  description = "Evaluate division queries based on a set of equations and their values"
  input {
    json equations? {
      description = "Array of equation pairs [numerator, denominator]"
    }
    json values? {
      description = "Array of division results corresponding to equations"
    }
    json queries? {
      description = "Array of query pairs [numerator, denominator] to evaluate"
    }
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.equations|count) == 0) {
        // Return -1.0 for all queries when no equations provided
        var $result { value = [] }
        foreach ($input.queries) {
          each as $q {
            var $result { value = $result.value ~ [-1.0] }
          }
        }
        return { value = $result.value }
      }
    }

    // Build parent and weight maps using Union-Find
    // parent[var] = parent of var in the union-find structure
    // weight[var] = value to multiply to get from var to its parent (var / parent = weight)
    var $parent { value = {} }
    var $weight { value = {} }

    // Initialize each variable as its own parent with weight 1.0
    var $idx { value = 0 }
    foreach ($input.equations) {
      each as $eq {
        // Add first variable
        conditional {
          if (!($parent.value|has:($eq|first))) {
            var $parent { value = $parent.value|set:($eq|first):($eq|first) }
            var $weight { value = $weight.value|set:($eq|first):1.0 }
          }
        }
        // Add second variable
        conditional {
          if (!($parent.value|has:($eq|last))) {
            var $parent { value = $parent.value|set:($eq|last):($eq|last) }
            var $weight { value = $weight.value|set:($eq|last):1.0 }
          }
        }
        // Union the two variables
        // eq[0] / eq[1] = values[idx]
        // So we need to connect eq[0] to eq[1] with appropriate weight
        var $numerator { value = $eq|first }
        var $denominator { value = $eq|last }
        var $eq_value { value = $input.values[$idx] }

        // Find roots with path compression for numerator
        var $root_num { value = $numerator }
        var $weight_num { value = 1.0 }
        while ($root_num != ($parent.value|get:$root_num)) {
          each {
            var $weight_num { value = $weight_num * (($weight.value|get:$root_num)) }
            var $root_num { value = $parent.value|get:$root_num }
          }
        }

        // Find roots with path compression for denominator
        var $root_den { value = $denominator }
        var $weight_den { value = 1.0 }
        while ($root_den != ($parent.value|get:$root_den)) {
          each {
            var $weight_den { value = $weight_den * (($weight.value|get:$root_den)) }
            var $root_den { value = $parent.value|get:$root_den }
          }
        }

        // Union: connect root_num to root_den
        // We know: numerator / denominator = eq_value
        // And: numerator = root_num * weight_num, denominator = root_den * weight_den
        // So: (root_num * weight_num) / (root_den * weight_den) = eq_value
        // Therefore: root_num / root_den = eq_value * weight_den / weight_num
        conditional {
          if ($root_num != $root_den) {
            var $parent { value = $parent.value|set:$root_num:$root_den }
            var $new_weight { value = $eq_value * $weight_den / $weight_num }
            var $weight { value = $weight.value|set:$root_num:$new_weight }
          }
        }

        var $idx { value = $idx + 1 }
      }
    }

    // Process each query
    var $answers { value = [] }
    foreach ($input.queries) {
      each as $query {
        var $num { value = $query|first }
        var $den { value = $query|last }

        // Check if both variables exist
        conditional {
          if ((!($parent.value|has:$num)) || (!($parent.value|has:$den))) {
            var $answers { value = $answers ~ [-1.0] }
          }
          else {
            // Find root of numerator with path compression
            var $root_num { value = $num }
            var $w_num { value = 1.0 }
            while ($root_num != ($parent.value|get:$root_num)) {
              each {
                var $w_num { value = $w_num * (($weight.value|get:$root_num)) }
                var $root_num { value = $parent.value|get:$root_num }
              }
            }

            // Find root of denominator with path compression
            var $root_den { value = $den }
            var $w_den { value = 1.0 }
            while ($root_den != ($parent.value|get:$root_den)) {
              each {
                var $w_den { value = $w_den * (($weight.value|get:$root_den)) }
                var $root_den { value = $parent.value|get:$root_den }
              }
            }

            // If different components, cannot compute
            conditional {
              if ($root_num != $root_den) {
                var $answers { value = $answers ~ [-1.0] }
              }
              else {
                // num / den = (num / root) / (den / root) = w_num / w_den
                var $result_val { value = $w_num / $w_den }
                var $answers { value = $answers ~ [$result_val] }
              }
            }
          }
        }
      }
    }

    return { value = $answers }
  }
  response = $result
}
