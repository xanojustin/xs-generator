# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function.xs`
**Result:** FAIL

Error:
```
1. [Line 18, Column 17] Expecting --> : <-- but found --> '=' <
--

💡 Suggestion: Use "int" instead of "integer" for type declaration

Code at line 18:
  gcd = 0
```

**Code at this point:** Using `=` for object property assignment instead of `:`

---

## Validation 2 - Fixed object literal syntax

**Files changed:** `function.xs`
**Validation errors being addressed:** Object literals need `:` not `=` for property assignment

**Diff:**
```diff
-          value = {
-            gcd = 0
-            lcm = 0
-          }
+          value = {
+            gcd: 0
+            lcm: 0
+          }
```

And:
```diff
-            gcd: $gcd_result
-            lcm: $lcm_result
+            gcd: $gcd_result
+            lcm: $lcm_result
```

**Result:** FAIL

Error:
```
1. [Line 25, Column 48] Expecting: one of these possible Token sequences:
  ...
  but found: '-'

Code at line 25:
  var $abs_a { value = ($input.a < 0) ? (-$input.a) : $input.a }
```

**Issue discovered:** Ternary operator (`?:`) is not supported in XanoScript

---

## Validation 3 - Replaced ternary with conditional blocks

**Files changed:** `function.xs`
**Validation errors being addressed:** Ternary operator not supported, replaced with `conditional` blocks

**Diff:**
```diff
-        // Calculate absolute values for GCD computation
-        var $abs_a { value = ($input.a < 0) ? (-$input.a) : $input.a }
-        var $abs_b { value = ($input.b < 0) ? (-$input.b) : $input.b }
+        // Calculate absolute values for GCD computation
+        conditional {
+          if ($input.a < 0) {
+            var $abs_a { value = -$input.a }
+          }
+          else {
+            var $abs_a { value = $input.a }
+          }
+        }
+        
+        conditional {
+          if ($input.b < 0) {
+            var $abs_b { value = -$input.b }
+          }
+          else {
+            var $abs_b { value = $input.b }
+          }
+        }
```

**Result:** FAIL

Error:
```
1. [Line 27, Column 34] Expecting: Expected an expression
but found: '-'

Code at line 27:
  var $abs_a { value = -$input.a }
```

**Issue discovered:** Unary negation (`-$var`) is not supported in XanoScript

---

## Validation 4 - Fixed unary negation

**Files changed:** `function.xs`
**Validation errors being addressed:** Unary negation not supported, use `0 - $var` instead

**Diff:**
```diff
-            var $abs_a { value = -$input.a }
+            var $abs_a { value = 0 - $input.a }
```

And:
```diff
-            var $abs_b { value = -$input.b }
+            var $abs_b { value = 0 - $input.b }
```

**Result:** PASS ✅

All files validated successfully!
