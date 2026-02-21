# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/sort-colors.xs`
**Result:** FAIL - 4 errors in `sort-colors.xs`
**Code at this point:** Initial implementation

Errors:
1. [Line 17, Column 25] An expression should be wrapped in parentheses when combining filters and tests
2. [Line 25, Column 17] An expression should be wrapped in parentheses when combining filters and tests
3. [Line 33, Column 20] An expression should be wrapped in parentheses when combining filters and tests
4. [Line 43, Column 24] An expression should be wrapped in parentheses when combining filters and tests

---

## Validation 2 - Fixed filter expression parentheses

**Files changed:** `function/sort-colors.xs`
**Validation errors being addressed:** All 4 "expression should be wrapped in parentheses" errors

**Diff:**
```diff
-      if ($arr|count <= 1) {
+      if (($arr|count) <= 1) {

-    var $high { value = $arr|count - 1 }
+    var $high { value = ($arr|count) - 1 }

-          if ($arr|get:$mid|to_int == 0) {
+          if (($arr|get:$mid|to_int) == 0) {

-          elseif ($arr|get:$mid|to_int == 1) {
+          elseif (($arr|get:$mid|to_int) == 1) {
```

**Result:** PASS - Both files validated successfully

---
