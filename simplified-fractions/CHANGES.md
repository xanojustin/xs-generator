# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/simplified_fractions.xs
**Result:** run.xs passed, simplified_fractions.xs failed

run.xs passed validation on first attempt.

simplified_fractions.xs failed with error:
```
[Line 18, Column 29] Expecting --> each <-- but found --> '
' <---
Code at line 18:
  while ($d <= $input.n) {
```

**Issue:** Missing `each { ... }` block inside `while` loops. XanoScript requires an `each` block as the body of a `while` loop.

---

## Validation 2 - Fixed while loop syntax

**Files changed:** function/simplified_fractions.xs
**Validation errors being addressed:** 
```
[Line 18, Column 29] Expecting --> each <-- but found --> '
' <---
```

**Diff:**
```diff
     while ($d <= $input.n) {
-      // Iterate through all possible numerators from 1 to d-1
+      each {
+        // Iterate through all possible numerators from 1 to d-1
```

Added `each { ... }` blocks to all three `while` loops in the function.

**Result:** Both files pass validation ✓
