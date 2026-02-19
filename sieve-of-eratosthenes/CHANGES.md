# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** function.xs
**Result:** fail (3 errors)
**Code at this point:** Used `set_index` filter which doesn't exist

Errors:
- Unknown filter function 'set_index' at lines 23, 24, and 37

---

## Validation 2 - Fixed array index assignment

**Files changed:** function.xs
**Validation errors being addressed:**
```
1. [Line 23, Column 46] Unknown filter function 'set_index'
2. [Line 24, Column 46] Unknown filter function 'set_index'
3. [Line 37, Column 58] Unknown filter function 'set_index'
```

**Diff:**
```diff
     // 0 and 1 are not prime
-    var.update $is_prime { value = $is_prime|set_index:0:false }
-    var.update $is_prime { value = $is_prime|set_index:1:false }
+    var.update $is_prime { value = $is_prime|set:0:false }
+    var.update $is_prime { value = $is_prime|set:1:false }
```

```diff
             while ($multiple <= $input.n) {
               each {
-                var.update $is_prime { value = $is_prime|set_index:$multiple:false }
+                var.update $is_prime { value = $is_prime|set:$multiple:false }
                 var.update $multiple { value = $multiple + $p }
               }
             }
```

**Result:** pass (1 valid, 0 invalid)

**Key learning:** XanoScript uses `set` filter for array index assignment, not `set_index`. The syntax is `$array|set:index:value`.
