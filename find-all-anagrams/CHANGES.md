# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/find_all_anagrams.xs`
**Result:** FAIL (1 error in function file)

**Validation errors:**
```
1. [Line 4, Column 1] Expecting --> function <-- but found --> '
' <---
```

**Issue:** File-level comments with `//` before the function definition are not valid in XanoScript.

**Fix:** Removed the file-level comments at the top of the function file.

---

## Validation 2 - After removing file comments

**Files changed:** `function/find_all_anagrams.xs`
**Files validated:** `run.xs`, `function/find_all_anagrams.xs`
**Result:** FAIL (2 errors in function file)

**Validation errors:**
```
1. [Line 28, Column 1] conditional is missing the if statement
2. [Line 29, Column 7] Expecting --> } <-- but found --> 'while' <--
```

**Issue:** `while` loops cannot be nested inside `conditional` blocks. The parser expects an `if` statement after `conditional {`.

**Fix:** Moved `while` loops outside of `conditional` blocks and into the stack directly.

---

## Validation 3 - After fixing while loop placement

**Files changed:** `function/find_all_anagrams.xs`
**Files validated:** `run.xs`, `function/find_all_anagrams.xs`
**Result:** FAIL (1 error in function file)

**Validation errors:**
```
1. [Line 28, Column 26] Expecting --> each <-- but found --> '
' <--
```

**Issue:** `while` loops require an `each` block inside them in XanoScript.

**Fix:** Added `each { ... }` blocks inside all `while` loops.

---

## Validation 4 - After adding each blocks to while loops

**Files changed:** `function/find_all_anagrams.xs`
**Files validated:** `run.xs`, `function/find_all_anagrams.xs`
**Result:** FAIL (5 errors in function file)

**Validation errors:**
```
1. [Line 31, Column 39] Unknown filter function 'ord'
2. [Line 56, Column 39] Unknown filter function 'ord'
3. [Line 140, Column 44] Unknown filter function 'ord'
4. [Line 148, Column 40] Unknown filter function 'delete'
5. [Line 162, Column 46] Unknown filter function 'ord'
```

**Issues:**
1. `ord` filter doesn't exist in XanoScript (I was trying to get ASCII codes for characters)
2. `delete` filter doesn't exist for removing keys from objects

**Fix:** 
1. Instead of using character codes as keys, use `split:""` to convert strings to character arrays, then use the actual characters as keys
2. Instead of deleting keys, set their values to 0

---

## Validation 5 - Final

**Files changed:** `function/find_all_anagrams.xs`
**Files validated:** `run.xs`, `function/find_all_anagrams.xs`
**Result:** PASS ✅

Both files validated successfully.
