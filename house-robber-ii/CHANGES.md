# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/house_robber_ii.xs`

**Result:** PASS ✓

Both files passed validation on the first attempt. No changes required.

**Code at this point:**

### run.xs
```xs
run.job "House Robber II Test" {
  main = {
    name: "house_robber_ii"
    input: {
      houses: [2, 3, 2]
    }
  }
}
```

### function/house_robber_ii.xs
```xs
function "house_robber_ii" {
  description = "Find maximum money that can be robbed from circular houses without robbing adjacent houses"
  input {
    int[] houses { description = "Array of money in each house arranged in a circle" }
  }
  stack {
    // Handle edge cases
    conditional {
      if (($input.houses|count) == 0) {
        return { value = 0 }
      }
      elseif (($input.houses|count) == 1) {
        return { value = $input.houses|first }
      }
      elseif (($input.houses|count) == 2) {
        var $max_two {
          value = ($input.houses|first) > ($input.houses|last) ? ($input.houses|first) : ($input.houses|last)
        }
        return { value = $max_two }
      }
    }

    // Helper: Linear house robber (houses 0 to n-2)
    var $exclude_last { value = 0 }
    var $prev1 { value = 0 }
    var $prev2 { value = 0 }
    var $i { value = 0 }
    var $n { value = ($input.houses|count) - 1 }
    
    while ($i < $n) {
      each {
        var $current {
          value = $prev1 > ($prev2 + ($input.houses|slice:$i:1|first)) ? $prev1 : ($prev2 + ($input.houses|slice:$i:1|first))
        }
        var.update $prev2 { value = $prev1 }
        var.update $prev1 { value = $current }
        var.update $i { value = $i + 1 }
      }
    }
    var.update $exclude_last { value = $prev1 }

    // Helper: Linear house robber (houses 1 to n-1)
    var $exclude_first { value = 0 }
    var.update $prev1 { value = 0 }
    var.update $prev2 { value = 0 }
    var.update $i { value = 1 }
    var.update $n { value = $input.houses|count }
    
    while ($i < $n) {
      each {
        var $current2 {
          value = $prev1 > ($prev2 + ($input.houses|slice:$i:1|first)) ? $prev1 : ($prev2 + ($input.houses|slice:$i:1|first))
        }
        var.update $prev2 { value = $prev1 }
        var.update $prev1 { value = $current2 }
        var.update $i { value = $i + 1 }
      }
    }
    var.update $exclude_first { value = $prev1 }

    // Return max of both scenarios
    var $result {
      value = $exclude_last > $exclude_first ? $exclude_last : $exclude_first
    }
  }
  response = $result
}
```
