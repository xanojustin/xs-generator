# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/find_mode_in_bst.xs`

**Result:** Mixed - run.xs passed, function failed

**Validation errors:**
```
✗ find_mode_in_bst.xs: Found 1 error(s):

1. [Line 8, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--

💡 Suggestion: Use "json" instead of "object"

Code at line 8:
  object? left
```

---

## Validation 2 - Fixed input type from object? to json

**Files changed:** `function/find_mode_in_bst.xs`

**Validation errors being addressed:** The `object?` type with nullable marker in the input block schema was not valid syntax.

**Diff:**
```diff
   input {
-    object root {
-      description = "Root node of the binary search tree"
-      schema {
-        int? val
-        object? left
-        object? right
-      }
-    }
+    json root {
+      description = "Root node of the binary search tree (object with val, left, right)"
+    }
   }
```

**Result:** Both files now pass validation ✓

