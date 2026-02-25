# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/h_index.xs`
**Result:** FAIL
**Code at this point:** Initial implementation with sort filter

---

## Validation 2 - Fixed sort filter issue

**Files changed:** `function/h_index.xs`
**Validation errors being addressed:** 
```
[Line 16, Column 37] Expecting: one of these possible Token sequences:
but found: 'value'
Code at line 16:
  value = $input.citations|sort:value:desc
```

**Diff:**
```diff
-     // Sort citations in descending order
-     var $sorted_citations {
-       value = $input.citations|sort:value:desc
-     }
-     
-     // Initialize h-index to 0
-     var $h_index { value = 0 }
-     
-     // Iterate through sorted citations to find h-index
-     // h-index is the largest h such that h papers have at least h citations
-     var $i { value = 0 }
-     while ($i < ($sorted_citations|count)) {
-       each {
-         // Position in sorted array (1-indexed for h-index logic)
-         var $position { value = $i + 1 }
-         
-         // Get citation count at current position
-         var $citation_count {
-           value = $sorted_citations|get:$i
-         }
-         
-         // Check if this paper contributes to h-index
-         // A paper at position i (0-indexed) contributes if it has at least (i+1) citations
-         conditional {
-           if ($citation_count >= $position) {
-             var.update $h_index { value = $position }
-           }
-         }
-         
-         var.update $i { value = $i + 1 }
-       }
-     }
+     // Get total number of papers
+     var $n { value = $input.citations|count }
+     
+     // Initialize h-index to 0
+     var $h_index { value = 0 }
+     
+     // Try each possible h value from n down to 1
+     // h-index is the largest h such that at least h papers have >= h citations
+     var $h { value = $n }
+     while ($h > 0) {
+       each {
+         // Count how many papers have at least $h citations
+         var $count { value = 0 }
+         
+         var $i { value = 0 }
+         while ($i < $n) {
+           each {
+             var $citation {
+               value = $input.citations|get:$i
+             }
+             
+             conditional {
+               if ($citation >= $h) {
+                 var.update $count { value = $count + 1 }
+               }
+             }
+             
+             var.update $i { value = $i + 1 }
+           }
+         }
+         
+         // If at least h papers have >= h citations, we found our h-index
+         conditional {
+           if ($count >= $h) {
+             var.update $h_index { value = $h }
+             // Exit the outer while by setting h to 0
+             var.update $h { value = 0 }
+           }
+         }
+         
+         // Decrement h for next iteration (if we haven't found the answer yet)
+         conditional {
+           if ($h > 0) {
+             var.update $h { value = $h - 1 }
+           }
+         }
+       }
+     }
```

**Result:** PASS - Both files validated successfully

**Summary:** The `sort:field:type:direction` filter is designed for sorting arrays of objects by a specific field, not for sorting primitive arrays like `int[]`. The documentation shows the syntax as `sort:n:text:false` for objects with an `n` field. Rather than finding a workaround for sorting primitives, I rewrote the algorithm to use a counting-based approach that tries each possible h value from n down to 1 and counts how many papers have at least h citations.
