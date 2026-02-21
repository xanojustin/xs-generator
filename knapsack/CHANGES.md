# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/knapsack.xs`
**Result:** Fail - 1 error in knapsack.xs

**Validation errors:**
```
✗ knapsack.xs: Found 1 error(s):

1. [Line 20, Column 9] Expecting --> } <-- but found --> 'response' <--

Code at line 20:
  response = 0
```

**Issue:** Tried to use `response = 0` inside a conditional block within the stack. XanoScript doesn't allow setting `response` inside conditional blocks - it must be set at the end of the function.

---

## Validation 2 - Fixed response placement

**Files changed:** `function/knapsack.xs`
**Validation errors being addressed:** Cannot use `response` inside conditional blocks
**Diff:**
```diff
-     // Handle edge cases
-     conditional {
-       if ($n == 0 || $input.capacity <= 0) {
-         response = 0
-       }
-     }
+     // Handle edge cases - store result in a variable
+     var $result { value = null }
+     
+     conditional {
+       if ($n == 0 || $input.capacity <= 0) {
+         var $result { value = 0 }
+       }
+       else {
+         ... (main logic)
+         var $result { value = $dp[$input.capacity] }
+       }
+     }
   }
-   
-   response = $dp[$input.capacity]
+   response = $result
```

**Result:** Pass - both files validated successfully
