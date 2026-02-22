# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/zigzag_level_order.xs`

**Result:** Fail

**Errors:**
1. Line 8: `object? left {` - Cannot use `?` with object type in schema
   - Suggestion: Use "json" instead of "object"

---

## Validation 2 - Fixed object schema syntax

**Files changed:** `function/zigzag_level_order.xs`

**Validation errors being addressed:**
```
1. [Line 8, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--
💡 Suggestion: Use "json" instead of "object"
```

**Diff:**
```diff
-    object tree {
-      description = "Binary tree node structure"
-      schema {
-        int? val
-        object? left {
-          schema {
-            int? val
-            json? left
-            json? right
-          }
-        }
-        object? right {
-          schema {
-            int? val
-            json? left
-            json? right
-          }
-        }
-      }
-    }
+    json tree {
+      description = "Binary tree node structure"
+    }
```

**Result:** Fail

**Errors:**
1. Line 22: `while ($queue|count > 0)` - Expression with filter needs parentheses

---

## Validation 3 - Fixed filter expression parentheses

**Files changed:** `function/zigzag_level_order.xs`

**Validation errors being addressed:**
```
1. [Line 22, Column 27] An expression should be wrapped in parentheses when combining filters and tests
Code at line 22:
  while ($queue|count > 0) {
```

**Diff:**
```diff
-    while ($queue|count > 0) {
+    while (($queue|count) > 0) {
```

**Result:** Pass ✓

Both `run.xs` and `function/zigzag_level_order.xs` are now valid.

