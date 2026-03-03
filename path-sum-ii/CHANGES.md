# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial run.xs

**Files validated:** run.xs
**Result:** pass
**Code at this point:** Baseline - initial implementation

---

## Validation 2 - Initial function/path_sum_ii.xs

**Files changed:** function/path_sum_ii.xs
**Validation errors being addressed:** First validation of the function
**Result:** fail

**Error:**
```
[Line 8, Column 19] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'

💡 Suggestion: Use "json" instead of "object"
```

**Code at line 8:**
```xs
object root { description = "Binary tree root node with val, left, right properties" }
```

---

## Validation 3 - Fixed input object type

**Files changed:** function/path_sum_ii.xs
**Validation errors being addressed:** Object type in input requires schema block
**Diff:**
```diff
  input {
-   object root { description = "Binary tree root node with val, left, right properties" }
+   object root {
+     description = "Binary tree root node with val, left, right properties"
+     schema {
+       int val { description = "Node value" }
+       object left { description = "Left child node" }
+       object right { description = "Right child node" }
+     }
+   }
    int target_sum { description = "Target sum for root-to-leaf paths" }
  }
```

**Result:** fail

**Error:**
```
[Line 12, Column 23] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'

💡 Suggestion: Use "json" instead of "object"
```

**Code at line 12:**
```xs
object left { description = "Left child node" }
```

---

## Validation 4 - Changed to json type for recursive structure

**Files changed:** function/path_sum_ii.xs
**Validation errors being addressed:** Nested object types in schema not supported
**Diff:**
```diff
  input {
-   object root {
-     description = "Binary tree root node with val, left, right properties"
-     schema {
-       int val { description = "Node value" }
-       object left { description = "Left child node" }
-       object right { description = "Right child node" }
-     }
-   }
+   json root { description = "Binary tree root node with val, left, right properties" }
    int target_sum { description = "Target sum for root-to-leaf paths" }
  }
```

**Result:** pass

**Note:** Changed from `object` with schema to `json` type for recursive tree structures, following the pattern used in other tree-based exercises like `binary_tree_inorder`.

---

## Summary

Total validation cycles: 4
- run.xs: passed on first try (1 cycle)
- function/path_sum_ii.xs: passed after 3 iterations
  - Lesson: Use `json` type for recursive/nested data structures instead of `object` with nested schema
