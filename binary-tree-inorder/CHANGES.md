# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/binary_tree_inorder.xs`
**Result:** Fail

**Errors:**
1. `binary_tree_inorder.xs`: Line 12 - Using `object` type with schema for nested tree structure
   - Error: `Expecting: expecting at least one iteration which starts with one of these possible Token sequences...`
   - Suggestion: Use "json" instead of "object"

2. `run.xs`: Line 6 - Invalid syntax for input block
   - Error: `Expected an object {} but found: '{'`

---

## Validation 2 - Fixed Object Type and Nested Structure

**Files changed:** `function/binary_tree_inorder.xs`, `run.xs`

**Validation errors being addressed:**
- Function: Object type with schema doesn't work well for arbitrary nested structures
- Run job: Needed to use array-based representation instead of nested objects

**Changes:**

`function/binary_tree_inorder.xs`:
```diff
-   input {
-     object tree {
-       description = "Binary tree node with value, left, and right properties"
-       schema {
-         int value { description = "Node value" }
-         object left? { description = "Left child node (null if none)" }
-         object right? { description = "Right child node (null if none)" }
-       }
-     }
-   }
+   input {
+     // Using json type for the binary tree to allow arbitrary nested structure
+     json tree { description = "Binary tree node with value, left, and right properties" }
+   }
```

Also changed from recursive/iterative on nested objects to array-based representation with indices.

`run.xs`:
```diff
-   input: {
-     // Example tree:
-     //       1
-     //      / \
-     ...
-     tree: {
-       value: 1
-       left: { ... }
-       right: { ... }
-     }
-   }
+   input: {
+     // Array representation of tree (index 0 is root)
+     nodes: [
+       {value: 1, left: 1, right: 2}
+       ...
+     ]
+     root_index: 0
+   }
```

**Result:** Fail (1 valid, 1 invalid)
- Function file passed
- Run file still failing on input block

---

## Validation 3 - Removed Comments Inside Input Block

**Files changed:** `run.xs`

**Validation errors being addressed:**
- `run.xs`: Line 6, Column 12 - `Expected an object {} but found: '{'`
- Suspected cause: Comments inside the input object block

**Diff:**
```diff
   input: {
-     // Array representation of tree (index 0 is root)
-     // Node: {value, left_index, right_index} where null means no child
-     //       1
-     //      / \
-     //     2   3
-     //    / \
-     //   4   5
-     // In-order: 4, 2, 5, 1, 3
     nodes: [
-       {value: 1, left: 1, right: 2}
+       { value: 1, left: 1, right: 2 }
```

Also moved the tree diagram comments outside the run.job block entirely.

**Result:** Pass (2 valid, 0 invalid)
- Both files now validate successfully
