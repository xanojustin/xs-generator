# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/find_celebrity.xs`
**Result:** fail (1 error in function)

**Errors found:**
- `[Line 7, Column 14] Expecting token of type --> Identifier <-- but found --> '['` in `int[][] matrix` type definition

**Issue:** XanoScript doesn't support `int[][]` syntax for 2D arrays

---

## Validation 2 - Fixed 2D Array Type

**Files changed:** `function/find_celebrity.xs`, `run.xs`
**Validation errors being addressed:** `int[][] matrix` parse error

**Changes made:**
1. Changed input type from `object knows_matrix { schema { int[][] matrix } }` to `json knows_matrix`
2. Updated all references from `$input.knows_matrix.matrix[...]` to `$input.knows_matrix[...]`
3. Updated `run.xs` to pass matrix directly instead of nested in `matrix` field

**Diff for function/find_celebrity.xs:**
```diff
   input {
-    object knows_matrix {
-      description = "Adjacency matrix where knows_matrix[i][j] = 1 if person i knows person j"
-      schema {
-        int[][] matrix
-      }
-    }
+    json knows_matrix {
+      description = "Adjacency matrix where knows_matrix[i][j] = 1 if person i knows person j"
+    }
     int n {
       description = "Number of people at the party"
-      filters = min:1
     }
   }
```

**Diff for function/find_celebrity.xs (matrix access):**
```diff
         var $candidate_knows {
-          value = $input.knows_matrix.matrix[$candidate][$i + 1]
+          value = $input.knows_matrix[$candidate][$i + 1]
         }
```

**Diff for run.xs:**
```diff
     input: {
-      knows_matrix: {
-        matrix: [
-          [0, 1, 1, 0],
-          [0, 0, 1, 0],
-          [0, 0, 0, 0],
-          [0, 1, 1, 0]
-        ]
-      }
+      knows_matrix: [
+        [0, 1, 1, 0],
+        [0, 0, 1, 0],
+        [0, 0, 0, 0],
+        [0, 1, 1, 0]
+      ]
       n: 4
```

**Result:** fail (2 new errors in function)

**Errors found:**
- `[Line 9, Column 7] The argument 'filters' is not valid in this context`
- `[Line 9, Column 17] Expecting: Expected a null but found: 'min'`

Issue: `filters = min:1` on int type inside input block is not valid syntax

---

## Validation 3 - Fixed Filters Syntax

**Files changed:** `function/find_celebrity.xs`
**Validation errors being addressed:** `filters = min:1` on int type error

**Changes made:**
Removed `filters = min:1` from the `int n` field and added a `precondition` in the stack for validation instead.

**Diff for function/find_celebrity.xs:**
```diff
   input {
     json knows_matrix {
       description = "Adjacency matrix where knows_matrix[i][j] = 1 if person i knows person j"
     }
     int n {
       description = "Number of people at the party"
-      filters = min:1
     }
   }
   stack {
+    // Validate n >= 1
+    precondition ($input.n >= 1) {
+      error_type = "inputerror"
+      error = "Number of people must be at least 1"
+    }
+
     // Edge case: only one person is a celebrity
```

**Result:** pass (both files valid)

---

## Summary

Total validation cycles: 3
Final status: All files valid

Key learnings:
1. XanoScript doesn't support 2D array types like `int[][]` - use `json` for nested arrays
2. `filters` attribute on primitive types in input blocks has specific limitations
3. Use `precondition` in the stack block for runtime validation instead
