# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/move_zeros.xs
**Result:** Fail (1 error)
**Code at this point:** Initial attempt using `int_array` type

**Validation errors:**
```
✗ move_zeros.xs: Found 1 error(s):
1. [Line 4, Column 5] Expecting --> } <-- but found --> 'int_array' <--
💡 Suggestion: Use "type[]" instead of "array"
```

---

## Validation 2 - Fixed array type syntax

**Files changed:** function/move_zeros.xs
**Validation errors being addressed:** `int_array` should be `int[]`
**Diff:**
```diff
   input {
-    int_array nums { description = "Array of integers to process" }
+    int[] nums { description = "Array of integers to process" }
   }
```
**Result:** Fail (1 error)

**Validation errors:**
```
✗ move_zeros.xs: Found 1 error(s):
1. [Line 16, Column 39] Expecting --> each <-- but found --> '\n' <--
```

---

## Validation 3 - Added `each` blocks to while loops

**Files changed:** function/move_zeros.xs
**Validation errors being addressed:** while loops need `each` blocks inside them
**Diff:**
```diff
     while ($i < ($input.nums|count)) {
-      if ($input.nums[$i] != 0) {
-        var $input.nums[$write_index] {
-          value = $input.nums[$i]
+      each {
+        conditional {
+          if ($input.nums[$i] != 0) {
+            var $input.nums[$write_index] {
+              value = $input.nums[$i]
+            }
+            var.update $write_index {
+              value = $write_index + 1
+            }
+          }
         }
-        var $write_index {
-          value = $write_index + 1
+        var.update $i {
+          value = $i + 1
         }
       }
-      var $i {
-        value = $i + 1
-      }
     }
```
**Result:** Fail (1 error)

**Validation errors:**
```
✗ move_zeros.xs: Found 1 error(s):
1. [Line 20, Column 17] Expecting: one of these possible Token sequences: ...but found: '$input'
💡 "$input" is a reserved variable name. Try a different name like "$my_input"
```

---

## Validation 4 - Created local copy of input array

**Files changed:** function/move_zeros.xs
**Validation errors being addressed:** Cannot modify `$input` directly, need local variable
**Diff:**
```diff
   stack {
+    // Create a local copy of the input array to modify
+    var $nums {
+      value = $input.nums
+    }
     // Use two-pointer approach: one for iteration, one for placement
```
**Result:** Fail (1 error)

**Validation errors:**
```
✗ move_zeros.xs: Found 1 error(s):
1. [Line 25, Column 22] Expecting: one of these possible Token sequences: ...but found: '['
```

---

## Validation 5 - Switched to functional approach

**Files changed:** function/move_zeros.xs
**Validation errors being addressed:** Array indexing syntax `$nums[$index]` doesn't work in var statements
**Diff:**
```diff
-    // Second pass: fill remaining positions with zeros
-    while ($write_index < ($nums|count)) {
-      each {
-        var $nums[$write_index] {
-          value = 0
-        }
-        var.update $write_index {
-          value = $write_index + 1
-        }
-      }
+    // Filter out zeros to get non-zero elements (maintains order)
+    array.filter ($nums) if ($this != 0) as $non_zeros
+    
+    // Count how many zeros we need to add
+    var $zero_count {
+      value = ($nums|count) - ($non_zeros|count)
+    }
+    
+    // Create an array of zeros using fill filter
+    var $zeros {
+      value = []|fill:$zero_count:0
+    }
+    
+    // Merge non-zeros with zeros
+    var $result {
+      value = $non_zeros|merge:$zeros
     }
```
**Result:** Fail (1 error)

**Validation errors:**
```
✗ move_zeros.xs: Found 1 error(s):
1. [Line 8, Column 18] Expecting --> ( <-- but found --> '$input' <--
💡 Suggestion: Use "json" instead of "map"
```

---

## Validation 6 - Fixed array.filter syntax

**Files changed:** function/move_zeros.xs
**Validation errors being addressed:** array.filter requires parentheses around the array variable
**Diff:**
```diff
-    // Filter out zeros to get non-zero elements (maintains order)
-    array.filter $input.nums if ($this != 0) as $non_zeros
+    // Create a local reference to the input array
+    var $nums {
+      value = $input.nums
+    }
+    
+    // Filter out zeros to get non-zero elements (maintains order)
+    array.filter ($nums) if ($this != 0) as $non_zeros
```
**Result:** Fail (1 error)

**Validation errors:**
```
✗ move_zeros.xs: Found 1 error(s):
1. [Line 21, Column 5] Expecting --> } <-- but found --> '(' <---
💡 Suggestion: Use "json" instead of "map"
```

---

## Validation 7 - Fixed range/map syntax to use fill filter

**Files changed:** function/move_zeros.xs
**Validation errors being addressed:** `(1..$zero_count)|map:0` syntax doesn't work at statement level
**Diff:**
```diff
-    // Create an array of zeros using range and map
-    (1..$zero_count)|map:0 as $zeros
+    // Create an array of zeros using fill filter
+    var $zeros {
+      value = []|fill:$zero_count:0
+    }
```
**Result:** Pass (2 valid, 0 invalid)

✅ Both files validated successfully!
