# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/max-diff.xs`
**Result:** FAIL
**Validation errors:**
```
1. [Line 10, Column 40] An expression should be wrapped in parentheses when combining filters and tests

Code at line 10:
  precondition ($input.nums|count >= 2) {
```

---

## Validation 2 - Fixed filter expression with parentheses

**Files changed:** `function/max-diff.xs`
**Validation errors being addressed:** Filter expression needs parentheses when combined with comparison

**Diff:**
```diff
-     precondition ($input.nums|count >= 2) {
+     precondition (($input.nums|count) >= 2) {
```

**Result:** PASS — All files validated successfully

