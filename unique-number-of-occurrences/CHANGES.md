# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/unique-number-of-occurrences/run.xs`
- `/Users/justinalbrecht/xs/unique-number-of-occurrences/function/unique_number_of_occurrences.xs`

**Result:** Fail (1 error in function file)

**Validation errors:**
```
1. [Line 16, Column 5] Expecting --> } <-- but found --> 'each' <--
```

**Issue:** Used `each` loop syntax incorrectly. The `each` keyword is used inside `foreach` or `for` loops to access the current item, not as a standalone loop construct.

---

## Validation 2 - Fixed loop syntax

**Files changed:** `function/unique_number_of_occurrences.xs`

**Validation errors being addressed:**
```
1. [Line 16, Column 5] Expecting --> } <-- but found --> 'each' <--
```

**Diff:**
```diff
     // Count occurrences of each number
-    each ($input.arr as $num) {
-      var $num_key { value = $num|to_text }
+    foreach ($input.arr) {
+      each as $num {
+        var $num_key { value = $num|to_text }
```

**Result:** Fail (1 error in function file)

**Validation errors:**
```
1. [Line 20, Column 30] Unknown filter function 'has_key'
```

---

## Validation 3 - Fixed object filter name

**Files changed:** `function/unique_number_of_occurrences.xs`

**Validation errors being addressed:**
```
1. [Line 20, Column 30] Unknown filter function 'has_key'
```

**Diff:**
```diff
         conditional {
-          if ($frequency_map|has_key:$num_key) {
+          if ($frequency_map|has:$num_key) {
```

**Result:** Pass (both files valid)

---

## Final State

All files validated successfully:
- `run.xs` ✅
- `function/unique_number_of_occurrences.xs` ✅
