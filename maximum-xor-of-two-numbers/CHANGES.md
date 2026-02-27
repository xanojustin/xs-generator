# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`
**Result:** FAIL

Errors:
```
1. [Line 1, Column 9] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [Identifier]
but found: '{'
```

The run.job syntax was missing the job name string.

---

## Validation 2 - Added job name to run.job

**Files changed:** `run.xs`
**Validation errors being addressed:** run.job syntax missing name

**Diff:**
```diff
-run.job {
+run.job "Maximum XOR Test" {
   description = "Run job to test maximum XOR of two numbers solution"
```

**Result:** FAIL

Errors:
```
1. [Line 2, Column 3] The argument 'description' is not valid in this context
2. [Line 2, Column 3] Expected value of `description` to be `null`
3. [Line 10, Column 1] Redundant input, expecting EOF but found: function
```

---

## Validation 3 - Fixed run.xs structure and removed description, moved function to separate file

**Files changed:** `run.xs`, created `function/find_max_xor.xs`
**Validation errors being addressed:** description not valid in run.job, functions must be in separate files

**Diff in run.xs:**
```diff
-run.job "Maximum XOR Test" {
-  description = "Run job to test maximum XOR of two numbers solution"
-  
-  main = "find_max_xor"
-}
-
-function "find_max_xor" {
-  ... (entire function removed)
-}
+run.job "Maximum XOR Test" {
+  main = {
+    name: "find_max_xor"
+    input: {}
+  }
+}
```

**Result:** PASS for run.xs, but needed to validate find_max_xor.xs separately

---

## Validation 4 - Validated all files

**Files validated:** `run.xs`, `function/find_max_xor.xs`, `function/maximum_xor.xs`
**Result:** 
- run.xs: Valid
- find_max_xor.xs: Valid
- maximum_xor.xs: FAIL

Errors in maximum_xor.xs:
```
1. [Line 42, Column 30] Expecting: one of these possible Token sequences:
   ... (many token options)
   but found: '>'
```

Issue: XanoScript doesn't support bitwise operators `>>` and `&`.

---

## Validation 5 - Replaced bitwise operators with mathematical operations

**Files changed:** `function/maximum_xor.xs`
**Validation errors being addressed:** Bitwise operators (`>>` and `&`) not supported

**Diff:**
```diff
-            // Calculate bit: (num / 2^pos) % 2
-            var $bit_val { value = ($num >> $shift) & 1 }
+            // Get bit: (num / 2^pos) % 2
+            var $bit_val { value = ($num / $divisor) % 2 }
```

Also rewrote the entire algorithm to use:
- Division by 2 instead of right shift: `num / 2` instead of `num >> 1`
- Modulo 2 instead of AND 1: `num % 2` instead of `num & 1`
- Multiplication by 2 instead of left shift: `num * 2` instead of `num << 1`

**Result:** FAIL

Errors:
```
1. [Line 82, Column 20] Expecting --> as <-- but found --> '{' <--
```

---

## Validation 6 - Fixed for loop syntax with each

**Files changed:** `function/maximum_xor.xs`
**Validation errors being addressed:** `each` block missing `as $variable`

**Diff:**
```diff
             // Calculate 2^bit_pos using loop
             for ($bit_pos) {
-              each {
+              each as $j {
                 var.update $divisor { value = $divisor * 2 }
               }
             }
```

**Result:** PASS

---

## Final Validation - All Files

**Files validated:** `run.xs`, `function/find_max_xor.xs`, `function/maximum_xor.xs`
**Result:** All files valid ✓
