# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial run.xs

**Files validated:** run.xs
**Result:** ✓ Valid
**Code at this point:** Initial creation of run.xs file

---

## Validation 2 - Initial function/target_sum.xs

**Files validated:** function/target_sum.xs
**Result:** ✗ Failed

**Validation errors:**
1. [Line 23, Column 53] Unary minus not supported directly - `-$total` causes parse error

**Diff:**
```diff
-      if ($input.target > $total || $input.target < -$total) {
+      var $neg_total { value = 0 - $total }
+      conditional {
+        if ($input.target > $total || $input.target < $neg_total) {
```

Also fixed second occurrence:
```diff
-          var $j { value = -$total }
+          var $j { value = 0 - $total }
```

---

## Validation 3 - After fixing unary minus

**Files validated:** function/target_sum.xs
**Result:** ✗ Failed

**Validation errors:**
1. [Line 39, Column 38] Unknown filter function 'length'
2. [Line 43, Column 26] Expecting --> each <-- but found --> newline

**Diff:**
```diff
-        var $n { value = $input.nums|length }
+        var $n { value = $input.nums|count }
```

---

## Validation 4 - After fixing |count filter

**Files validated:** function/target_sum.xs
**Result:** ✗ Failed

**Validation errors:**
1. [Line 43, Column 26] While loop body syntax error - missing `each` block

**Diff:**
```diff
         while ($i < $n) {
-          var $num { value = $input.nums[$i] }
-          ...
-          var $i { value = $i + 1 }
+          each {
+            var $num { value = $input.nums[$i] }
+            ...
+            var.update $i { value = $i + 1 }
+          }
         }
```

Also fixed nested while loop:
```diff
             while ($j <= $total) {
-              var $key { ... }
-              ...
-              var $j { value = $j + 1 }
+              each {
+                var $key { ... }
+                ...
+                var.update $j { value = $j + 1 }
+              }
             }
```

---

## Validation 5 - Final validation

**Files validated:** run.xs, function/target_sum.xs
**Result:** ✓ Valid (both files)

**Summary of fixes:**
1. Unary minus operator not supported - use `0 - $value` instead
2. Array length filter is `|count` not `|length`
3. While loops require `each { ... }` block for their body
4. Variable updates inside loops need `var.update` not `var`
