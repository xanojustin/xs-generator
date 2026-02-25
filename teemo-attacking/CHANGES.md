# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/teemo_attacking.xs`
**Result:** FAIL
**Error:** `[Line 15, Column 5] Expecting --> } <-- but found --> 'if'`

The issue was that `if` statements inside a stack block must be wrapped in a `conditional` block.

---

## Validation 2 - Fixed conditional blocks

**Files changed:** `function/teemo_attacking.xs`
**Validation errors being addressed:** Parse error on line 15 - `if` statement not in `conditional` block
**Diff:**
```diff
   stack {
-    // Handle empty time series case
-    if (($input.time_series|count) == 0) {
-      var $total_poison { value = 0 }
-    }
-    else {
+    // Handle empty time series case
+    conditional {
+      if (($input.time_series|count) == 0) {
+        var $total_poison { value = 0 }
+      }
+      else {
```
And nested `if` statements were also wrapped in `conditional` blocks throughout the file.

**Result:** PASS - All files valid

---

## Validation 3 - Run job validation

**Files validated:** `run.xs`
**Result:** PASS - File valid on first try
