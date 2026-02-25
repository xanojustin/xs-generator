# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/third_maximum_number.xs
**Result:** Fail - 1 error in function file
**Validation errors being addressed:**
```
1. [Line 16, Column 34] Expecting --> } <-- but found --> ')' <--

Code at line 16:
  value = $input.nums|sort:"")
```

The `sort` filter syntax appears to be incorrect. I used `sort:""` but this seems to be the wrong syntax.

---

## Validation 2 - Replaced sort filter with manual bubble sort

**Files changed:** function/third_maximum_number.xs
**Validation errors being addressed:** Sort filter syntax error from Validation 1

**Diff:**
```diff
-     // Remove duplicates by converting to a set-like structure
-     // We'll sort and iterate to find distinct values
-     var $sorted {
-       value = $input.nums|sort:"")
-     }
-
-     // Extract distinct values in descending order
+     // Find distinct values by tracking unique numbers
     var $distinct {
       value = []
     }
 
-     var $prev {
-       value = null
-     }
-
-     // Iterate from end (highest values) to find distinct numbers
-     var $i {
-       value = ($sorted|count) - 1
-     }
-
-     while ($i >= 0) {
+     // Iterate through input to find distinct values
+     foreach ($input.nums) {
       each as $num {
-         var $current {
-           value = $sorted[$i]
+         // Check if number is already in distinct list
+         var $found {
+           value = false
          }
 
-         conditional {
-           if ($current != $prev) {
-             var.update $distinct {
-               value = $distinct|merge:[$current]
+         foreach ($distinct) {
+           each as $d {
+             conditional {
+               if ($d == $num) {
+                 var.update $found {
+                   value = true
+                 }
+               }
             }
-             var.update $prev {
-               value = $current
+           }
+         }
+
+         conditional {
+           if (!$found) {
+             var.update $distinct {
+               value = $distinct|merge:[$num]
              }
            }
          }
-
-         var.update $i {
-           value = $i - 1
-         }
        }
      }
    }
+
+     // Sort distinct values in descending order using bubble sort approach
+     ... (bubble sort implementation)
```

**Result:** Pass - Both files validated successfully

