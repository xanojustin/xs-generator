# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/minimum_swaps_to_sort.xs`
**Result:** fail
**Errors:**
1. Line 9: `($input.arr|count <= 1)` - An expression should be wrapped in parentheses when combining filters and tests
2. Line 49: `while ($idx < ($input.arr|count))` - Expecting `each` but found `'

---

## Validation 2 - Fixed filter parentheses

**Files changed:** `function/minimum_swaps_to_sort.xs`
**Validation errors being addressed:**
1. Line 9: Need parentheses around `$input.arr|count`

**Diff:**
```diff
  // Handle edge cases
  conditional {
-   if ($input.arr|count <= 1) {
+   if (($input.arr|count) <= 1) {
      return { value = 0 }
    }
  }
```

**Result:** fail - still has while loop error

---

## Validation 3 - Fixed while loops to include each blocks

**Files changed:** `function/minimum_swaps_to_sort.xs`
**Validation errors being addressed:**
- Line 49: While loops need `each` blocks inside them per XanoScript syntax

**Diff:**
```diff
-    while ($idx < (($input.arr|count))) {
-      // Skip if already visited...
-    }
+    var $arr_count { value = ($input.arr|count) }
+    
+    while ($idx < $arr_count) {
+      each {
+        // Skip if already visited...
+      }
+    }
```

**Result:** pass ✓

---

## Validation 4 - Validated run.xs

**Files validated:** `run.xs`
**Result:** pass ✓

---