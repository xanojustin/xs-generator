# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/heap_sort.xs`
**Result:** Fail (2 errors in function)

**Errors encountered:**
1. Unknown filter function 'set_index' (line 53, column 39)
2. Expecting '}' but found '$heap' (line 53, column 61)

**Code at this point:** Initial implementation using array with `set_index` filter for in-place element swapping

---

## Validation 2 - Changed from array to object-based approach

**Files changed:** `function/heap_sort.xs`

**Validation errors being addressed:**
- `set_index` filter doesn't exist in XanoScript for array manipulation
- XanoScript doesn't support in-place array modification at specific indices

**Diff:**
```diff
-    // Create a mutable copy of the input array
-    var $heap { value = $input.numbers }
...
-            // Swap elements
-            var $temp { value = $heap[$parent_idx] }
-            var $heap { value = $heap|set_index:$parent_idx,$heap[$largest] }
-            var $heap { value = $heap|set_index:$largest,$temp }
+    // Convert array to object with string keys for mutable access
+    var $heap { value = {} }
+    var $idx { value = 0 }
+    while ($idx < $n) {
+      each {
+        var $heap {
+          value = $heap|set:($idx|to_text):$input.numbers[$idx]
+        }
+        var.update $idx { value = $idx + 1 }
+      }
+    }
...
+            // Swap elements in the heap object
+            var $current_val { value = $heap|get:($current_idx|to_text) }
+            var $largest_val_swap { value = $heap|get:($largest|to_text) }
+            var $heap {
+              value = $heap|set:($current_idx|to_text):$largest_val_swap
+            }
+            var $heap {
+              value = $heap|set:($largest|to_text):$current_val
+            }
```

**Additional changes:**
- Converted input array to an object with string keys ("0", "1", "2", etc.)
- Used `set:(index|to_text):value` and `get:(index|to_text)` for element access and modification
- Added conversion back to array at the end using `push` filter

**Intermediate issue encountered:**
- Tried to define a helper function using backtick expressions: `var $get_heap_value = `...`` - this syntax is not valid in XanoScript
- Removed the helper function and inlined all logic

**Result:** Pass (both files valid)

---
