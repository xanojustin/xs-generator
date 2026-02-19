# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/anagram-detection.xs`, `run.xs`
**Result:** FAIL

**Errors found:**
1. `[Line 10, Column 24] Unknown filter function 'length'`
2. `[Line 10, Column 48] Unknown filter function 'length'`
3. `[Line 17, Column 24] Unknown filter function 'length'`

**Issue:** Used `length` filter for string length, which doesn't exist in XanoScript.

---

## Validation 2 - Fixed `length` to `strlen`

**Files changed:** `function/anagram-detection.xs`
**Validation errors being addressed:** Unknown filter function 'length'

**Diff:**
```diff
-      if (($input.str1|length) != ($input.str2|length)) {
+      if (($input.str1|strlen) != ($input.str2|strlen)) {
...
-      if (($input.str1|length) == 0) {
+      if (($input.str1|strlen) == 0) {
```

**Result:** FAIL

**New errors found:**
1. `[Line 4, Column 28] Filter 'to_lower' cannot be applied to input of type 'text'`
2. `[Line 5, Column 28] Filter 'to_lower' cannot be applied to input of type 'text'`

**Issue:** Used `to_lower` as input filter, but the correct filter name is `lower` for input declarations.

---

## Validation 3 - Fixed `to_lower` to `lower`

**Files changed:** `function/anagram-detection.xs`
**Validation errors being addressed:** Filter 'to_lower' cannot be applied to input of type 'text'

**Diff:**
```diff
-    text str1 filters=trim|to_lower
-    text str2 filters=trim|to_lower
+    text str1 filters=trim|lower
+    text str2 filters=trim|lower
```

**Result:** PASS ✅

Both files validated successfully with no errors.
