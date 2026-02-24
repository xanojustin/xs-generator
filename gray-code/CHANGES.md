# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `~/xs/gray-code/run.xs`
- `~/xs/gray-code/function/gray_code.xs`

**Result:** 
- `run.xs`: ✓ Valid
- `gray_code.xs`: ✗ Invalid

**Validation errors being addressed:**
```
1. [Line 26, Column 35] Expecting: one of these possible Token sequences:
  ...
  but found: '<'

Code at line 26:
  var $add_val { value = 1 << ($i - 1) }
```

**Fix:** XanoScript does not support the `<<` bit-shift operator. Replaced with iterative multiplication to calculate 2^(i-1).

**Diff:**
```diff
-        // Calculate the value to add: 2^(i-1)
-        var $add_val { value = 1 << ($i - 1) }
+        // Calculate the value to add: 2^(i-1)
+        // Use iterative multiplication since bit-shift is not supported
+        var $add_val { value = 1 }
+        var $k { value = 1 }
+        while (`$k < $i`) {
+          each {
+            var.update $add_val { value = $add_val * 2 }
+            var.update $k { value = $k + 1 }
+          }
+        }
```

---

## Validation 2 - Fixed bit-shift operator

**Files changed:** `function/gray_code.xs`

**Result:** 
- `run.xs`: ✓ Valid
- `gray_code.xs`: ✓ Valid

**Status:** All files pass validation ✓

---
