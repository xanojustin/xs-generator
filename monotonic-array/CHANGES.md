# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/monotonic-array/run.xs`
- `/Users/justinalbrecht/xs/monotonic-array/function/monotonic-array.xs`

**Result:** Pass ✓

Both files passed validation on the first attempt without any errors.

**Code at this point:**

### run.xs
```xs
// Run job to test the monotonic-array function
run.job "Test Monotonic Array" {
  main = {
    name: "monotonic-array"
    input: {
      nums: [1, 2, 2, 3]
    }
  }
}
```

### function/monotonic-array.xs
```xs
// Monotonic Array - Check if an array is monotonic
// An array is monotonic if it is either entirely non-increasing or non-decreasing
function "monotonic-array" {
  description = "Determines if an array is monotonic (entirely non-decreasing or non-increasing)"
  
  input {
    int[] nums { description = "Array of integers to check" }
  }
  
  stack {
    // Empty array or single element is monotonic
    conditional {
      if (($input.nums|count) <= 1) {
        return { value = true }
      }
    }
    
    var $increasing { value = true }
    var $decreasing { value = true }
    var $i { value = 1 }
    
    while ($i < ($input.nums|count)) {
      each {
        // Check if not increasing (current > next breaks non-decreasing)
        conditional {
          if ($input.nums|get:(`$i - 1`) > $input.nums|get:$i) {
            var $increasing { value = false }
          }
        }
        
        // Check if not decreasing (current < next breaks non-increasing)
        conditional {
          if ($input.nums|get:(`$i - 1`) < $input.nums|get:$i) {
            var $decreasing { value = false }
          }
        }
        
        var.update $i { value = $i + 1 }
      }
    }
  }
  
  response = ($increasing || $decreasing)
}
```

---

*No further validations required - all files passed on first attempt.*
