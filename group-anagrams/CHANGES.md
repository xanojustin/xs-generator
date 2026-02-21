# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/group_anagrams.xs`
**Result:** fail (2 errors in function)
**Code at this point:** Initial implementation

**Validation errors:**
1. `[Line 14, Column 35] An expression should be wrapped in parentheses when combining filters and tests`
   - Code: `if ($input.strings|count == 0) {`
   
2. `[Line 43, Column 51] Expecting: one of these possible Token sequences` (found 'signature')
   - Code: `var $grouped { value = $tagged_words|index_by:signature }`

---

## Validation 2 - Fixed filter expressions and index_by syntax

**Files changed:** `function/group_anagrams.xs`
**Validation errors being addressed:** 
1. Filter expression needs parentheses when comparing
2. `index_by` expects a quoted string, not a bare identifier

**Diff:**
```diff
-      if ($input.strings|count == 0) {
+      if (($input.strings|count) == 0) {
```

```diff
-    var $grouped { value = $tagged_words|index_by:signature }
+    var $grouped { value = $tagged_words|index_by:"signature" }
```

**Result:** pass (both files valid)

---
