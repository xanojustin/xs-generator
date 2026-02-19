# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** valid-parentheses.xs
**Result:** FAIL
**Errors:**
```
1. [Line 42, Column 13] Expecting --> } <-- but found --> 'each' <--
```

---

## Validation 2 - Fixed conditional block syntax

**Files changed:** valid-parentheses.xs
**Validation errors being addressed:** Using `each` blocks inside `conditional` blocks is not valid syntax. The `each` keyword is only for `while` loop bodies.

**Diff:**
```diff
-         conditional {
-           if (`$char == "("` || `$char == "["` || `$char == "{"`) {
-             each {
-               // Push to stack
-               var $new_stack {
-                 value = $stack|merge:[$char]
-               }
-               var.update $stack { value = $new_stack }
-             }
-           }
+         conditional {
+           if (`$char == "("` || `$char == "["` || `$char == "{"`) {
+             // Push to stack
+             var $new_stack {
+               value = $stack|merge:[$char]
+             }
+             var.update $stack { value = $new_stack }
+           }
```

**Result:** PASS

---
