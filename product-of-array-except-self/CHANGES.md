# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/product-of-array-except-self/run.xs`
- `/Users/justinalbrecht/xs/product-of-array-except-self/function/product-of-array-except-self.xs`

**Result:** FAIL (2 files invalid)

**Errors:**
1. run.xs: `run.job {` - missing name and wrong syntax (run.job is not a block with stack)
2. function/product-of-array-except-self.xs: `if ($input.numbers|count == 0)` - filter expressions in conditionals need parentheses

---

## Validation 2 - Fixed run.job name and conditional parentheses

**Files changed:** 
- `run.xs`
- `function/product-of-array-except-self.xs`

**Validation errors being addressed:**
1. `run.xs: Found 1 error(s): [Line 1, Column 9] Expecting: one of these possible Token sequences... but found: '{'`
2. `product-of-array-except-self.xs: An expression should be wrapped in parentheses when combining filters and tests`

**Diff for run.xs:**
```diff
-run.job {
+run.job "test-product-of-array-except-self" {
```

**Diff for function/product-of-array-except-self.xs:**
```diff
-      if ($input.numbers|count == 0) {
+      if (($input.numbers|count) == 0) {
```
And:
```diff
-      if ($input.numbers|count == 1) {
+      if (($input.numbers|count) == 1) {
```

**Result:** PARTIAL (1 valid, 1 invalid)
- function/product-of-array-except-self.xs: ✅ valid
- run.xs: ❌ invalid - run.job doesn't use `description`, `stack`, `response` attributes

---

## Validation 3 - Rewrote run.job with correct syntax, created test harness function

**Files changed:** 
- `run.xs` (complete rewrite)
- Created `function/product-of-array-except-self-test.xs`

**Validation errors being addressed:**
```
run.xs: Found 4 error(s):
1. [Line 2, Column 3] The argument 'description' is not valid in this context
2. [Line 2, Column 3] Expected value of `description` to be `null`
3. [Line 4, Column 3] The argument 'stack' is not valid in this context
4. [Line 4, Column 9] Expecting: one of these possible Token sequences... but found: '{'
```

**Diff for run.xs:**
Complete rewrite from:
```xs
run.job "test-product-of-array-except-self" {
  description = "..."
  stack { ... }
  response = ...
}
```
To:
```xs
run.job "test-product-of-array-except-self" {
  main = {
    name: "product-of-array-except-self-test"
    input: {}
  }
}
```

**New file: function/product-of-array-except-self-test.xs**
Created a test harness function that calls the main function multiple times with different test cases, since run.job can only call one function with one set of inputs.

**Result:** ✅ PASS - All 3 files valid
