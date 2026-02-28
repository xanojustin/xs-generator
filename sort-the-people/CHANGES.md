# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/sort_the_people.xs`
**Result:** FAIL

**Validation errors:**
```
✗ sort_the_people.xs: Found 1 error(s):

1. [Line 40, Column 23] Unknown filter function 'order_by'

Code at line 40:
  value = $people|order_by:"height":"desc"
```

**Code at this point:** Used a non-existent `order_by` filter to sort the array.

---

## Validation 2 - Replaced order_by with manual bubble sort

**Files changed:** `function/sort_the_people.xs`
**Validation errors being addressed:** `Unknown filter function 'order_by'`
**Diff:**
```diff
-     // Sort people by height in descending order using order_by filter
-     var $sorted_people {
-       value = $people|order_by:"height":"desc"
-     }
-     
-     // Extract just the names from sorted people
-     var $sorted_names { value = [] }
-     
-     foreach ($sorted_people) {
-       each as $person {
-         var $sorted_names {
-           value = $sorted_names|merge:[$person.name]
-         }
-       }
-     }
+     // Sort people by height in descending order using bubble sort
+     var $n { value = $people|count }
+     
+     while ($n > 1) {
+       each {
+         var $i { value = 0 }
+         var $swapped { value = false }
+         
+         while ($i < $n - 1) {
+           each {
+             // Get adjacent people's heights
+             var $current_height { value = $people[$i].height }
+             var $next_height { value = $people[$i + 1].height }
+             
+             // Swap if current height < next height (for descending order)
+             conditional {
+               if ($current_height < $next_height) {
+                 // Perform swap of entire person objects
+                 var $temp { value = $people[$i] }
+                 var.update $people[$i] { value = $people[$i + 1] }
+                 var.update $people[$i + 1] { value = $temp }
+                 var $swapped { value = true }
+               }
+             }
+             
+             var.update $i { value = $i + 1 }
+           }
+         }
+         
+         // Reduce range since largest element is now at the end
+         var.update $n { value = $n - 1 }
+         
+         // If no swaps occurred, array is sorted
+         conditional {
+           if ($swapped == false) {
+             // Force exit by setting n to 1
+             var.update $n { value = 1 }
+           }
+         }
+       }
+     }
+     
+     // Extract just the names from sorted people
+     var $sorted_names { value = [] }
+     var $j { value = 0 }
+     
+     while ($j < ($people|count)) {
+       each {
+         var $sorted_names {
+           value = $sorted_names|merge:[$people[$j].name]
+         }
+         var.update $j { value = $j + 1 }
+       }
+     }
```
**Result:** PASS - Both files validated successfully
