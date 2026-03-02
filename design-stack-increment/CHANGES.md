# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/design_stack_increment.xs
**Result:** run.xs passed, function failed with 2 errors

Errors:
1. [Line 30, Column 35] An expression should be wrapped in parentheses when combining filters and tests
   Code: `if ($stack|count == 0) {`
   
2. [Line 34, Column 32] An expression should be wrapped in parentheses when combining filters and tests  
   Code: `var $top_idx { value = $stack|count - 1 }`

---

## Validation 2 - Fixed filter expression parentheses

**Files changed:** function/design_stack_increment.xs
**Validation errors being addressed:**
- Filter expressions combined with operators need parentheses

**Diff:**
```diff
-            if ($stack|count == 0) {
+            if (($stack|count) == 0) {
```

```diff
-                var $top_idx { value = $stack|count - 1 }
+                var $top_idx { value = ($stack|count) - 1 }
```

**Result:** ✓ All files valid
