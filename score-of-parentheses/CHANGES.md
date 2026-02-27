# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/score_of_parentheses.xs`
**Result:** FAIL - 2 errors in function file

---

## Validation 2 - Fixed string length filter and substring syntax

**Files changed:** `function/score_of_parentheses.xs`

**Validation errors being addressed:**
```
1. [Line 18, Column 27] Unknown filter function 'length'
   Code: while ($i < ($input.s|length)) {

2. [Line 20, Column 40] Expecting --> ] <-- but found --> ':' <--
   Code: var $char { value = $input.s[$i:$i+1] }
```

**Diff:**
```diff
-    while ($i < ($input.s|length)) {
+    while ($i < ($input.s|strlen)) {
       each {
-        var $char { value = $input.s[$i:$i+1] }
+        var $char { value = $input.s|substr:$i:1 }
```

**Result:** PASS - Both files validated successfully

---

## Summary

**Issue:** Used incorrect XanoScript filter and substring syntax based on assumed patterns from other languages.

**Fix:**
- Changed `|length` to `|strlen` for string length
- Changed `$input.s[$i:$i+1]` (array-style slice) to `$input.s|substr:$i:1` (XanoScript filter syntax)

**Learned:** XanoScript uses filter-style operations with `|` and specific filter names like `strlen`, `substr`, `split`, etc. rather than property access or array indexing for strings.
