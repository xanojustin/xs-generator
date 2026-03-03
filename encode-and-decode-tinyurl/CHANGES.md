# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/tinyurl_service.xs`

**Result:** FAIL

**Validation errors:**
```
✗ tinyurl_service.xs: Found 1 error(s):
1. [Line 61, Column 13] Expecting --> } <-- but found --> 'stack' <--

Code at line 61:
  stack {
```

**Issue:** Nested `stack` blocks inside `conditional` blocks are not allowed in XanoScript. I had `stack` blocks inside `if`/`else` blocks inside the main `stack` block.

---

## Validation 2 - Fixed Nested Stack Blocks

**Files changed:** `function/tinyurl_service.xs`

**Validation errors being addressed:** 
- `Expecting --> } <-- but found --> 'stack'`

**Diff:**
```diff
-        // Generate new short key
-        var $new_key { value = "" }
-        var $n { value = $key_counter }
-        
-        stack {
-          while ($n > 0) {
-            each {
-              var $remainder { value = $n % 62 }
-              var $char { value = $base62|substr:$remainder:1 }
-              var.update $new_key { value = $char ~ $new_key }
-              var.update $n { value = ($n / 62)|floor }
-            }
-          }
-        }
+    // Variables for encoding/decoding (declared at top of stack)
+    var $result { value = {} }
+    var $new_key { value = "" }
+    var $n { value = 0 }
+    ... (other variables)
+    
+    // In the conditional, use for loops instead:
+    for (6) {
+      each as $idx {
+        conditional {
+          if ($n > 0) {
+            var.update $remainder { value = $n % 62 }
+            var.update $char { value = $base62|substr:$remainder:1 }
+            var.update $new_key { value = $char ~ $new_key }
+            var.update $n { value = ($n / 62)|floor }
+          }
+        }
+      }
+    }
```

**Solution:** 
1. Moved all variable declarations to the top of the main `stack` block
2. Replaced `while` loops (which required nested `stack` blocks) with `for` loops that don't require `stack`
3. Used `conditional` blocks inside `for` loops to control execution

**Result:** ✅ PASS - Both files valid

---
