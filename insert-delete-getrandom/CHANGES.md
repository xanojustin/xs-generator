# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/randomized_set.xs`

**Result:** Failed with 3 errors

**Errors:**
1. Unknown filter function 'has_key' (lines 24, 44)
2. Unknown filter function 'delete' (line 70)

---

## Validation 2 - Fixed object filter names

**Files changed:** `function/randomized_set.xs`

**Validation errors being addressed:** 
- Changed `has_key` to `has` for checking if object key exists
- Changed `delete` to `unset` for removing object key

**Diff:**
```diff
-   var $exists { value = $index_map|has_key:($val|to_text) }
+   var $exists { value = $index_map|has:($val|to_text) }

-   var $exists { value = $index_map|has_key:($val|to_text) }
+   var $exists { value = $index_map|has:($val|to_text) }

-   var.update $index_map { value = $index_map|delete:($val|to_text) }
+   var.update $index_map { value = $index_map|unset:($val|to_text) }
```

**Result:** ✅ PASS - Both files validated successfully