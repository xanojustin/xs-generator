# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/koko-eating-bananas/run.xs`
- `/Users/justinalbrecht/xs/koko-eating-bananas/function/koko_eating_bananas.xs`

**Result:** 
- run.xs: ✓ Pass
- koko_eating_bananas.xs: ✗ Fail

**Validation errors being addressed:**
```
1. [Line 10, Column 33] An expression should be wrapped in parentheses when combining filters and tests

Code at line 10:
  if ($input.piles|count == 0) {
```

---

## Validation 2 - Fixed filter expression parentheses

**Files changed:** `function/koko_eating_bananas.xs`

**Validation errors being addressed:** An expression should be wrapped in parentheses when combining filters and tests

**Diff:**
```diff
     conditional {
-      if ($input.piles|count == 0) {
+      if (($input.piles|count) == 0) {
         return { value = 0 }
       }
     }
```

**Result:** ✓ Pass - All files valid

---
