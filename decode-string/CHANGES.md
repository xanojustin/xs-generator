# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/decode_string.xs
**Result:** fail - 1 error in function/decode_string.xs
**Error:** `Unknown filter function 'length'` at line 21

---

## Validation 2 - Fixed string length filter

**Files changed:** function/decode_string.xs
**Validation errors being addressed:** 
```
1. [Line 21, Column 33] Unknown filter function 'length'
```
**Diff:**
```diff
-     while ($i < ($input.encoded|length)) {
+     while ($i < ($input.encoded|strlen)) {
```
**Result:** pass - both files validated successfully
