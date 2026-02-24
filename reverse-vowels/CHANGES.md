# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/reverse_vowels.xs`

**Result:** 
- `run.xs`: PASS ✓
- `function/reverse_vowels.xs`: FAIL - 2 errors

**Validation errors:**
1. [Line 47, Column 37] Unknown filter function 'merge_at'
2. [Line 47, Column 51] Expecting --> } <-- but found --> '$new_vowel'

**Code at error location:**
```xs
var $chars { value = $chars|merge_at:$idx,$new_vowel }
```

---

## Validation 2 - Fixed array element update using slice and merge

**Files changed:** `function/reverse_vowels.xs`

**Validation errors being addressed:** Unknown filter function 'merge_at'

**Diff:**
```diff
-        var $chars { value = $chars|merge_at:$idx,$new_vowel }
+        // Slice before index, add new vowel, slice after index
+        var $before { value = $chars|slice:0:$idx }
+        var $after { value = $chars|slice:($idx + 1):($chars|count) }
+        var $chars { value = $before|merge:[$new_vowel]|merge:$after }
```

**Result:** PASS ✓ - Both files valid

---
