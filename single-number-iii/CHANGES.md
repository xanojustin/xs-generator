# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/single_number_iii.xs`
**Result:** FAIL

**Errors:**
```
1. [Line 19, Column 49] Expecting --> } <-- but found --> '$num' <--

Code at line 19:
  var $xor_result { value = $xor_result ^ $num }
```

**Code at this point:**
- Used `var $xor_result { value = $xor_result ^ $num }` inside foreach loop
- Tried to update existing variable using `var` instead of `var.update`

---

## Validation 2 - Fixed variable update syntax

**Files changed:** `function/single_number_iii.xs`
**Validation errors being addressed:** Cannot use `var` to update existing variable, must use `var.update`

**Diff:**
```diff
-        var $xor_result { value = $xor_result ^ $num }
+        var.update $xor_result { value = $xor_result ^ $num }
```

**Result:** FAIL

**Errors:**
```
1. [Line 19, Column 56] Expecting --> } <-- but found --> '$num' <--
```

---

## Validation 3 - Tried using $this instead of named variable

**Files changed:** `function/single_number_iii.xs`
**Validation errors being addressed:** Parser not recognizing loop variable in expression

**Diff:**
```diff
-        var.update $xor_result { value = $xor_result ^ $num }
+        var.update $xor_result { value = $xor_result ^ $this }
```

**Result:** FAIL

**Errors:**
```
1. [Line 19, Column 56] Expecting --> } <-- but found --> '$this' <--
```

---

## Validation 4 - Tried computing in temp variable first

**Files changed:** `function/single_number_iii.xs`
**Validation errors being addressed:** Parser not recognizing variables inside var.update expressions

**Diff:**
```diff
-        var.update $xor_result { value = $xor_result ^ $num }
+        var $new_xor { value = $xor_result ^ $num }
+        var.update $xor_result { value = $new_xor }
```

**Result:** FAIL

**Errors:**
```
1. [Line 19, Column 46] Expecting --> } <-- but found --> '$num' <--
```

**Note:** Error moved to line 19 (the new line), suggesting the issue is with the XOR operator `^` in expressions.

---

## Validation 5 - Tried with constants only

**Files changed:** `function/single_number_iii.xs`
**Validation errors being addressed:** Narrowing down whether issue is with variable scope or XOR operator

**Diff:**
```diff
-        var $new_xor { value = $xor_result ^ $num }
+        var $current { value = 5 }
+        var $new_xor { value = $xor_result }
```

**Result:** FAIL

**Errors:**
```
1. [Line 28, Column 39] Expecting --> } <-- but found --> '(' <--

Code at line 28:
  var $diff { value = $xor_result & (-$xor_result) }
```

**Note:** Error moved to a different line - the `&` (bitwise AND) and `-` (negation) operators are not valid syntax.

---

## Validation 6 - Used XanoScript bitwise operations

**Files changed:** `function/single_number_iii.xs`
**Validation errors being addressed:** XanoScript doesn't use `^`, `&`, `-` operators for bit manipulation; uses `math.bitwise.xor`, `math.bitwise.and`, and filters

**Diff:**
```diff
-    // Step 1: XOR all numbers to get XOR of the two single numbers
-    // Since x ^ x = 0, all pairs cancel out, leaving only a ^ b
-    var $xor_result { value = 0 }
-    
-    foreach ($input.nums) {
-      each as $num {
-        var $current { value = 5 }
-        var $new_xor { value = $xor_result }
-        var.update $xor_result { value = $new_xor }
-      }
-    }
+    // Step 1: XOR all numbers to get XOR of the two single numbers
+    // Since x ^ x = 0, all pairs cancel out, leaving only a ^ b
+    var $xor_result { value = 0 }
+    
+    foreach ($input.nums) {
+      each as $num {
+        math.bitwise.xor $xor_result { value = $num }
+      }
+    }
     
-    // Step 2: Find the rightmost set bit in xor_result
-    // This bit is different between the two single numbers
-    // We use: diff = xor_result & (-xor_result) to get the rightmost set bit
-    var $diff { value = $xor_result & (-$xor_result) }
+    // Step 2: Find the rightmost set bit in xor_result
+    // This bit is different between the two single numbers
+    // Formula: diff = x & (-x), where -x is two's complement = ~x + 1
+    // First, get -xor_result using bitwise_not and add 1
+    var $neg_xor { 
+      value = ($xor_result|bitwise_not)|add:1 
+    }
+    
+    // Then calculate diff = xor_result & (-xor_result)
+    var $diff { value = $xor_result }
+    math.bitwise.and $diff { value = $neg_xor }
     
-    // Step 3: Partition numbers into two groups based on this bit
-    // and XOR each group separately
-    var $num1 { value = 0 }
-    var $num2 { value = 0 }
-    
-    foreach ($input.nums) {
-      each as $n {
-        var $current_n { value = 3 }
-        conditional {
-          if (($current_n & $diff) != 0) {
-            var $new_num1 { value = $num1 }
-            var.update $num1 { value = $new_num1 }
-          }
-          else {
-            var $new_num2 { value = $num2 }
-            var.update $num2 { value = $new_num2 }
-          }
-        }
-      }
-    }
+    // Step 3: Partition numbers into two groups based on this bit
+    // and XOR each group separately
+    var $num1 { value = 0 }
+    var $num2 { value = 0 }
+    
+    foreach ($input.nums) {
+      each as $n {
+        // Check if the bit is set: (n & diff) != 0
+        var $bit_check { value = $n }
+        math.bitwise.and $bit_check { value = $diff }
+        
+        conditional {
+          if ($bit_check != 0) {
+            math.bitwise.xor $num1 { value = $n }
+          }
+          else {
+            math.bitwise.xor $num2 { value = $n }
+          }
+        }
+      }
+    }
```

**Result:** PASS ✓

Both `function/single_number_iii.xs` and `run.xs` validated successfully.