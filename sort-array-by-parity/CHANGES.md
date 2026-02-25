# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/sort-array-by-parity/run.xs`
- `/Users/justinalbrecht/xs/sort-array-by-parity/function/sort_by_parity.xs`

**Result:** Fail - 1 error in function file

**Validation error:**
```
[Line 4, Column 24] Filter 'min_count' cannot be applied to input of type 'int'

Code at line 4:
  int[] nums filters=min_count:0
```

---

## Validation 2 - Remove invalid filter from array input

**Files changed:** `function/sort_by_parity.xs`

**Validation errors being addressed:** Filter 'min_count' cannot be applied to input of type 'int'

**Diff:**
```diff
  input {
-   int[] nums filters=min_count:0
+   int[] nums
  }
```

**Result:** Pass - Both files validated successfully

---
