# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** function/wiggle_sort.xs, run.xs
**Result:** Fail - 5 errors
**Validation errors:**
```
1. [Line 13, Column 32] An expression should be wrapped in parentheses when combining filters and tests
   Code: if ($input.nums|count <= 1) {
   
2-5. [Lines 38, 39, 49, 50] Unknown filter function 'array_update'
   Code: var $arr { value = $arr|array_update:($i - 1):$curr }
```

---

## Validation 2 - Fixed filter parentheses and array update syntax

**Files changed:** function/wiggle_sort.xs
**Validation errors being addressed:** 
1. Filter expression without parentheses: `$input.nums|count <= 1`
2. Invalid `array_update` filter - doesn't exist in XanoScript

**Diff:**
```diff
  // Handle edge cases
  conditional {
-   if ($input.nums|count <= 1) {
+   if (($input.nums|count) <= 1) {
      var $result { value = $input.nums }
    }
```

```diff
- while ($i < $arr|count) {
+ while ($i < ($arr|count)) {
```

```diff
  conditional {
    if ($curr < $prev) {
      // Swap to ensure wiggle property
-     var $temp { value = $arr[$i - 1] }
-     var $arr { value = $arr|array_update:($i - 1):$curr }
-     var $arr { value = $arr|array_update:$i:$temp }
+     var $temp { value = $prev }
+     var.update $arr[$i - 1] { value = $curr }
+     var.update $arr[$i] { value = $temp }
    }
  }
```

**Result:** Pass - all files valid

---
