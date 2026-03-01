# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/hit_counter.xs, table/hits.xs
**Result:** FAIL (3 invalid files)

**Errors:**
- run.xs: Line 6, Column 12 - Expected an object {} but found: '{'
- hit_counter.xs: Line 13, Column 1 - Expecting --> function <-- but found --> '\n'
- hits.xs: Line 13, Column 1 - Expecting --> table <-- but found --> '\n'

**Root cause:** Multi-line comment blocks with empty `//` lines before the construct definition were confusing the parser.

---

## Validation 2 - Fixed comment structure and input types

**Files changed:** run.xs, function/hit_counter.xs, table/hits.xs
**Validation errors being addressed:** Parser errors on multi-line comments and object[] schema syntax

**Diff for run.xs:**
```diff
- // Run job to test the Design Hit Counter
- // 
- // Simulates recording hits...
- 
- run.job "Test Design Hit Counter" {
+ // Run job to test the Design Hit Counter
+ // Simulates recording hits and querying hit counts within a 5-minute window
+ run.job "Test Design Hit Counter" {
```

**Diff for function/hit_counter.xs:**
```diff
- // Design Hit Counter - System Design Exercise
- // 
- // Design a hit counter which counts...
- // 
- // Your hit counter should support...
- //
- // Constraints:
- // ...
-
  function "hit_counter" {
    description = "Records hits and returns hit counts within a 5-minute window"
    
    input {
-     object[] test_operations {
-       schema {
-         text action { description = "Either 'hit'..." }
-         int timestamp { description = "Timestamp in seconds" }
-       }
-     }
+     json test_operations { description = "Array of operations with action and timestamp" }
    }
```

**Diff for table/hits.xs:**
```diff
- // Design Hit Counter - System Design Exercise
- // 
- // ...
- 
- table hits {
+ // Table to store hit timestamps for the Design Hit Counter exercise
+ table hits {
```

**Result:** FAIL (1 invalid file)

**Remaining errors in hits.xs:**
- Line 11, Column 6 - Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`
- Line 11, Column 49 - The key 'direction' is not valid in this context

---

## Validation 3 - Fixed table index syntax

**Files changed:** table/hits.xs
**Validation errors being addressed:** Invalid index type "index" and unsupported "direction" key

**Diff:**
```diff
  index = [
    {type: "primary", field: [{name: "id"}]},
-   {type: "index", field: [{name: "timestamp", direction: "asc"}]}
+   {type: "btree", field: [{name: "timestamp"}]}
  ]
```

**Result:** PASS - All 3 files valid

---

## Summary

**Key learnings:**
1. Avoid multi-line comment blocks with empty `//` lines - they confuse the parser
2. Use `json` type for complex array inputs instead of `object[]` with schema
3. Table index types must be one of: `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector` (not "index")
4. Index field definitions don't support a "direction" key
