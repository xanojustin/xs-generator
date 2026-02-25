# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** function/fruit_into_baskets.xs, run.xs
**Result:** FAIL
**Validation errors being addressed:** 
- Line 64: Unknown filter function 'delete'

**Error message:**
```
✗ fruit_into_baskets.xs: Found 1 error(s):
1. [Line 64, Column 47] Unknown filter function 'delete'
Code at line 64:
  var $basket { value = $basket|delete:$left_key }
```

**Diff:**
```diff
-             // If count becomes 0, remove type from basket
-             conditional {
-               if ($new_left_count == 0) {
-                 var $basket { value = $basket|delete:$left_key }
-                 var $fruit_types { value = $fruit_types - 1 }
-               }
-             }
+             // If count becomes 0, we lost a fruit type
+             conditional {
+               if ($new_left_count == 0) {
+                 var $fruit_types { value = $fruit_types - 1 }
+               }
+             }
```

Also updated the logic to track previous count before incrementing:
```diff
-         // Check if this is a new fruit type
+         // Get current count for this fruit type (0 if not present)
+         var $prev_count { value = 0 }
          conditional {
-           if (!($basket|has:$fruit_key)) {
+           if ($basket|has:$fruit_key) {
+             var $prev_count { value = $basket|get:$fruit_key }
+           }
+         }
+
+         // Check if this is a new fruit type (count was 0)
+         conditional {
+           if ($prev_count == 0) {
              var $fruit_types { value = $fruit_types + 1 }
            }
          }

-         // Add fruit to basket
+         // Add fruit to basket (increment count)
          var $basket {
-           value = $basket|set:$fruit_key:($current_count + 1)
+           value = $basket|set:$fruit_key:($prev_count + 1)
          }
```

**Result:** PASS - Both files now validate successfully

---

## Validation 2 - After fix

**Files changed:** function/fruit_into_baskets.xs
**Validation errors being addressed:** Unknown filter function 'delete'
**Result:** PASS

Both files validate successfully:
- /Users/justinalbrecht/xs/fruit-into-baskets/function/fruit_into_baskets.xs ✅
- /Users/justinalbrecht/xs/fruit-into-baskets/run.xs ✅
