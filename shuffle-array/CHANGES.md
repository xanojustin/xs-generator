# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `~/xs/shuffle-array/run.xs`
- `~/xs/shuffle-array/function/shuffle_array.xs`

**Result:** 
- `run.xs`: ✓ Valid
- `shuffle_array.xs`: ✗ Error on line 13 - `math.random` not recognized

**Validation error:**
```
1. [Line 13, Column 26] Expecting: Expected an expression but found: 'math'
```

---

## Validation 2 - Fix random number generation

**Files changed:** `function/shuffle_array.xs`

**Validation errors being addressed:** `math.random` is not valid syntax

**Diff:**
```diff
- var $j { value = math.random(0, $i) }
+ // Generate random index from 0 to i using timestamp-based approach
+ var $timestamp { value = now|format_timestamp:"U":"UTC"|to_int }
+ var $j { value = ($timestamp % ($i + 1)) }
```

**Result:** ✓ Valid

---
