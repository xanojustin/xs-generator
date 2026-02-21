# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial Function

**Files validated:** `function/is_balanced.xs`
**Result:** Fail (3 errors)
**Code at this point:** Initial implementation with `object_hash` filter

**Errors:**
1. [Line 83, Column 72] Unknown filter function 'object_hash'
2. [Line 94, Column 74] Unknown filter function 'object_hash'
3. [Line 123, Column 62] Unknown filter function 'object_hash'

---

## Validation 2 - Removed object_hash filter

**Files changed:** `function/is_balanced.xs`
**Validation errors being addressed:** Unknown filter function 'object_hash'
**Diff:**
```diff
- // In three places, changed from:
- value = ($node.left.val|to_text) ~ "_" ~ ($node.left|object_hash)
+ // To:
+ value = "node_" ~ ($node.left.val|to_text)
```
**Result:** Pass - function validated successfully

---

## Validation 3 - Initial Run Job

**Files validated:** `run.xs`
**Result:** Fail (1 error)
**Code at this point:** Run job with inline comments inside input block

**Errors:**
1. [Line 6, Column 12] Expecting: Expected an object {} but found: '{'

---

## Validation 4 - Removed Inline Comments

**Files changed:** `run.xs`
**Validation errors being addressed:** Parser error on input block
**Diff:**
```diff
  run.job "Test Balanced Binary Tree" {
    main = {
      name: "is_balanced"
      input: {
-       // Test Case 1: Balanced tree
-       //      3
-       //     / \
-       //    9  20
-       //      /  \
-       //     15   7
        root: {
```
**Result:** Pass - run job validated successfully

---

## Validation 5 - Final Directory Validation

**Files validated:** All files in `~/xs/balanced-binary-tree/`
**Result:** Pass - Both files valid

✅ Valid files:
  - `function/is_balanced.xs`
  - `run.xs`
