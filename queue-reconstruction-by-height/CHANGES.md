# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/queue_reconstruction.xs`
**Result:** FAIL
**Errors:**
1. `[Line 10, Column 23]` Input syntax error - expecting newline, found 'description'
2. `object[]` type not recognized (suggested using "type[]" instead of "array")

**Code at this point:** Used incorrect input syntax with descriptions inline and `object[]` type

---

## Validation 2 - Fixed input syntax

**Files changed:** `function/queue_reconstruction.xs`
**Validation errors being addressed:** 
- Input block had `object[] people { description = "..." }` which isn't valid syntax
- Changed to `json people` to accept array of arrays

**Diff:**
```diff
   input {
-    object[] people { description = "Array of [height, k] pairs" }
+    json people
   }
```
**Result:** FAIL - New errors appeared

**Errors:**
1. `[Line 17, Column 29]` Unknown filter function 'custom_sort'
2. `[Line 19, Column 24]` Syntax error in comparator function: expecting ')' but found ','

---

## Validation 3 - Removed custom_sort with comparator

**Files changed:** `function/queue_reconstruction.xs`
**Validation errors being addressed:** 
- `custom_sort` filter doesn't exist with comparator function support
- Arrow function syntax `($a, $b) => {...}` not supported

**Diff:**
```diff
-    // Sort people by height descending, then by k ascending
-    var $sorted {
-      value = $input.people|custom_sort:{
-        method: "custom",
-        comparator: ($a, $b) => {
-          // Sort by height descending
-          if ($a[0] != $b[0]) {
-            return $b[0] - $a[0]
-          }
-          // If same height, sort by k ascending
-          return $a[1] - $b[1]
-        }
-      }
-    }
+    // Get count of people
+    var $n { value = $input.people|count }
+
+    // Create array of indices for sorting
+    var $indices { value = [] }
+    var $i { value = 0 }
+    while ($i < $n) {
+      each {
+        array.push $indices { value = $i }
+        math.add $i { value = 1 }
+      }
+    }
+
+    // Sort indices based on height descending, then k ascending
+    // Using bubble sort approach since we need custom comparator
+    ... (bubble sort implementation)
```
**Result:** FAIL - New error in conditional structure

**Errors:**
1. `[Line 53, Column 17]` Expecting '}' but found 'if'

---

## Validation 4 - Fixed nested conditional

**Files changed:** `function/queue_reconstruction.xs`
**Validation errors being addressed:** 
- Cannot nest `if` inside `elseif` without proper structure
- Combined the conditions into a single `elseif` with `&&` operator

**Diff:**
```diff
             conditional {
               if ($person1[0] < $person2[0]) {
                 // person1 is shorter, should come after (swap)
                 var $should_swap { value = true }
               }
-              elseif ($person1[0] == $person2[0]) {
-                // Same height, sort by k ascending
-                if ($person1[1] > $person2[1]) {
-                  var $should_swap { value = true }
-                }
+              elseif ($person1[0] == $person2[0] && $person1[1] > $person2[1]) {
+                // Same height, but person1 has larger k, should come after
+                var $should_swap { value = true }
               }
             }
```
**Result:** PASS - All files valid
