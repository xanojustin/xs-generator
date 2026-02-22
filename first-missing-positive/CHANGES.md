# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `function/first_missing_positive.xs`
- `run.xs`

**Result:** FAIL - 2 errors

**Errors encountered:**

1. `first_missing_positive.xs` [Line 8, Column 1]: Expecting --> function <-- but found --> '
'
2. `run.xs` [Line 3, Column 1]: Expecting --> run <-- but found --> '
'

**Issue:** Multi-line block comments using `/* */` style (or the multi-line `//` comments) are not valid in XanoScript. Only single-line `//` comments are supported, and they cannot span multiple lines in a block.

---

## Validation 2 - Removed block comments

**Files changed:** 
- `function/first_missing_positive.xs`
- `run.xs`

**Validation errors being addressed:** Parser expected function/run keywords but found newline characters due to invalid comment format

**Diff:**
```diff
- /* Multi-line comment block at top of file */
- // Line 1 of multi-line comment
- // Line 2 of multi-line comment
- // ...

+ // (removed all comments, kept only code)
```

Actually the real diff was:

```diff
- // First Missing Positive - Find the smallest positive integer missing from the array
- // Given an unsorted integer array, return the smallest positive integer that is not present
- // 
- // Algorithm: For an array of size n, the answer must be in range [1, n+1]
- // We use the array itself as a hash map by placing each number in its "correct" position
- // (number x should be at index x-1). Then we scan to find first position where
- // the number doesn't match index+1.
-
- function "first_missing_positive" {
+ function "first_missing_positive" {
```

And for run.xs:
```diff
- // Run Job for First Missing Positive exercise
- // Tests the first_missing_positive function with various inputs
-
- run.job "First Missing Positive Test" {
+ run.job "First Missing Positive Test" {
```

**Result:** PASS - Both files valid

---

## Summary

The issue was that multi-line comments (even with `//` on each line) at the beginning of the file caused parsing errors. The XanoScript parser appears to be sensitive to leading newlines or comment blocks before the actual code construct.

**Lesson learned:** Keep XanoScript files minimal - avoid comment blocks at the top of files. Put documentation in README.md instead.
