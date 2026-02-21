# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/permutations.xs`

**Result:** FAIL - Found 2 error(s) in permutations.xs

**Validation errors:**
```
1. [Line 48, Column 27] An expression should be wrapped in parentheses when combining filters and tests
   while ($stack|count > 0) {

2. [Line 61, Column 47] An expression should be wrapped in parentheses when combining filters and tests
   if ($curr_perm|count == $input.nums|count) {
```

---

## Validation 2 - Fixed parentheses around filter expressions

**Files changed:** `function/permutations.xs`

**Validation errors being addressed:** 
- An expression should be wrapped in parentheses when combining filters and tests

**Diff:**
```diff
     // While stack is not empty
-    while ($stack|count > 0) {
+    while (($stack|count) > 0) {

...

         // If current permutation is complete (same length as input)
         conditional {
-          if ($curr_perm|count == $input.nums|count) {
+          if (($curr_perm|count) == ($input.nums|count)) {
```

**Result:** PASS - All 2 files valid

---
