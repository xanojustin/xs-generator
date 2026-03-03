# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`
**Result:** Pass
**Code at this point:** Initial version of run.xs created

---

## Validation 2 - Initial function validation

**Files changed:** `function/odd_even_linked_list.xs`
**Validation errors being addressed:** First attempt at function
**Result:** Failed

**Errors:**
```
1. [Line 57, Column 17] Expecting: one of these possible Token sequences:
   but found: '$input'
```

**Issue:** `$input` is a reserved variable name. I was trying to reassign to `$input.nodes` which is not allowed.

**Diff:**
```diff
-    var $input.nodes { value = $nodes }
+    // Create a working copy of nodes that we can modify
+    var $nodes { value = $input.nodes }
```

And all subsequent references to `$input.nodes` changed to `$nodes`.

---

## Validation 3 - Fixed reserved variable issue

**Files changed:** `function/odd_even_linked_list.xs`
**Validation errors being addressed:** Reserved variable name error from Validation 2
**Diff:**
```diff
-    var $input.nodes { value = $nodes }
+    var $nodes { value = $input.nodes }
```

**Result:** Pass - both `run.xs` and `function/odd_even_linked_list.xs` are now valid
