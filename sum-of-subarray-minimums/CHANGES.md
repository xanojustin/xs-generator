# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/sum_of_subarray_minimums.xs
**Result:** fail
**Code at this point:** Initial implementation attempted to use `random` filter which doesn't exist in XanoScript. Changed exercise to sum-of-subarray-minimums instead.

---

## Validation 2 - Fix filter expression parentheses

**Files changed:** function/sum_of_subarray_minimums.xs
**Validation errors being addressed:** 
- An expression should be wrapped in parentheses when combining filters and tests
- Errors on lines 38, 43, 55, 83, 88, 100, 109

**Diff:**
```diff
- var $n { value = $input.arr|count }
+ var $n { value = ($input.arr|count) }

- while (($stack|count > 0) && ($input.arr[$stack|last] > $input.arr[$i])) {
+ while ((($stack|count) > 0) && ($input.arr[($stack|last)] > $input.arr[$i])) {

- while ($j < ($stack|count - 1)) {
+ while ($j < (($stack|count) - 1)) {

- if ($stack|count == 0) {
+ if (($stack|count) == 0) {

- value = $left|set:($i|to_text):($i - $stack|last)
+ value = $left|set:($i|to_text):($i - ($stack|last))

- value = $right|set:($i|to_text):($stack|last - $i)
+ value = $right|set:($i|to_text):(($stack|last) - $i)
```

**Result:** pass - both files valid

---
