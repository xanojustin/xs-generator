# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/verify_alien_dictionary.xs
**Result:** FAIL - 1 error in verify_alien_dictionary.xs
**Validation errors being addressed:**
```
[Line 77, Column 13] Expecting --> } <-- but found --> 'if' <--

Code at line 77:
  if ($len1 > $len2) {
```

**Issue:** Nested `if` statements inside a conditional block are not supported in XanoScript.

**Fix:** Changed nested if statements to use combined condition with `&&` operator.

**Diff:**
```diff
-        conditional {
-          if (!$order_determined) {
-            if ($len1 > $len2) {
-              // "apple" > "app" - not sorted
-              var.update $is_sorted { value = false }
-            }
-          }
-        }
+        conditional {
+          if (!$order_determined && $len1 > $len2) {
+            // "apple" > "app" - not sorted
+            var.update $is_sorted { value = false }
+          }
+        }
```

Also removed the `&& !$order_determined` from the while condition and replaced with internal conditional check.

---

## Validation 2 - Fixed nested if statements

**Files changed:** function/verify_alien_dictionary.xs
**Result:** PASS - All files valid
