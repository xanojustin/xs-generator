# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/remove_element.xs
**Result:** Fail
**Validation errors:**
```
run.xs: [Line 3, Column 1] Expecting --> run <-- but found --> '' <--
remove_element.xs: [Line 3, Column 1] Expecting --> function <-- but found --> '' <--
```

**Issue:** Comments at the top of the file containing apostrophes (single quotes) caused parsing errors.

**Code at this point:**
```xs
// Remove Element - Classic array manipulation problem
// Removes all occurrences of 'val' from 'nums' in-place...
```

---

## Validation 2 - Removed comments with apostrophes, fixed input modification

**Files changed:** run.xs, function/remove_element.xs
**Validation errors being addressed:**
1. Comments with apostrophes caused parse errors
2. Cannot modify $input.nums directly (reserved variable)

**Diff for function/remove_element.xs:**
```diff
- // Remove Element - Classic array manipulation problem
- // Removes all occurrences of 'val' from 'nums' in-place...
- 
  function "remove_element" {
    description = "Remove all instances of a value from array in-place and return new length"
    input {
      int[] nums
+     int val
    }
    stack {
      conditional {
        if (($input.nums|count) == 0) {
          return { value = 0 }
        }
      }
+     var $working_nums {
+       value = $input.nums
+     }
      var $write {
        value = 0
      }
      foreach ($input.nums) {
        each as $num {
          conditional {
            if ($num != $input.val) {
-             var.update $input.nums[$write] { value = $num }
+             var.update $working_nums[$write] { value = $num }
              var.update $write { value = $write + 1 }
            }
          }
        }
      }
    }
    response = $write
  }
```

**Diff for run.xs:**
```diff
- // Run job for Remove Element exercise
- // Tests the remove_element function with various inputs
- 
  run.job "Remove Element Test" {
    main = {
      name: "remove_element"
      input: {
        nums: [3, 2, 2, 3]
        val: 3
      }
    }
  }
```

**Result:** Pass - Both files validated successfully

---
