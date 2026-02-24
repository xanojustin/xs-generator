# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `find_disappeared_numbers.xs`, `run.xs`
**Result:** FAIL
**Errors:**
- Line 21, Column 1: Expecting --> function <-- but found --> '\n' <--

**Issue:** The validator rejected the file due to blank lines between comment blocks and the function definition.

---

## Validation 2 - Remove blank lines before function

**Files changed:** `function/find_disappeared_numbers.xs`
**Validation errors being addressed:** 
```
Line 21, Column 1: Expecting --> function <-- but found --> '\n' <--
```

**Diff:**
```diff
  //   - See 2, mark nums[1] (already negative)
  //   - See 3, mark nums[2] (already negative)
  //   - See 1, mark nums[0] as negative: [-4, -3, -2, -7, 8, 2, -3, -1]
  //   - Indices 4 and 5 are positive, so missing numbers are 5 and 6
-
  function "find_disappeared_numbers" {
```

**Result:** FAIL
**New errors:**
- Line 3, Column 1: Expecting --> function <-- but found --> '\n' <--

Still failing - removed ALL blank lines between comment and function.

---

## Validation 3 - Remove blank line after comments

**Files changed:** `function/find_disappeared_numbers.xs`
**Validation errors being addressed:** 
```
Line 3, Column 1: Expecting --> function <-- but found --> '\n' <--
```

**Diff:**
```diff
  // Find All Numbers Disappeared in an Array
  // Given an array of integers where 1 <= nums[i] <= n (n = array length),
  // some elements appear twice and others appear once.
  // This solution uses the "mark as negative" technique to achieve O(n) time and O(1) space.
  //
  ... (long comment block removed for brevity)
  //   - Indices 4 and 5 are positive, so missing numbers are 5 and 6
-
  function "find_disappeared_numbers" {
+  function "find_disappeared_numbers" {
```

**Result:** FAIL
**New errors:**
- Line 13, Column 34: Unknown filter function 'length'

Progress! The blank line issue is resolved. Now hitting a syntax error.

---

## Validation 4 - Fix filter: use |count instead of |length

**Files changed:** `function/find_disappeared_numbers.xs`
**Validation errors being addressed:** 
```
Line 13, Column 34: Unknown filter function 'length'
```

**Diff:**
```diff
      // Create a mutable copy of the input array for marking
      var $marked_nums { value = $input.nums }
-     var $n { value = $input.nums|length }
+     var $n { value = $input.nums|count }
      var $i { value = 0 }
```

**Result:** PASS

**Files validated:** `find_disappeared_numbers.xs`, `run.xs`
**Result:** Both files valid ✓

---

## Summary

Total validation cycles: 4
Key issues learned:
1. XanoScript doesn't allow blank lines between comments and function definition
2. Array length is accessed via `|count`, not `|length`
