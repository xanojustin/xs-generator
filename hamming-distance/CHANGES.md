# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/hamming_distance.xs`
**Result:** FAIL
**Code at this point:** (baseline)

---

## Validation 2 - Fixed bitwise operators

**Files changed:** `function/hamming_distance.xs`
**Validation errors being addressed:**
```
1. [Line 10, Column 26] Expecting --> } <-- but found --> '$input' <--
```

**Issue:** Used `^` operator for XOR instead of XanoScript filter syntax

**Diff:**
```diff
  stack {
    // XOR the two numbers to find bits that differ
    var $xor_result {
-      value = $input.x ^ $input.y
+      value = $input.x|bitwise_xor:$input.y
    }
```

Also fixed bitwise AND from `&` operator to `|bitwise_and:` filter:
```diff
        // Clear the least significant bit: n = n & (n - 1)
        var $n_minus_1 {
          value = $n - 1
        }
        var $n {
-          value = $n & $n_minus_1
+          value = $n|bitwise_and:$n_minus_1
        }
```

**Result:** PASS - Both files validated successfully
