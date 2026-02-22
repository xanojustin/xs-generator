# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, sudoku_solver.xs (in function/)
**Result:** FAIL - 1 error in sudoku_solver.xs

**Validation errors:**
```
1. [Line 7, Column 10] Expecting token of type --> Identifier <-- but found --> '[' <---
Code at line 7:
  int[][] board { description = "9x9 grid with 0 representing empty cells" }
```

**Code at this point:** Used `int[][] board` for 2D array type

---

## Validation 2 - Fixed 2D array type to json

**Files changed:** function/sudoku_solver.xs
**Validation errors being addressed:** Nested array type `int[][]` not supported
**Diff:**
```diff
  input {
-   int[][] board { description = "9x9 grid with 0 representing empty cells" }
+   json board { description = "9x9 grid with 0 representing empty cells" }
  }
```
**Result:** FAIL - 3 errors (nested functions not allowed)

**Validation errors:**
```
1. [Line 12, Column 5] Expecting: one of these possible Token sequences... but found: 'function'
```

---

## Validation 3 - Split into separate function files

**Files changed:** Deleted nested functions from sudoku_solver.xs, created is_valid.xs, find_empty.xs, solve_helper.xs
**Validation errors being addressed:** Cannot define functions inside other functions' stack blocks
**Diff:**
```diff
- // Sudoku Solver - with nested functions (not allowed)
- function "sudoku_solver" {
-   stack {
-     function "is_valid" { ... }
-     function "find_empty" { ... }
-     function "solve" { ... }
-   }
- }

+ // sudoku_solver.xs - main entry point only
+ function "sudoku_solver" {
+   stack {
+     function.run "solve_helper" { ... }
+   }
+ }
+
+ // is_valid.xs - separate file
+ function "is_valid" { ... }
+
+ // find_empty.xs - separate file  
+ function "find_empty" { ... }
+
+ // solve_helper.xs - separate file
+ function "solve_helper" { ... }
```
**Result:** FAIL - 3 errors (response inside conditionals, if statements not in conditional blocks)

**Validation errors:**
```
1. [Line 17, Column 13] Expecting --> } <-- but found --> 'if' <--
2. [Line 18, Column 9] Expecting --> } <-- but found --> 'response' <--
```

---

## Validation 4 - Fixed conditional syntax and response placement

**Files changed:** is_valid.xs, find_empty.xs, solve_helper.xs
**Validation errors being addressed:** 
1. `if` must be inside `conditional` blocks
2. `response` must be at end of stack, not inside conditionals

**Diff for is_valid.xs:**
```diff
    while ($i < 9) {
      each {
-       if ($input.board[$input.row][$i] == $input.num) {
-         response = false
-       }
+       conditional {
+         if ($input.board[$input.row][$i] == $input.num) {
+           var $valid { value = false }
+         }
+       }
        var.update $i { value = $i + 1 }
      }
    }
```

**Diff for find_empty.xs:**
```diff
- response = { found: false }
+ var $result { value = { found: false } }
...
- response = { found: true, ... }
+ var $result { value = { found: true, ... } }
...
+ response = $result
```

**Diff for solve_helper.xs:**
```diff
- response = { solved: true, board: ... }
+ var $result { value = { solved: true, board: ... } }
...
+ response = $result
```
**Result:** FAIL - 1 error (array assignment syntax)

**Validation errors:**
```
1. [Line 49, Column 17] Expecting --> } <-- but found --> '$input' <--
Code at line 49:
  $input.board[$row][$col] = $num
```

---

## Validation 5 - Fixed array assignment to use filter chains

**Files changed:** solve_helper.xs
**Validation errors being addressed:** Direct array assignment not supported
**Diff:**
```diff
- // Place the number
- $input.board[$row][$col] = $num
+ // Place the number: board[row][col] = num
+ var $board {
+   value = $board|set:$row:($board|get:$row|set:$col:$num)
+ }

- // Backtrack - reset cell to empty
- $input.board[$row][$col] = 0
+ var $board {
+   value = $board|set:$row:($board|get:$row|set:$col:0)
+ }
```
**Result:** PASS - All 5 files valid

---

## Summary

Total validation cycles: 5
Final result: All files pass validation

Key lessons learned:
1. Use `json` type for 2D arrays
2. Helper functions must be in separate files
3. Use `var` to accumulate results, set `response` at end
4. All `if` statements must be inside `conditional` blocks
5. Array mutation requires filter chains: `$arr|set:$i:($arr|get:$i|set:$j:$val)`