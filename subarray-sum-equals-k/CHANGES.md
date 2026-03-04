# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/subarray_sum_equals_k.xs`
**Result:** Pass (no errors)
**Code at this point:** Initial implementation using prefix sum with hash map approach

---

## Validation 2 - Run job validation

**Files changed:** `run.xs`
**Validation errors being addressed:** N/A - first validation of run.xs
**Result:** Pass (no errors)
**Code at this point:** Run job calling the function with test input `nums: [1, 1, 1], k: 2`

---

## Note on Original Exercise

**Original exercise attempted:** `bitwise-ors-of-subarrays`

**Why it was abandoned:** The `bor` (bitwise OR) filter does not exist in XanoScript. Validation failed with:
```
[Line 58, Column 48] Unknown filter function 'bor'
```

**Switched to:** `subarray-sum-equals-k` - a different exercise that uses prefix sums and hash maps without requiring bitwise operations.
