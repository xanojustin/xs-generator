# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/intersection_linked_lists.xs`
**Result:** FAIL
**Errors:**
```
[Line 31, Column 15] Expecting: Expected an expression but found: '-'
Code at line 31: value = ->($node) {
```
**Issue:** Attempted to use lambda/arrow function syntax which doesn't exist in XanoScript.

---

## Validation 2 - Removed lambda function

**Files changed:** `function/intersection_linked_lists.xs`
**Validation errors being addressed:** Lambda/arrow function syntax not supported
**Diff:**
```diff
-    // Helper to calculate length of a linked list
-    var $get_length {
-      value = ->($node) {
-        var $length { value = 0 }
-        var $current { value = $node }
-
-        while ($current != null) {
-          each {
-            var.update $length { value = $length + 1 }
-            var $current { value = $current|get:"next" }
-          }
-        }
-
-        return { value = $length }
-      }
-    }
-
-    // Get lengths of both lists
-    var $len_a { value = $get_length($input.head_a) }
-    var $len_b { value = $get_length($input.head_b) }
+    // Calculate length of list A
+    var $len_a { value = 0 }
+    var $current { value = $input.head_a }
+
+    while ($current != null) {
+      each {
+        var.update $len_a { value = $len_a + 1 }
+        var $current { value = $current|get:"next" }
+      }
+    }
+
+    // Calculate length of list B
+    var $len_b { value = 0 }
+    var $current { value = $input.head_b }
+
+    while ($current != null) {
+      each {
+        var.update $len_b { value = $len_b + 1 }
+        var $current { value = $current|get:"next" }
+      }
+    }
```
**Result:** FAIL
**Errors:**
```
[Line 12, Column 15] Expecting token of type --> Identifier <-- but found --> '?' <--
💡 Suggestion: Use "json" instead of "object"
Code at line 12: object? next {
```

---

## Validation 3 - Changed input types from object to json

**Files changed:** `function/intersection_linked_lists.xs`
**Validation errors being addressed:** Nullable object syntax not supported, suggestion to use json type
**Diff:**
```diff
-  input {
-    object head_a {
-      description = "First linked list head node"
-      schema {
-        int val { description = "Node value" }
-        object? next {
-          description = "Next node reference"
-        }
-      }
-    }
-    object head_b {
-      description = "Second linked list head node"
-      schema {
-        int val { description = "Node value" }
-        object? next {
-          description = "Next node reference"
-        }
-      }
-    }
-  }
+  input {
+    json head_a {
+      description = "First linked list head node (object with val and next)"
+    }
+    json head_b {
+      description = "Second linked list head node (object with val and next)"
+    }
+  }
```
**Result:** PASS - Function file validated successfully

---

## Validation 4 - Initial run.xs validation attempt

**Files validated:** `run.xs` (with deeply nested object literals)
**Result:** FAIL
**Errors:**
```
[Line 6, Column 12] Expecting: Expected an object {} but found: '{'
Code at line 6: input: {
```
**Issue:** Deeply nested object literals for linked list representation caused parse errors

---

## Validation 5 - Simplified run.xs to isolate issue

**Files changed:** `run.xs`
**Validation errors being addressed:** Parse error with complex nested objects
**Diff:**
```diff
-    input: {
-      // List A: 4 -> 1 -> 8 -> 4 -> 5
-      // List B: 5 -> 6 -> 1 -> 8 -> 4 -> 5
-      // Intersection at node with value 8
-      head_a: {
-        val: 4
-        next: {
-          val: 1
-          next: {
-            ...deeply nested...
-          }
-        }
-      }
-      ...
-    }
+    input: {
+      head_a: { val: 4, next: null }
+      head_b: { val: 5, next: null }
+    }
```
**Result:** PASS - Simplified version validated successfully
**Issue identified:** Nested object representation doesn't work for linked lists with shared references

---

## Validation 6 - Complete rewrite to use array representation

**Files changed:** `function/intersection_linked_lists.xs` (complete rewrite)
**Validation errors being addressed:** Linked list representation needs to support intersection detection
**Changes:**
- Changed from nested object representation to array-based representation
- Added parameters: `list_a`, `head_a`, `list_b`, `head_b`
- Updated algorithm to work with index-based `next` pointers
- Changed input types to use `object[]` with schema for array elements

**Result:** PASS - Function validated successfully

---

## Validation 7 - Final run.xs with array representation

**Files changed:** `run.xs`
**Validation errors being addressed:** Run job needs proper test data format
**Changes:**
- Updated to use array-based linked list representation matching other exercises
- Removed comments inside input block that may cause parsing issues
- Used consistent property naming with other exercises

**Result:** PASS - Both files validated successfully

---

## Summary

Total validation cycles: 7
Final status: All files valid

Key learnings:
1. XanoScript does not support lambda/arrow functions - inline all logic
2. Nullable object syntax (`object?`) is not valid - use `json` type instead
3. Deeply nested object literals can cause parse errors
4. Linked lists should use array-based representation with index pointers (like other exercises)
5. Avoid comments inside input blocks in run jobs
