# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/surrounded_regions.xs` (initial attempt)
**Result:** FAIL

**Errors:**
```
1. [Line 5, Column 11] Expecting token of type --> Identifier <-- but found --> '[' <---
Code at line 5: text[][] board
```

**Issue:** Used `text[][]` for 2D array type which is not valid XanoScript syntax.

---

## Validation 2 - Fixed Array Type

**Files changed:** `function/surrounded_regions.xs` → renamed to `function/surrounded-regions.xs`
**Validation errors being addressed:** Array type syntax error
**Changes:**
- Changed `text[][] board` to `json board` (proper type for 2D arrays in XanoScript)
- Renamed file to use hyphens instead of underscores (matching project convention)

**Result:** FAIL

**Errors:**
```
1. [Line 57, Column 36] Expecting: Expected an expression but found: 'dfs_mark_safe'
Code at line 57: var $visited { value = dfs_mark_safe(...) }
```

**Issue:** Called helper function directly instead of using `function.run`.

---

## Validation 3 - Fixed Function Call Syntax

**Files changed:** `function/surrounded-regions.xs`
**Validation errors being addressed:** Function call syntax error
**Changes:**
- Changed direct function calls `dfs_mark_safe(...)` to proper `function.run "dfs-mark-safe" { input = {...} } as $result` syntax

**Result:** FAIL

**Errors:**
```
1. [Line 162, Column 1] Redundant input, expecting EOF but found: // Helper function...
```

**Issue:** XanoScript only allows ONE function definition per `.xs` file. Had multiple functions in one file.

---

## Validation 4 - Split Functions Into Separate Files

**Files changed:** Split `surrounded-regions.xs` into multiple files
**Validation errors being addressed:** Multiple functions in one file
**Diff:**
```diff
- Single file: surrounded-regions.xs with 3 functions
+ function/surrounded-regions.xs (main function)
+ function/dfs-mark-safe.xs (DFS helper)
+ function/set-visited.xs (utility helper)
```

**Result:** PASS ✓

**All files valid:**
- `/Users/justinalbrecht/xs/surrounded-regions/function/dfs-mark-safe.xs`
- `/Users/justinalbrecht/xs/surrounded-regions/function/set-visited.xs`
- `/Users/justinalbrecht/xs/surrounded-regions/function/surrounded-regions.xs`
- `/Users/justinalbrecht/xs/surrounded-regions/run.xs`

---

## Summary

Total validation cycles: 4
Key lessons learned:
1. Use `json` type for 2D arrays, not `text[][]`
2. Call functions using `function.run "name" { input = {} } as $result`
3. Only ONE function per `.xs` file
4. Function names use hyphens (not underscores) by convention
