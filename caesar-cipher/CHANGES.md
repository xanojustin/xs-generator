# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/caesar-cipher.xs`
**Result:** FAIL (1 valid, 1 invalid)

**Validation errors:**
```
✗ caesar-cipher.xs: Found 3 error(s):

1. [Line 23, Column 40] Unknown filter function 'to_char_code'
   var $char_code { value = $char|to_char_code }
   
2. [Line 35, Column 53] Unknown filter function 'from_char_code'
   var.update $new_char { value = $shifted|from_char_code }
   
3. [Line 45, Column 53] Unknown filter function 'from_char_code'
   var.update $new_char { value = $shifted|from_char_code }
```

**Code at this point:** Initial attempt using `to_char_code` and `from_char_code` filters which don't exist in XanoScript.

---

## Validation 2 - Replaced char code filters with alphabet arrays

**Files changed:** `function/caesar-cipher.xs`
**Validation errors being addressed:** Unknown filter functions `to_char_code` and `from_char_code`

**Diff:**
```diff
-     var $char_code { value = $char|to_char_code }
-     var $new_char { value = $char }
-     
-     conditional {
-       // Uppercase letters (A-Z: 65-90)
-       if (`$char_code >= 65 && $char_code <= 90`) {
-         var $shifted { value = $char_code + $shift }
-         conditional {
-           if ($shifted > 90) {
-             var.update $shifted { value = $shifted - 26 }
-           }
-         }
-         var.update $new_char { value = $shifted|from_char_code }
-       }
-       // Lowercase letters (a-z: 97-122)
-       elseif (`$char_code >= 97 && $char_code <= 122`) {
-         var $shifted { value = $char_code + $shift }
-         conditional {
-           if ($shifted > 122) {
-             var.update $shifted { value = $shifted - 26 }
-           }
-         }
-         var.update $new_char { value = $shifted|from_char_code }
-       }
-     }
+     var $found { value = false }
+     var $j { value = 0 }
+     
+     // Check uppercase letters
+     while ($j < 26 && !$found) {
+       each {
+         conditional {
+           if (`$char == $uppercase[$j]`) {
+             var $new_index { value = ($j + $shift) % 26 }
+             var $new_char { value = $uppercase[$new_index] }
+             var.update $encoded { value = $encoded ~ $new_char }
+             var.update $found { value = true }
+           }
+         }
+         var.update $j { value = $j + 1 }
+       }
+     }
+     
+     // Check lowercase letters (only if not found in uppercase)
+     conditional {
+       if (!$found) {
+         var $k { value = 0 }
+         while ($k < 26) {
+           each {
+             conditional {
+               if (`$char == $lowercase[$k]`) {
+                 var $new_index { value = ($k + $shift) % 26 }
+                 var $new_char { value = $lowercase[$new_index] }
+                 var.update $encoded { value = $encoded ~ $new_char }
+                 var.update $found { value = true }
+               }
+             }
+             var.update $k { value = $k + 1 }
+           }
+         }
+       }
+     }
+     
+     // If not a letter, keep the character as-is
+     conditional {
+       if (!$found) {
+         var.update $encoded { value = $encoded ~ $char }
+       }
+     }
```

**Result:** PASS (2 valid, 0 invalid)

Both files now pass validation.
