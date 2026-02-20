# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/merge_sort.xs
**Result:** FAIL (2 errors)
**Validation errors:**
1. [Line 16, Column 35] An expression should be wrapped in parentheses when combining filters and tests
   - Code: `if ($input.numbers|count <= 1) {`
2. [Line 22, Column 19] Expecting: Expected an expression but found: 'function'
   - Code: `value = function.run "merge_sort_helper":{arr: $input.numbers}`

---

## Validation 2 - Fixed filter parentheses and function.run syntax

**Files changed:** function/merge_sort.xs
**Validation errors being addressed:**
1. Filter expression needed parentheses: `($input.numbers|count) <= 1`
2. `function.run` syntax was wrong - should use block syntax with `input = {}` instead of colon object syntax

**Diff:**
```diff
-       if ($input.numbers|count <= 1) {
+       if (($input.numbers|count) <= 1) {
```

```diff
-         var $sorted { 
-           value = function.run "merge_sort_helper":{arr: $input.numbers}
-         }
+         function.run "merge_sort_helper" {
+           input = { arr: $input.numbers }
+         } as $sorted_result
+         
+         var $sorted { value = $sorted_result }
```

Also updated all other `function.run` calls in merge_sort_helper to use the correct block syntax.

**Result:** FAIL (1 error - multiple definitions in one file)

---

## Validation 3 - Split functions into separate files

**Files changed:** function/merge_sort.xs, function/merge_sort_helper.xs (new), function/merge_arrays.xs (new)
**Validation errors being addressed:**
- [Line 30, Column 1] Redundant input, expecting EOF but found: // Helper function
- Each .xs file can only contain ONE definition

**Changes:**
- Split the original single file (with 3 functions) into 3 separate files:
  1. `function/merge_sort.xs` - Main entry point
  2. `function/merge_sort_helper.xs` - Recursive helper
  3. `function/merge_arrays.xs` - Merge two sorted arrays
- Renamed `merge` to `merge_arrays` to avoid potential conflicts

**Result:** PASS - All 4 files validated successfully

---
