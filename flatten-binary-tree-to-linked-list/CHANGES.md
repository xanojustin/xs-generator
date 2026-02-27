# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:**
- `run.xs`
- `function/flatten_tree.xs`

**Result:** 
- `run.xs`: Pass
- `function/flatten_tree.xs`: Fail

**Error from function/flatten_tree.xs:**
```
1. [Line 8, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--

💡 Suggestion: Use "json" instead of "object"

Code at line 8:
  object? left
```

---

## Validation 2 - Fixed object schema with json type

**Files changed:** `function/flatten_tree.xs`

**Validation errors being addressed:**
```
[Line 8, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--
💡 Suggestion: Use "json" instead of "object"
```

**Diff:**
```diff
   input {
-    object tree {
-      description = "Binary tree node with val, left, and right properties"
-      schema {
-        int val
-        object? left
-        object? right
-      }
+    json tree {
+      description = "Binary tree node with val, left, and right properties"
     }
   }
```

**Result:** Pass
- `run.xs`: Valid
- `function/flatten_tree.xs`: Valid

---
