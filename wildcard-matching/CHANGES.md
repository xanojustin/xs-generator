# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** function/wildcard_match.xs, run.xs
**Result:** FAIL
**Validation errors:**
```
✗ wildcard_match.xs: Found 1 error(s):
1. [Line 54, Column 42] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```
**Issue:** Inline comments (`//` at end of line) are not supported in XanoScript.

**Diff:**
```diff
- var $new_dp { value = [false] }  // dp[0] is always false for non-empty s
+ // dp[0] is always false for non-empty s
+ var $new_dp { value = [false] }
```

Also changed string indexing from `$input.s[$j]` to `$input.s|substr:$j:1` for proper character access.

---

## Validation 2 - Fixed inline comments and string indexing

**Files changed:** function/wildcard_match.xs
**Validation errors being addressed:** Inline comments caused parse errors; direct string indexing may not be valid
**Diff:**
```diff
- var $p_char { value = $input.p[$j] }
+ // Get character at position j using substring
+ var $p_char { value = $input.p|substr:$j:1 }
```

Applied same fix for all string character access points and moved all inline comments to separate lines.

**Result:** PASS - Both files validated successfully

