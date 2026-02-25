# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:**
- `run.xs`
- `function/missing_ranges.xs`

**Result:** FAIL - 3 errors found

**Errors:**
1. `[Line 20, Column 30] Unknown filter function 'length'` - Used `|length` instead of `|count`
2. `[Line 24, Column 32] Unknown filter function 'length'` - Same issue
3. `[Line 46, Column 34] An expression should be wrapped in parentheses when combining filters and tests` - Missing parentheses around filtered expressions in concatenation

---

## Validation 2 - Fixed filter names and parentheses

**Files changed:** `function/missing_ranges.xs`

**Validation errors being addressed:**
1. Changed `$input.nums|length` to `($input.nums|count)` (2 occurrences)
2. Changed `$range_start|to_text ~ "->" ~ $range_end|to_text` to `($range_start|to_text) ~ "->" ~ ($range_end|to_text)`

**Diff:**
```diff
-     while ($i <= $input.nums|length) {
+     while ($i <= ($input.nums|count)) {
```

```diff
-           if ($i < $input.nums|length) {
+           if ($i < ($input.nums|count)) {
```

```diff
-                var $range_str { value = $range_start|to_text ~ "->" ~ $range_end|to_text }
+                var $range_str { value = ($range_start|to_text) ~ "->" ~ ($range_end|to_text) }
```

**Result:** PASS - All files valid

