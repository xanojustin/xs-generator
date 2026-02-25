# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/bulls_and_cows.xs
**Result:** FAIL
**Errors:**
1. [Line 15, Column 47] Unknown filter function 'str_split'
2. [Line 16, Column 45] Unknown filter function 'str_split'

**Issue:** Used `str_split` instead of `split` filter.

---

## Validation 2 - Fixed split filter name

**Files changed:** function/bulls_and_cows.xs
**Validation errors being addressed:** 
```
1. [Line 15, Column 47] Unknown filter function 'str_split'
2. [Line 16, Column 45] Unknown filter function 'str_split'
```

**Diff:**
```diff
-   var $secret_chars { value = $input.secret|str_split:"" }
-   var $guess_chars { value = $input.guess|str_split:"" }
+   var $secret_chars { value = $input.secret|split:"" }
+   var $guess_chars { value = $input.guess|split:"" }
```

**Result:** PASS - Both files validated successfully
