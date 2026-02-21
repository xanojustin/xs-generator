# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/longest_palindromic_substring.xs`
**Result:** FAIL (2 errors in function file)

**Errors found:**
1. `[Line 14, Column 30] An expression should be wrapped in parentheses when combining filters and tests`
   - Code: `if ($input.s|strlen == 0) {`
2. `[Line 15, Column 9] Expecting --> } <-- but found --> 'response' <--`
   - Code: `response = ""`

**Issue:** Used early return pattern with `response` inside conditional, and filter expression not wrapped in parentheses.

---

## Validation 2 - Fix early return and add parentheses

**Files changed:** `function/longest_palindromic_substring.xs`
**Validation errors being addressed:**
1. Expression not wrapped in parentheses
2. Early return pattern not supported

**Diff:**
```diff
-    // Handle empty string edge case
     conditional {
-      if ($input.s|strlen == 0) {
-        response = ""
+      if (($str_len <= 1)) {
+        var $result { value = $input.s }
+      }
+      else {
+        // Variables to track the longest palindrome found
```

**Result:** FAIL (5 errors - unknown filter 'substring')

---

## Validation 3 - Fix filter name from 'substring' to 'substr'

**Files changed:** `function/longest_palindromic_substring.xs`
**Validation errors being addressed:**
- `Unknown filter function 'substring'` at lines 35, 36, 68, 69, 101

**Diff:**
```diff
-                var $left_char { value = $input.s|substring:$left:1 }
+                var $left_char { value = $input.s|substr:$left:1 }

-                var $right_char { value = $input.s|substring:$right:1 }
+                var $right_char { value = $input.s|substr:$right:1 }

-                var $left2_char { value = $input.s|substring:$left2:1 }
+                var $left2_char { value = $input.s|substr:$left2:1 }

-                var $right2_char { value = $input.s|substring:$right2:1 }
+                var $right2_char { value = $input.s|substr:$right2:1 }

-          value = $input.s|substring:$start:$max_length
+          value = $input.s|substr:$start:$max_length
```

**Result:** PASS - All files valid

---

## Summary

Total validation cycles: 3
Key issues encountered:
1. Cannot use early return pattern - must set response at end
2. Filter expressions in conditionals need parentheses
3. String extraction uses `substr` not `substring`
