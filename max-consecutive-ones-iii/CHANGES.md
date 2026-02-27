# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** max_consecutive_ones_iii.xs, run.xs
**Result:** FAIL
**Errors found:**
- Line 24: `math.subtract` is not valid - should be `math.sub`

---

## Validation 2 - Fixed math operation name

**Files changed:** function/max_consecutive_ones_iii.xs
**Validation errors being addressed:** 
```
1. [Line 24, Column 22] Expecting: one of these possible Token sequences:
  1. [add]
  2. [div]
  3. [mod]
  4. [mul]
  5. [sub]
  6. [bitwise]
but found: 'subtract'
```
**Diff:**
```diff
-             math.subtract $zeros_count { value = 1 }
+             math.sub $zeros_count { value = 1 }
```
**Result:** PASS - All files valid ✓
