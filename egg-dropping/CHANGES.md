# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/egg_dropping.xs`
**Result:** run.xs passed, egg_dropping.xs failed
**Validation errors being addressed:** 
```
[Line 39, Column 35] Expecting --> each <-- but found --> '\n'
```

---

## Validation 2 - Fixed While Loop Syntax

**Files changed:** `function/egg_dropping.xs`
**Validation errors being addressed:** While loops were missing required `each` blocks

**Diff:**
```diff
     while ($canCover < $input.n) {
-      var $attempts { value = $attempts + 1 }
+      each {
+        var $attempts { value = $attempts + 1 }
```

And similarly for the inner while loop:
```diff
       while ($egg >= 1) {
+        each {
         // dp[egg] = dp[egg-1]...
```

**Result:** ✓ Both files now pass validation

---
