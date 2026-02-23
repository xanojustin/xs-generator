# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/valid_anagram.xs
**Result:** Fail (3 errors)

### Errors Found:
1. [Line 10, Column 39] An expression should be wrapped in parentheses when combining filters and tests
2. [Line 16, Column 37] Unknown filter function 'str_split'
3. [Line 17, Column 37] Unknown filter function 'str_split'

**Code at this point:** Initial implementation with incorrect filter name and missing parentheses

---

## Validation 2 - Fixed filter name and parentheses

**Files changed:** function/valid_anagram.xs
**Validation errors being addressed:** 
- Changed `str_split` to `split` 
- Added parentheses around filtered expressions in the conditional

**Diff:**
```diff
     // If lengths differ, they cannot be anagrams
     conditional {
-      if ($input.s|strlen != $input.t|strlen) {
+      if (($input.s|strlen) != ($input.t|strlen)) {
         return { value = false }
       }
     }
 
     // Convert strings to character arrays
-    var $s_chars { value = $input.s|str_split:"" }
-    var $t_chars { value = $input.t|str_split:"" }
+    var $s_chars { value = $input.s|split:"" }
+    var $t_chars { value = $input.t|split:"" }
```

**Result:** Pass - Both files valid, 0 errors
