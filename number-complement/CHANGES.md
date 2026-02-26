# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/number_complement.xs
**Result:** FAIL - 1 error in function/number_complement.xs
**Code at this point:** Baseline implementation with integer division using `//`

---

## Validation 2 - Fixed integer division operator

**Files changed:** function/number_complement.xs
**Validation errors being addressed:** 
```
[Line 23, Column 23] Expecting: one of these possible Token sequences:
but found: '/'
Code at line 23: value = $n // 2
```
**Diff:**
```diff
-          value = $n // 2
+          value = $n / 2
```
**Result:** FAIL - New error in for loop syntax

---

## Validation 3 - Fixed for loop syntax

**Files changed:** function/number_complement.xs
**Validation errors being addressed:**
```
[Line 34, Column 12] Expecting --> as <-- but found --> '{' <--
Code at line 34: each {
```
**Diff:**
```diff
-      each {
+      each as $i {
```
**Result:** FAIL - New error with math operation names

---

## Validation 4 - Fixed math operation names

**Files changed:** function/number_complement.xs
**Validation errors being addressed:**
```
[Line 35, Column 14] Expecting: one of these possible Token sequences:
  1. [add]
  2. [div]
  3. [mod]
  4. [mul]
  5. [sub]
  6. [bitwise]
but found: 'multiply'
```
**Diff:**
```diff
-        math.multiply $mask {
+        math.mul $mask {
           value = 2
         }
-    math.subtract $mask {
+    math.sub $mask {
```
**Result:** FAIL - XOR operator not supported

---

## Validation 5 - Replaced XOR with subtraction

**Files changed:** function/number_complement.xs
**Validation errors being addressed:**
```
[Line 46, Column 28] Expecting --> } <-- but found --> '$mask' <--
Code at line 46: value = $input.num ^ $mask
```
**Diff:**
```diff
-    // XOR with mask to flip bits
-    var $result {
-      value = $input.num ^ $mask
-    }
+    // Calculate complement: mask - num (since mask is all 1s)
+    var $result {
+      value = $mask - $input.num
+    }
```
**Result:** PASS - Both files valid

---

## Summary

Total validation cycles: 5
Key issues encountered:
1. `//` is not valid for integer division (use `/` instead)
2. `for` loops require `each as $variable` syntax
3. Math operations use short names: `math.mul`, `math.sub`, `math.add` (not `math.multiply`, `math.subtract`)
4. XOR operator `^` is not directly supported; use `math.bitwise` or alternative math approach
