# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/build_array.xs`, `run.xs`
**Result:** FAIL
**Code at this point:** Baseline implementation with `while` loop

**Errors:**
- `[Line 15, Column 39] Expecting --> each <-- but found --> '\n'`
- The `while` loop is not valid XanoScript syntax

---

## Validation 2 - Replaced while loop with foreach + range

**Files changed:** `function/build_array.xs`
**Validation errors being addressed:** 
```
[Line 15, Column 39] Expecting --> each <-- but found --> '\n'
Code at line 15:
  while ($i < ($input.nums|count)) {
```

**Diff:**
```diff
-     while ($i < ($input.nums|count)) {
-       var $index {
-         value = $input.nums[$i]
-       }
-       var $value {
-         value = $input.nums[$index]
-       }
-       $result = $result|set:$i:$value
-       $i = $i + 1
+     foreach ((0..(($input.nums|count) - 1))) {
+       each as $i {
+         var $index {
+           value = $input.nums[$i]
+         }
+         var $value {
+           value = $input.nums[$index]
+         }
+         array.push $result {
+           value = $value
+         }
+       }
```

**Changes made:**
1. Replaced `while` loop with `foreach` using the range operator `(start..end)`
2. Used `array.push` instead of `set` filter to append to result array
3. Wrapped the range calculation in proper parentheses for filter precedence

**Result:** PASS — Both files validated successfully
