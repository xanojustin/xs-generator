# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/largest_perimeter_triangle.xs
**Result:** run.xs passed, function/largest_perimeter_triangle.xs failed
**Validation errors being addressed:**
```
1. [Line 18, Column 32] An expression should be wrapped in parentheses when combining filters and tests

💡 Suggestion: Use "int" instead of "integer" for type declaration

Code at line 18:
  if ($input.sides|count < 3) {
```

**Diff:**
```diff
-      if ($input.sides|count < 3) {
+      if (($input.sides|count) < 3) {
```

Also fixed while loop condition on line 34:
```diff
-        while ($i <= $n - 3 && !$found) {
+        while (($i <= ($n - 3)) && !$found) {
```

---

## Validation 2 - Fixed parentheses issues

**Files changed:** function/largest_perimeter_triangle.xs
**Validation errors being addressed:** Filter and comparison operator combinations need parentheses
**Result:** Both files pass validation ✓

---
