# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/regular-expression-matching.xs`

**Result:** Failed - 1 error in function file

**Validation errors:**
```
[Line 55, Column 47] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

---

## Validation 2 - Removed inline comments

**Files changed:** `function/regular-expression-matching.xs`

**Validation errors being addressed:** Inline comments after code on the same line are not supported by XanoScript parser

**Diff:**
```diff
- var $dp_idx { value = $prev_idx } // 0 * (p_len + 1) + (j - 2)
+ var $dp_idx { value = $prev_idx }

- var $curr_idx { value = $j } // 0 * (p_len + 1) + j
+ var $curr_idx { value = $j }
```

**Result:** ✅ Passed - both files valid

---
