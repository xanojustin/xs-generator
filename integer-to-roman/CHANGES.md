# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `function/integer-to-roman.xs`, `run.xs`
**Result:** FAIL

**Errors:**

1. **function/integer-to-roman.xs:**
   - `[Line 32, Column 5] Expecting --> } <-- but found --> 'each' <--`
   - Issue: Tried to use `each ($mappings as $mapping)` loop directly in stack

2. **run.xs:**
   - `[Line 2, Column 3] The argument 'description' is not valid in this context`
   - `[Line 4, Column 3] The argument 'stack' is not valid in this context`
   - Issue: Used wrong syntax for run.job - tried to use `stack` and `function.run` instead of `main = { name: "...", input: {...} }`

---

## Validation 2 - Fixed run.job syntax and restructured function

**Files changed:** `function/integer-to-roman.xs`, `run.xs`

**Validation errors being addressed:**
- run.job doesn't use `description`, `stack`, or `function.run` - it uses `main = { name: "...", input: {...} }`
- Function cannot use nested `while` inside `each` with array iteration

**Diff for run.xs:**
```diff
- // Run job to test integer-to-roman conversion
- run.job "integer-to-roman-job" {
-   description = "Run job to test integer-to-roman conversion"
-   
-   stack {
-     // Test case 1: Basic case - 3
-     function.run "integer-to-roman" {
-       input = { number: 3 }
-     } as $result1
-     debug.log { value = "Test 1: 3 -> " ~ $result1 }
-     ...
-   }
-   
-   response = $results
- }
+ // Run job to test the integer-to-roman function
+ run.job "Test Integer to Roman" {
+   main = {
+     name: "integer-to-roman"
+     input: {
+       number: 1994
+     }
+   }
+ }
```

**Diff for function/integer-to-roman.xs:**
```diff
-     // Iterate through mappings and build Roman numeral
-     each ($mappings as $mapping) {
-       while ($remaining >= $mapping.value) {
-         // Append symbol to result
-         var.update $result { value = $result ~ $mapping.symbol }
-         // Subtract value from remaining
-         var.update $remaining { value = $remaining - $mapping.value }
-       }
-     }
+     // Process 1000s (M)
+     while ($remaining >= 1000) {
+       each {
+         var.update $result { value = $result ~ "M" }
+         var.update $remaining { value = $remaining - 1000 }
+       }
+     }
+     // Process 900s (CM)
+     while ($remaining >= 900) {
+       each {
+         var.update $result { value = $result ~ "CM" }
+         var.update $remaining { value = $remaining - 900 }
+       }
+     }
+     // ... (similar blocks for all Roman numeral values)
```

**Result:** PASS - Both files validate successfully

---

## Summary

**Key learnings:**
1. `run.job` uses a completely different syntax than functions - it uses `main = { name: "...", input: {...} }` to specify which function to call
2. `each` blocks in XanoScript cannot contain nested `while` loops in the way I initially tried
3. The `while` + `each` pattern is used to execute multiple statements inside a while loop body
4. Arrays cannot be iterated with `each ($array as $item)` - that syntax is not supported
