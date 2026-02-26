# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/asteroid_collision.xs`
**Result:** Fail - 2 errors

1. Line 27: Expression should be wrapped in parentheses when combining filters and tests
2. Line 27: Expecting `each` but found `'`

**Code at this point:**
```xs
while ($survives && $current < 0 && ($stack|count) > 0 && $stack|last > 0) {
```

---

## Validation 2 - Fixed while loop parentheses

**Files changed:** `function/asteroid_collision.xs`
**Validation errors being addressed:** 
- Line 27: Expression should be wrapped in parentheses when combining filters and tests

**Diff:**
```diff
- while ($survives && $current < 0 && ($stack|count) > 0 && $stack|last > 0) {
+ while ($survives && $current < 0 && (($stack|count) > 0) && (($stack|last) > 0)) {
```

**Result:** Fail - 1 error remaining
- Line 27: Expecting `each` but found `'`

---

## Validation 3 - Fixed while loop body (added each block)

**Files changed:** `function/asteroid_collision.xs`
**Validation errors being addressed:**
- Line 27: Expecting `each` but found `'`

**Diff:**
```diff
- while ($survives && $current < 0 && (($stack|count) > 0) && (($stack|last) > 0)) {
-   // Get the top asteroid from stack
-   var $top {
-     value = $stack|last
-   }
-
-   conditional {
-     // Top asteroid is larger - current explodes
-     if ($top > ($current|abs)) {
-       var.update $survives { value = false }
-     }
-     // Both same size - both explode
-     elseif ($top == ($current|abs)) {
-       var.update $survives { value = false }
-       // Remove top from stack
-       var.update $stack { value = $stack|pop }
-     }
-     // Current asteroid is larger - top explodes
-     else {
-       // Remove top from stack (it explodes), continue checking
-       var.update $stack { value = $stack|pop }
-     }
-   }
- }
+ while ($survives && $current < 0 && (($stack|count) > 0) && (($stack|last) > 0)) {
+   each {
+     // Get the top asteroid from stack
+     var $top {
+       value = $stack|last
+     }
+
+     conditional {
+       // Top asteroid is larger - current explodes
+       if ($top > ($current|abs)) {
+         var.update $survives { value = false }
+       }
+       // Both same size - both explode
+       elseif ($top == ($current|abs)) {
+         var.update $survives { value = false }
+         // Remove top from stack
+         var.update $stack { value = $stack|pop }
+       }
+       // Current asteroid is larger - top explodes
+       else {
+         // Remove top from stack (it explodes), continue checking
+         var.update $stack { value = $stack|pop }
+       }
+     }
+   }
+ }
```

**Result:** Pass - both files validated successfully

---

## Final Validation - All Files

**Files validated:** 
- `run.xs` ✓
- `function/asteroid_collision.xs` ✓

**Result:** All files pass validation
