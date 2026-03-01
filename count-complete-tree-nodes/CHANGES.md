# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs
**Result:** FAIL

**Validation errors:**
```
✗ run.xs: Found 1 error(s):

1. [Line 7, Column 1] Redundant input, expecting EOF but found: function

💡 Suggestion: Use "text" instead of "string" for type declaration

Code at line 7:
  function "run_tests" {
```

**Issue:** I incorrectly put function definitions inside run.xs. The run.xs file should only contain the run.job block, and all functions should be in the function/ directory.

**Fix:** Moved run.job to run.xs and all helper functions to function/count_complete_tree_nodes.xs

---

## Validation 2 - Attempting to validate function file

**Files validated:** function/count_complete_tree_nodes.xs
**Result:** FAIL

**Validation errors:**
```
✗ count_complete_tree_nodes.xs: Found 1 error(s):

1. [Line 27, Column 1] Redundant input, expecting EOF but found: function

Code at line 27:
  function "count_nodes_helper" {
```

**Issue:** XanoScript only allows one function per .xs file. I incorrectly put multiple function definitions in a single file.

**Fix:** Split functions into separate files:
- function/count_complete_tree_nodes.xs (main function)
- function/count_nodes_helper.xs (recursive helper)
- function/get_left_height.xs (height calculator)
- function/get_right_height.xs (height calculator)

---

## Validation 3 - Validating split function files

**Files validated:** count_complete_tree_nodes.xs, count_nodes_helper.xs
**Result:** 
- count_complete_tree_nodes.xs: PASS
- count_nodes_helper.xs: FAIL

**Validation errors for count_nodes_helper.xs:**
```
✗ count_nodes_helper.xs: Found 1 error(s):

1. [Line 33, Column 43] Expecting: one of these possible Token sequences:
  ...
  but found: '<'

Code at line 33:
  var $full_count { value = (1 << $left_height) - 1 }
```

**Issue:** XanoScript doesn't support the bit shift operator `<<`. I need to use a different approach for calculating 2^height.

**Fix:** Replace bit shift with a function that calculates powers of 2 using a loop or the pow filter.

**Diff:**
```diff
-            // Tree is perfectly full, use formula: 2^height - 1
-            var $full_count { value = (1 << $left_height) - 1 }
+            // Tree is perfectly full, use formula: 2^height - 1
+            // Calculate 2^height using a loop (XanoScript doesn't have bit shift)
+            function.run "power_of_two" {
+              input = { exponent: $left_height }
+            } as $power_result
+            var $full_count { value = $power_result - 1 }
```

---

## Validation 4 - All files pass

**Files validated:** 
- run.xs
- function/count_complete_tree_nodes.xs
- function/count_nodes_helper.xs
- function/get_left_height.xs
- function/get_right_height.xs
- function/power_of_two.xs

**Result:** ALL PASS ✓

**Summary:** All XanoScript files pass validation.
