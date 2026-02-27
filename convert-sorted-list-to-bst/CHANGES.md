# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/convert_sorted_list_to_bst.xs`

**Result:** fail (2 errors)

**Errors found:**
1. `convert_sorted_list_to_bst.xs`: [Line 19, Column 1] Redundant input, expecting EOF but found: function
   - Code at line 19: `function "build_bst" {`
   
2. `run.xs`: [Line 4, Column 12] Expecting: Expected an object {} but found: '{'
   - Code at line 4: `input: {`

---

## Validation 2 - Separated helper function and fixed input syntax

**Files changed:** 
- `run.xs` - Fixed input syntax (was already correct, issue was with the second function in main file)
- `function/convert_sorted_list_to_bst.xs` - Removed embedded helper function, now calls external helper
- `function/build_bst_helper.xs` - Created new file for the recursive helper function

**Validation errors being addressed:**
1. "Redundant input, expecting EOF but found: function" - Each .xs file can only contain ONE function
2. The run.xs error was a cascading error from the first issue

**Diff for convert_sorted_list_to_bst.xs:**
```diff
- function "convert_sorted_list_to_bst" {
-   description = "Convert a sorted linked list to a height-balanced Binary Search Tree"
-   input {
-     int[] head { description = "Array representing sorted linked list values" }
-   }
-   stack {
-     // Helper function to build BST from array range
-     function.run "build_bst" {
-       input = {
-         values: $input.head
-         start: 0
-         end: ($input.head|count) - 1
-       }
-     } as $result
-   }
-   response = $result
- }
-
- function "build_bst" {
-   ...
- }
+ function "convert_sorted_list_to_bst" {
+   description = "Convert a sorted linked list to a height-balanced Binary Search Tree"
+   input {
+     int[] head { description = "Array representing sorted linked list values" }
+   }
+   stack {
+     // Helper: build BST recursively from array range
+     var $start { value = 0 }
+     var $end { value = ($input.head|count) - 1 }
+     
+     function.run "build_bst_helper" {
+       input = {
+         values: $input.head
+         start: $start
+         end: $end
+       }
+     } as $result
+   }
+   response = $result
+ }
```

**New file: build_bst_helper.xs**
```xs
function "build_bst_helper" {
  description = "Recursively build balanced BST from sorted array"
  input {
    int[] values
    int start
    int end
  }
  stack {
    conditional {
      if ($input.start > $input.end) {
        return { value = null }
      }
    }

    // Find middle element for root
    var $mid { value = ($input.start + $input.end) / 2 }

    // Get left subtree
    function.run "build_bst_helper" {
      input = {
        values: $input.values
        start: $input.start
        end: $mid - 1
      }
    } as $left

    // Get right subtree
    function.run "build_bst_helper" {
      input = {
        values: $input.values
        start: $mid + 1
        end: $input.end
      }
    } as $right

    // Create root node
    var $root {
      value = {
        val: $input.values|get:$mid
        left: $left
        right: $right
      }
    }
  }
  response = $root
}
```

**Result:** pass (all 3 files valid)

---
