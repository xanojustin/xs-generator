# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/prison_cells.xs`
**Result:** FAIL
**Error:** Line 24, Column 50 - Expecting token of type Identifier but found '('

The issue was using bit shift operators `<<` and `>>` which are not supported in XanoScript.

Code at line 24:
```xs
var.update $state { value = $state | (1 << (7 - $i)) }
```

---

## Validation 2 - Fixed bit shift operators

**Files changed:** `function/prison_cells.xs`
**Validation errors being addressed:** Bit shift operators `<<` and `>>` are not valid XanoScript syntax

**Diff:**
Complete rewrite of the function to use array-based state representation instead of bit manipulation:

```diff
- // Convert initial state to a number for efficient storage
- var $state { value = 0 }
- var $i { value = 0 }
- while ($i < 8) {
-   each {
-     conditional {
-       if ($input.cells[$i] == 1) {
-         var.update $state { value = $state | (1 << (7 - $i)) }
-       }
-     }
-     var.update $i { value = $i + 1 }
-   }
- }
+ // Initialize current state from input
+ var $current { value = $input.cells }
```

Also changed cycle detection to use JSON-encoded arrays as keys instead of bit-packed integers:
```diff
- var $state_key { value = $current_state|to_text }
+ var $state_key { value = $current|json_encode }
```

And changed next state calculation to use array operations:
```diff
- var $left { value = ($current_state >> (8 - $j)) & 1 }
- var $right { value = ($current_state >> (6 - $j)) & 1 }
+ var $left { value = $current[$j - 1] }
+ var $right { value = $current[$j + 1] }
```

**Result:** PASS - Both `function/prison_cells.xs` and `run.xs` are valid

---
