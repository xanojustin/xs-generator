# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/daily_temperatures.xs`
**Result:** fail (2 errors in function)

**Validation errors:**
1. [Line 35, Column 30] An expression should be wrapped in parentheses when combining filters and tests
   - Code: `if ($stack|count > 0) {`
2. [Line 44, Column 59] Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: `<[NewlineToken]>` but found: '/'
   - Code: `var $stack { value = $stack|slice:0:-1 }  // Pop from stack`

---

## Validation 2 - Fixed filter expression and inline comments

**Files changed:** `function/daily_temperatures.xs`
**Validation errors being addressed:** Filter expression without parentheses, inline comments causing parse errors

**Diff:**
```diff
-          if ($stack|count > 0) {
+          if (($stack|count) > 0) {
```

```diff
-                var $stack { value = $stack|slice:0:-1 }  // Pop from stack
+                // Pop from stack
+                var $stack { value = $stack|slice:0:-1 }
```

**Result:** fail (1 remaining error)

**Remaining validation error:**
1. [Line 53, Column 44] Inline comment still present
   - Code: `var $i { value = $i - 1 }  // Will be incremented at end`

---

## Validation 3 - Fixed remaining inline comment

**Files changed:** `function/daily_temperatures.xs`
**Validation errors being addressed:** Last inline comment causing parse error

**Diff:**
```diff
-                // Continue checking stack (don't increment i yet)
-                var $i { value = $i - 1 }  // Will be incremented at end
+                // Continue checking stack (don't increment i yet)
+                // Will be incremented at end of loop
+                var $i { value = $i - 1 }
```

**Result:** pass - both files valid

---

## Summary

**Key learnings:**
1. Filter expressions combined with operators must be wrapped in parentheses: `($stack|count) > 0`
2. XanoScript does NOT support inline comments (`//` after code on same line)
3. Comments must be on their own lines
