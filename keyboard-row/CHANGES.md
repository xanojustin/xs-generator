# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/keyboard-row.xs
**Result:** fail
**Validation errors:**
- Unknown filter function 'strpos' (4 occurrences)

---

## Validation 2 - Fixed strpos to contains

**Files changed:** function/keyboard-row.xs
**Validation errors being addressed:** `Unknown filter function 'strpos'`
**Diff:**
```diff
-        var $in_top { value = ($top_row|strpos:$first_char) != false }
-        var $in_middle { value = ($middle_row|strpos:$first_char) != false }
-        var $in_bottom { value = ($bottom_row|strpos:$first_char) != false }
+        var $in_top { value = $top_row|contains:$first_char }
+        var $in_middle { value = $middle_row|contains:$first_char }
+        var $in_bottom { value = $bottom_row|contains:$first_char }
...
-            var $char_in_row { value = ($target_row|strpos:$first_char) != false }
+            var $char_in_row { value = $target_row|contains:$first_char }
```
**Result:** pass - both files valid

---
