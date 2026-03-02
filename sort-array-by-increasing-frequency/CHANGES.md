# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/sort_by_frequency.xs
**Result:** Fail - 1 error in function/sort_by_frequency.xs

**Error:**
```
[Line 54, Column 37] Expecting: one of these possible Token sequences...
but found: '>'
Code at line 54:
  value = $items|sort:$a.freq <=> $b.freq || $b.num <=> $a.num
```

**Issue:** Tried to use PHP-style `<=>` spaceship operator for sorting, which doesn't exist in XanoScript.

---

## Validation 2 - Fixed sorting logic

**Files changed:** function/sort_by_frequency.xs
**Validation errors being addressed:** Used `<=>` spaceship operator which is not valid XanoScript syntax

**Diff:**
```diff
-     // Step 3: Sort by frequency ascending, then by value descending
-     var $sorted_items {
-       value = $items|sort:$a.freq <=> $b.freq || $b.num <=> $a.num
-     }
+     // Step 3: Sort by frequency ascending, then by value descending using bubble sort
+     var $n { value = $items|count }
+     var $i { value = 0 }
+     while ($i < $n - 1) {
+       each {
+         var $j { value = 0 }
+         while ($j < $n - $i - 1) {
+           each {
+             var $item_a { value = $items[$j] }
+             var $item_b { value = $items[$j + 1] }
+             
+             // Check if we need to swap
+             // Sort by freq ascending, then by num descending
+             var $should_swap { value = false }
+             
+             conditional {
+               // If freq_a > freq_b, swap (ascending order)
+               if ($item_a.freq > $item_b.freq) {
+                 var $should_swap { value = true }
+               }
+               // If frequencies are equal, check values (descending order)
+               elseif ($item_a.freq == $item_b.freq && $item_a.num < $item_b.num) {
+                 var $should_swap { value = true }
+               }
+             }
+             
+             conditional {
+               if ($should_swap) {
+                 // Swap items
+                 var $temp { value = $item_a }
+                 var.update $items[$j] { value = $item_b }
+                 var.update $items[$j + 1] { value = $temp }
+               }
+             }
+             
+             var.update $j { value = $j + 1 }
+           }
+         }
+         var.update $i { value = $i + 1 }
+       }
+     }
```

**Result:** Fail - 1 error in function/sort_by_frequency.xs

**Error:**
```
[Line 90, Column 17] Expecting --> } <-- but found --> 'if' <--
Code at line 90:
  if ($item_a.num < $item_b.num) {
```

**Issue:** Nested `if` inside `elseif` is not allowed. Need to combine conditions or restructure.

---

## Validation 3 - Fixed nested if in elseif

**Files changed:** function/sort_by_frequency.xs
**Validation errors being addressed:** Cannot nest `if` inside `elseif` block

**Diff:**
```diff
-               // If frequencies are equal, check values (descending order)
-               elseif ($item_a.freq == $item_b.freq) {
-                 if ($item_a.num < $item_b.num) {
-                   var $should_swap { value = true }
-                 }
-               }
+               // If frequencies are equal, check values (descending order)
+               elseif ($item_a.freq == $item_b.freq && $item_a.num < $item_b.num) {
+                 var $should_swap { value = true }
+               }
```

**Result:** Pass - Both files validated successfully

---
