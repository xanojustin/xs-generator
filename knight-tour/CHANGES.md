# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/knight_tour.xs
**Result:** FAIL
**Errors:**
- `run.xs: Line 3, Column 1: Expecting --> run <-- but found --> '\n' <--`
- `knight_tour.xs: Line 3, Column 1: Expecting --> function <-- but found --> '\n' <--`

**Issue:** Files had encoding issues from using the `write` tool. The content appeared correct but the validator was seeing unexpected characters at the start of the files.

---

## Validation 2 - Recreated files with heredoc

**Files changed:** run.xs, function/knight_tour.xs
**Validation errors being addressed:** Both files had encoding/character issues

**Diff:**
```diff
- // Run job for Knight's Tour exercise
- // Tests the knight_tour function with various board sizes and starting positions
- 
  run.job "Knights Tour Solver" {
    main = {
      name: "knight_tour",
      input: {
```

**Result:** PASS for run.xs, FAIL for function/knight_tour.xs
**New error:**
- `knight_tour.xs: Line 75, Column 5: Expecting --> } <-- but found --> 'stack' <--`

---

## Validation 3 - Renamed stack variable

**Files changed:** function/knight_tour.xs
**Validation errors being addressed:** 
- `knight_tour.xs: Line 75, Column 5: Expecting --> } <-- but found --> 'stack' <--`

**Issue:** `stack` is a reserved keyword in XanoScript and cannot be used as a variable name.

**Diff:**
```diff
-     var $stack {
+     var $backtrack_stack {
        value = [
          {
```

**Result:** FAIL
**New error:**
- `knight_tour.xs: Line 75, Column 12: Expecting --> stack <-- but found --> '\n' <--`

---

## Validation 4 - Removed group wrapper

**Files changed:** function/knight_tour.xs
**Validation errors being addressed:**
- `knight_tour.xs: Line 75, Column 12: Expecting --> stack <-- but found --> '\n' <--`

**Issue:** The `group` construct requires a `stack` block inside it. I was trying to use `group` to organize code but didn't include the required `stack` child block.

**Diff:**
```diff
-     group {
-       var $max_iterations { value = 1000000 }
-       var $iteration { value = 0 }
-       
-       while ...
-     }
+     var $max_iterations { value = 1000000 }
+     var $iteration { value = 0 }
+     
+     while ...
```

**Result:** PASS

Both files now validate successfully.

---

## Summary of Key Learnings

1. **File encoding matters** - Using `write` tool sometimes causes invisible encoding issues. Using heredocs in shell commands produces cleaner files.

2. **Reserved keywords** - `stack` cannot be used as a variable name inside a `stack` block. Had to rename to `$backtrack_stack`.

3. **Group construct syntax** - The `group` block is purely organizational but requires a `stack` block inside it. Since I didn't need grouping, removing it was simpler.
