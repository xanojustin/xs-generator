# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/sieve_of_eratosthenes.xs`
**Result:** Fail (5 errors in function)
**Code at this point:** Initial implementation using array with `set_index` and `get_index` filters

**Errors encountered:**
1. Unknown filter function 'set_index' (lines 25, 28, 54)
2. Unknown filter function 'get_index' (lines 45, 79)

---

## Validation 2 - Changed from array to object-based approach

**Files changed:** `function/sieve_of_eratosthenes.xs`
**Validation errors being addressed:** 
- `set_index` and `get_index` filters don't exist in XanoScript

**Diff:**
```diff
-    // Initialize array where index represents the number
-    // Value true = potentially prime, false = not prime
-    var $is_prime {
-      value = []
-    }
-    
-    // Initialize all entries as true (potential primes)
-    // We'll use indices 0 to limit (inclusive)
-    for (($input.limit + 1)) {
-      each as $i {
-        var $is_prime {
-          value = $is_prime|append:true
-        }
-      }
-    }
-    
-    // 0 and 1 are not prime
-    var.update $is_prime {
-      value = $is_prime|set_index:0:false
-    }
-    var.update $is_prime {
-      value = $is_prime|set_index:1:false
-    }
+    // Initialize object where key represents the number
+    // Value true = potentially prime, false = not prime
+    var $is_prime {
+      value = {}
+    }
+    
+    // Initialize all entries as true (potential primes)
+    var $idx {
+      value = 0
+    }
+    while ($idx <= $input.limit) {
+      each {
+        var.update $is_prime {
+          value = $is_prime|set:($idx|to_text):true
+        }
+        var.update $idx {
+          value = $idx + 1
+        }
+      }
+    }
+    
+    // 0 and 1 are not prime
+    var.update $is_prime {
+      value = $is_prime|set:"0":false
+    }
+    var.update $is_prime {
+      value = $is_prime|set:"1":false
+    }
```

**Additional changes:**
- Changed `set_index:$i` to `set:($i|to_text)` 
- Changed `get_index:$i` to `get:($i|to_text)`
- Changed loop initialization from `for` loop with `append` to `while` loop with `set`

**Result:** Pass (both files valid)

---