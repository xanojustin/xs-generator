# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:**
- `/Users/justinalbrecht/xs/reveal-cards-in-increasing-order/run.xs`
- `/Users/justinalbrecht/xs/reveal-cards-in-increasing-order/function/reveal_cards.xs`

**Result:** FAIL

**Errors:**
```
✗ reveal_cards.xs: Found 1 error(s):
1. [Line 9, Column 35] Expecting: one of these possible Token sequences:
   ... (long list of expected tokens) ...
   but found: 'int'

💡 Suggestion: Use "int" instead of integer for type declaration

Code at line 9:
  value = $input.deck|sort:$$:int:true
```

---

## Validation 2 - Fixed sort filter type syntax

**Files changed:** `function/reveal_cards.xs`

**Validation errors being addressed:**
- Parser error on `int` in sort filter — needed to quote the type name

**Diff:**
```diff
-      value = $input.deck|sort:$$:int:true
+      value = $input.deck|sort:$$:"int":true
```

**Result:** FAIL

**Errors:**
```
✗ reveal_cards.xs: Found 4 error(s):
1. [Line 37, Column 26] An expression should be wrapped in parentheses when combining filters and tests
2. [Line 42, Column 69] An expression should be wrapped in parentheses when combining filters and tests
3. [Line 47, Column 30] An expression should be wrapped in parentheses when combining filters and tests
4. [Line 52, Column 30] An expression should be wrapped in parentheses when combining filters and tests
```

---

## Validation 3 - Restructured to avoid complex filter expressions

**Files changed:** `function/reveal_cards.xs`

**Validation errors being addressed:**
- "An expression should be wrapped in parentheses when combining filters and tests"
- Complex expressions like `$queue|count - 1` and `$result|slice:($idx + 1):($result|count - $idx - 1)` caused issues

**Solution:** Restructured code to use intermediate variables instead of complex inline expressions:

**Diff (conceptual — full file rewrite):**
- Broke down complex filter chains into separate variable assignments
- Used intermediate variables like `$queue_count`, `$new_queue_count`, `$before`, `$after`, etc.
- Avoided arithmetic operations inside filter parameters

**Result:** PASS ✅

Both files validated successfully.
