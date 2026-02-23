# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/compare-version-numbers/run.xs`
- `/Users/justinalbrecht/xs/compare-version-numbers/function/compare_versions.xs`

**Result:** FAIL (1 valid, 1 invalid)

**Errors in compare_versions.xs:**
1. Unknown filter function 'length' (lines 13, 15, 16)
2. Expression should be wrapped in parentheses when combining filters and tests (line 15)
3. Expecting ')' but found 'and' (line 24)

---

## Validation 2 - Fixed filter names and logical operators

**Files changed:** `function/compare_versions.xs`

**Validation errors being addressed:**
- `length` filter doesn't exist for arrays - should use `count`
- `and` is not valid syntax - should use `&&`
- Filter expressions need parentheses when combined with operators

**Diff:**
```diff
     // Get the maximum length
-    var $max_len { value = $v1_parts|length }
+    var $max_len { value = ($v1_parts|count) }
     conditional {
-      if ($v2_parts|length > $max_len) {
-        var.update $max_len { value = $v2_parts|length }
+      if (($v2_parts|count) > $max_len) {
+        var.update $max_len { value = ($v2_parts|count) }
```

```diff
-    while ($i < $max_len and $result == 0) {
+    while (($i < $max_len) && ($result == 0)) {
```

```diff
         conditional {
-          if ($i < $v1_parts|length) {
+          if ($i < ($v1_parts|count)) {
```

```diff
         conditional {
-          if ($i < $v2_parts|length) {
+          if ($i < ($v2_parts|count)) {
```

**Result:** FAIL - Still had errors

---

## Validation 3 - Fixed type conversion filter

**Files changed:** `function/compare_versions.xs`

**Validation errors being addressed:**
- `int` is not a valid filter - should use `to_int`

**Diff:**
```diff
         conditional {
           if ($i < ($v1_parts|count)) {
-            var.update $seg1 { value = $v1_parts[$i]|int }
+            var.update $seg1 { value = $v1_parts[$i]|to_int }
           }
         }
         conditional {
           if ($i < ($v2_parts|count)) {
-            var.update $seg2 { value = $v2_parts[$i]|int }
+            var.update $seg2 { value = $v2_parts[$i]|to_int }
           }
         }
```

**Result:** PASS (2 valid, 0 invalid)
