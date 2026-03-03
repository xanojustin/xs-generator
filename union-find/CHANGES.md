# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/union_find.xs
**Result:** FAIL - `array.splice` does not exist in XanoScript
**Validation errors being addressed:**
```
[Line 74, Column 23] Expecting: one of these possible Token sequences:
but found: 'splice'
```

---

## Validation 2 - Changed from arrays to objects with set filter

**Files changed:** function/union_find.xs
**Validation errors being addressed:** `array.splice` is not a valid XanoScript filter
**Diff:**
```diff
-    // Initialize parent array: parent[i] = i (each element is its own parent)
-    var $parent { value = [] }
+    // Initialize parent object: parent[i] = i (each element is its own parent)
+    // Using object instead of array because XanoScript doesn't support array element updates
+    var $parent { value = {} }
     var $i { value = 0 }
     while ($i < $input.n) {
       each {
-        array.push $parent { value = $i }
+        var $key_i { value = $i|to_text }
+        var.update $parent { value = $parent|set:$key_i:$i }
         var.update $i { value = $i + 1 }
       }
     }
```

**Result:** ✅ PASS - Both files valid

---
