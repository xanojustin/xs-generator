# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/snapshot_array.xs
**Result:** FAIL - 4 errors in snapshot_array.xs

**Errors:**
1. Line 58: An expression should be wrapped in parentheses when combining filters and tests
   - `value = $history|count - 1`
2. Line 74: Expected a comma, a new line or closing bracket
   - The `at:` parameter is not valid for merge filter
3-4. Related errors about the `at:` parameter syntax

---

## Validation 2 - Fixed array element update issues

**Files changed:** function/snapshot_array.xs

**Validation errors being addressed:**
- Used `at:` parameter which doesn't exist in XanoScript
- Arithmetic with filters needed parentheses

**Changes made:**
1. Changed data structure from array to object (using `{}`) to avoid in-place array updates
2. Used object merge with dynamic keys instead of array index updates
3. Added parentheses around filter expressions with arithmetic: `($history|count) - 1`

**Diff:**
```diff
-    // Initialize array - each element stores list of [snap_id, value] pairs
-    var $array { value = [] }
+    // Use an object to store array data - key is index, value is history of [snap_id, value]
+    var $data { value = {} }
```

```diff
-                var $array {
-                  value = $array|merge:[$history] at:$op.index
-                }
+                var $data_update { value = {} }
+                var $data_update {
+                  value = $data_update|merge_recursive:{
+                    $idx_key: $history
+                  }
+                }
+                var $data {
+                  value = $data|merge:$data_update
+                }
```

```diff
-                var $right {
-                  value = $history|count - 1
-                }
+                var $right {
+                  value = ($history|count) - 1
+                }
```

**Result:** PASS - All files validated successfully

---

## Validation 3 - Fixed object key syntax error

**Files changed:** function/snapshot_array.xs

**Validation errors being addressed:**
- Line 30: `Expecting --> : <-- but found --> '|'`
- Cannot use filter directly in object key position: `$i|to_text: [...]`

**Changes made:**
1. Extracted the key conversion to a separate variable
2. Used `merge_recursive` for proper object merging with dynamic keys

**Diff:**
```diff
-        var $data {
-          value = $data|merge:{
-            $i|to_text: [{ snap_id: -1, value: 0 }]
-          }
-        }
+        // Create the key as text
+        var $key_str { value = $i|to_text }
+        // Build the update object with the dynamic key
+        var $new_entry { value = {} }
+        var $new_entry {
+          value = $new_entry|merge_recursive:{
+            $key_str: [{ snap_id: -1, value: 0 }]
+          }
+        }
+        var $data {
+          value = $data|merge:$new_entry
+        }
```

**Result:** PASS - All files validated successfully