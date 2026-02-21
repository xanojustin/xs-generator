# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/best-time-to-buy-sell-stock/run.xs`
- `/Users/justinalbrecht/xs/best-time-to-buy-sell-stock/function/max_profit.xs`

**Result:** 
- run.xs: pass ✓
- max_profit.xs: fail ✗

**Validation errors:**
```
1. [Line 25, Column 49] Expecting --> each <-- but found --> '
' <--

Code at line 25:
  while ($index < ($input.prices|count)) {
```

**Issue:** Used `while` loop which is not valid XanoScript syntax

---

## Validation 2 - Fixed loop structure

**Files changed:** `function/max_profit.xs`

**Validation errors being addressed:** 
```
1. [Line 25, Column 49] Expecting --> each <-- but found --> '
' <--
```

**Diff:**
```diff
-     while ($index < ($input.prices|count)) {
-       var $current_price { 
-         value = $input.prices|slice:$index:($index + 1)|first
-       }
-       
-       // Calculate potential profit if we sell today
-       var $potential_profit { value = $current_price - $min_price }
-       
-       // Update max_profit if this is better
-       conditional {
-         if ($potential_profit > $max_profit) {
-           var $max_profit { value = $potential_profit }
-         }
-       }
-       
-       // Update min_price if current price is lower
-       conditional {
-         if ($current_price < $min_price) {
-           var $min_price { value = $current_price }
-         }
-       }
-       
-       var.update $index { value = $index + 1 }
-     }
+     foreach ($input.prices) {
+       each as $price {
+         // Skip first element (we need at least 2 days to make a transaction)
+         conditional {
+           if ($index > 0) {
+             // Calculate potential profit if we sell today
+             var $potential_profit { value = $price - $min_price }
+             
+             // Update max_profit if this is better
+             conditional {
+               if ($potential_profit > $max_profit) {
+                 var $max_profit { value = $potential_profit }
+               }
+             }
+             
+             // Update min_price if current price is lower
+             conditional {
+               if ($price < $min_price) {
+                 var $min_price { value = $price }
+               }
+             }
+           }
+         }
+         
+         var.update $index { value = $index + 1 }
+       }
+     }
```

**Result:** pass ✓
- run.xs: Valid
- max_profit.xs: Valid

---

## Summary

The main issue was attempting to use a `while` loop, which is not supported in XanoScript. The solution was to replace it with a `foreach` loop combined with a manual index counter, following the pattern used in other exercises like `two_sum`.
