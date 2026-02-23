# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/validate_bst.xs`
**Result:** FAIL — 1 error in validate_bst.xs

**Error:**
```
[Line 9, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--
💡 Suggestion: Use "json" instead of "object"
```

**Code at line 9:**
```xs
object? left { schema { } }
```

---

## Validation 2 - Fixed nullable object type

**Files changed:** `function/validate_bst.xs`
**Validation errors being addressed:** The `object?` nullable syntax was not valid

**Diff:**
```diff
   input {
-    object tree {
-      description = "Binary tree represented as nested objects with val, left, and right properties"
-      schema {
-        int? val
-        object? left { schema { } }
-        object? right { schema { } }
-      }
+    json tree {
+      description = "Binary tree represented as nested objects with val, left, and right properties"
     }
```

**Result:** FAIL — 1 new error

**Error:**
```
[Line 31, Column 9] Expecting --> } <-- but found --> 'if' <--
```

---

## Validation 3 - Fixed conditional syntax in loops

**Files changed:** `function/validate_bst.xs`
**Validation errors being addressed:** Bare `if` statements inside loops need to be wrapped in `conditional` blocks

**Diff:**
```diff
         // Process current node if stack not empty
-        if (($stack|count) > 0) {
+        conditional {
+          if (($stack|count) > 0) {
             var $top { value = $stack|last }
             var $node { value = $top|get:"node" }
             var $new_stack { value = $stack|slice:0:(($stack|count) - 1) }
             var.update $stack { value = $new_stack }
             
             var $node_val { value = $node|get:"val" }
             
             // Check BST property: current value must be greater than previous
-            if ($prev_val != null) {
-              if ($node_val <= $prev_val) {
-                var.update $is_valid { value = false }
+            conditional {
+              if ($prev_val != null) {
+                conditional {
+                  if ($node_val <= $prev_val) {
+                    var.update $is_valid { value = false }
+                  }
+                }
               }
             }
             
             var.update $prev_val { value = $node_val }
             var.update $current { value = $node|get:"right" }
+          }
         }
```

**Result:** PASS — Both files valid

---

## Summary

**Total validation cycles:** 3
**Final status:** All files valid

**Key learnings:**
1. `object?` nullable syntax is not valid — use `json` type for flexible object structures
2. `if` statements must be wrapped in `conditional` blocks when used inside loops
3. Nested conditionals also require their own `conditional` wrapper
