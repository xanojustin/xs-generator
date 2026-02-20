# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/longest_common_prefix.xs
**Result:** FAIL
**Errors:**
1. Line 13: Expression should be wrapped in parentheses when combining filters and tests
2. Line 22: Expression should be wrapped in parentheses when combining filters and tests
3. Line 27: Expression should be wrapped in parentheses when combining filters and tests
4. Line 30: Unknown filter function 'substring' - should use 'substr'
5. Line 30: Expression should be wrapped in parentheses when combining filters and tests

---

## Validation 2 - Fix filter expressions and substring filter

**Files changed:** function/longest_common_prefix.xs
**Validation errors being addressed:**
- Expressions with filters need parentheses
- `substring` filter doesn't exist, use `substr` instead

**Diff:**
```diff
  // Longest Common Prefix - String manipulation exercise
  // Finds the longest common prefix string amongst an array of strings
  function "longest_common_prefix" {
    description = "Finds the longest common prefix among an array of strings"
  
    input {
      text[] strings { description = "Array of strings to analyze" }
    }
  
    stack {
      // Handle empty array edge case
      conditional {
-       if ($input.strings|count == 0) {
+       if (($input.strings|count) == 0) {
          var $prefix { value = "" }
        }
        else {
          // Start with the first string as the initial prefix candidate
          var $prefix { value = $input.strings[0] }
          var $i { value = 1 }
  
          // Compare with each subsequent string
-         while ($i < $input.strings|count && $prefix|strlen > 0) {
+         while ($i < ($input.strings|count) && ($prefix|strlen) > 0) {
            each {
              var $current_string { value = $input.strings[$i] }
  
              // Shorten prefix until it matches the start of current string
-             while ($prefix|strlen > 0 && !$current_string|starts_with:$prefix) {
+             while (($prefix|strlen) > 0 && !($current_string|starts_with:$prefix)) {
                each {
                  var $prefix {
-                   value = $prefix|substring:0:($prefix|strlen - 1)
+                   value = $prefix|substr:0:(($prefix|strlen) - 1)
                  }
                }
              }
  
              math.add $i { value = 1 }
            }
          }
        }
      }
    }
  
    response = $prefix
  }
```
**Result:** PASS - Both files validated successfully

---
