# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** function.xs
**Result:** FAIL (4 errors)

### Errors Found:

1. `[Line 14, Column 33] An expression should be wrapped in parentheses when combining filters and tests`
   - Code: `if ($input.text|strlen == 0) {`
   
2. `[Line 29, Column 44] Unknown filter function 'ord'`
   - Code: `var $char_code { value = $char|ord }`
   
3. `[Line 41, Column 63] Unknown filter function 'chr'`
   - Code: `var.update $encrypted_char { value = $shifted|chr }`
   
4. `[Line 51, Column 63] Unknown filter function 'chr'`
   - Code: `var.update $encrypted_char { value = $shifted|chr }`

**Code at this point:** Used `ord` and `chr` filters (which don't exist in XanoScript) and had parentheses issue with filter expressions.

---

## Validation 2 - Fixed character code handling and parentheses

**Files changed:** function.xs
**Validation errors being addressed:** 
1. Wrapped filter expression in parentheses: `($input.text|strlen) == 0`
2. Replaced non-existent `ord`/`chr` filters with array-based lookup using predefined alphabet arrays

**Diff:**
```diff
-     conditional {
-       if ($input.text|strlen == 0) {
+     // Define alphabet arrays for character lookup
+     var $uppercase { value = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"] }
+     var $lowercase { value = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] }
+     
+     // Handle empty string case
+     conditional {
+       if (($input.text|strlen) == 0) {
```

```diff
-             var $char_code { value = $char|ord }
-             var $encrypted_char { value = $char }
-             
-             // Check if uppercase letter (A-Z: 65-90)
-             conditional {
-               if ($char_code >= 65 && $char_code <= 90) {
-                 var $shifted { value = $char_code + $normalized_shift }
-                 conditional {
-                   if ($shifted > 90) {
-                     var.update $shifted { value = $shifted - 26 }
-                   }
-                 }
-                 var.update $encrypted_char { value = $shifted|chr }
-               }
-               // Check if lowercase letter (a-z: 97-122)
-               elseif ($char_code >= 97 && $char_code <= 122) {
-                 var $shifted { value = $char_code + $normalized_shift }
-                 conditional {
-                   if ($shifted > 122) {
-                     var.update $shifted { value = $shifted - 26 }
-                   }
-                 }
-                 var.update $encrypted_char { value = $shifted|chr }
-               }
-             }
+             var $encrypted_char { value = $char }
+             var $found_index { value = -1 }
+             var $j { value = 0 }
+             
+             // Check if uppercase letter
+             while ($j < 26) {
+               each {
+                 conditional {
+                   if ($char == ($uppercase|get:$j)) {
+                     var.update $found_index { value = $j }
+                   }
+                 }
+                 var.update $j { value = $j + 1 }
+               }
+             }
+             
+             // If found in uppercase, apply shift
+             conditional {
+               if ($found_index >= 0) {
+                 var $new_index { value = ($found_index + $normalized_shift) % 26 }
+                 var.update $encrypted_char { value = $uppercase|get:$new_index }
+               }
+             }
+             
+             // If not found in uppercase, check lowercase
+             conditional {
+               if ($found_index < 0) {
+                 var.update $j { value = 0 }
+                 while ($j < 26) {
+                   each {
+                     conditional {
+                       if ($char == ($lowercase|get:$j)) {
+                         var.update $found_index { value = $j }
+                       }
+                     }
+                     var.update $j { value = $j + 1 }
+                   }
+                 }
+                 
+                 // If found in lowercase, apply shift
+                 conditional {
+                   if ($found_index >= 0) {
+                     var $new_index { value = ($found_index + $normalized_shift) % 26 }
+                     var.update $encrypted_char { value = $lowercase|get:$new_index }
+                   }
+                 }
+               }
+             }
```

**Result:** PASS - All files valid

---
