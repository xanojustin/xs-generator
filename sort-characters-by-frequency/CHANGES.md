# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/sort-characters-by-frequency.xs
**Result:** FAIL (3 errors)

### Errors Found:

1. **function/sort-characters-by-frequency.xs Line 17:** Unknown filter function 'get_keys'
   - Used `$grouped|get_keys` but correct filter is `keys`

2. **function/sort-characters-by-frequency.xs Line 21:** Syntax error with sort filter
   - Used `sort:char:text:true` but field names must be quoted: `sort:"char":"text":true`

3. **run.xs Line 1:** Incorrect run.job syntax
   - Used `run.job { stack { ... } }` but run.job requires `main = { name: "...", input: {...} }`

---

## Validation 2 - Fixed filter names and syntax

**Files changed:** function/sort-characters-by-frequency.xs, run.xs

**Validation errors being addressed:**
- Changed `get_keys` to `keys`
- Changed sort syntax from `sort:char:text:true` to `sort:"char":"text":true`
- Fixed run.job to use proper `main` syntax
- Replaced non-existent `repeat` filter with a while loop using `array.push`

**Diff for function/sort-characters-by-frequency.xs:**
```diff
-    var $frequencies { value = $grouped|get_keys|map:{ char: $$, count: ($grouped|get:$$)|count } }
+        var $char_keys { value = $grouped|keys }
+        var $frequencies { value = [] }
+
+        foreach ($char_keys) {
+          each as $char {
+            var $count { value = ($grouped|get:$char)|count }
+            var $entry { value = { char: $char, count: $count } }
+            array.push $frequencies { value = $entry }
+          }
+        }
```

**Diff for sort lines:**
```diff
-    var $sorted_by_char { value = $frequencies|sort:char:text:true }
-    var $sorted { value = $sorted_by_char|sort:count:int:false }
+        var $sorted_by_char { value = $frequencies|sort:"char":"text":true }
+        var $sorted { value = $sorted_by_char|sort:"count":"int":false }
```

**Result:** PASS (2 files valid)

---

## Validation 3 - Attempted to add multiple test cases

**Files changed:** run.xs

**What was tried:**
- Attempted to use a `stack` block with multiple `function.run` calls to test various cases
- Wanted to log results with `debug.log` for each test case

**Validation errors being addressed:**
```
The argument 'stack' is not valid in this context
```

**Diff:**
```diff
-run.job "Test Sort Characters By Frequency" {
-  main = {
-    name: "sort-characters-by-frequency"
-    input: {
-      input_string: "tree"
-    }
-  }
-}
+run.job "Test Sort Characters By Frequency" {
+  stack {
+    function.run "sort-characters-by-frequency" {
+      input = { input_string: "tree" }
+    } as $result1
+    debug.log { value = "Test 1 - 'tree': " ~ $result1.response.result }
+    ...
```

**Result:** FAIL - run.job does not support `stack` blocks, only `main`

---

## Validation 4 - Reverted to standard pattern

**Files changed:** run.xs

**Validation errors being addressed:**
- Reverted to using `main` syntax consistent with all other exercises in the repo

**Diff:**
```diff
-run.job "Test Sort Characters By Frequency" {
-  stack {
-    function.run "sort-characters-by-frequency" {
-      input = { input_string: "tree" }
-    } as $result1
-    debug.log { value = "Test 1 - 'tree': " ~ $result1.response.result }
-    ...
+// Run job to test the sort-characters-by-frequency function
+// Sort Characters By Frequency: Sorts characters by frequency in descending order
+run.job "Test Sort Characters By Frequency" {
+  main = {
+    name: "sort-characters-by-frequency"
+    input: {
+      input_string: "tree"
+    }
+  }
}
```

**Result:** PASS (2 files valid)
