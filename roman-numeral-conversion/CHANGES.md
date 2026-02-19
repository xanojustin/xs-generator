# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:**
- `/Users/justinalbrecht/xs/roman-numeral-conversion/run.xs`
- `/Users/justinalbrecht/xs/roman-numeral-conversion/function/roman_numeral.xs`

**Result:** FAIL (1 valid, 1 invalid)

**Errors in roman_numeral.xs:**
1. [Line 40, Column 9] conditional is missing the if statement
2. [Line 41, Column 11] Expecting --> } <-- but found --> 'while' <--

**Issue:** XanoScript does not support `while` loops inside `conditional` blocks. The `conditional` block only supports `if`/`elseif`/`else`, not iterative loops.

---

## Validation 2 - Replaced while loop with division-based approach

**Files changed:** `function/roman_numeral.xs`

**Validation errors being addressed:** 
- "conditional is missing the if statement"
- "Expecting --> } <-- but found --> 'while' <--"

**Diff:**
```diff
-     // Loop through each mapping
-     foreach ($mappings) {
-       each as $mapping {
-         // While the remaining value is >= current mapping value
-         conditional {
-           while (`$remaining >= $mapping.value`) {
-             // Append the symbol to result
-             text.append $result {
-               value = $mapping.symbol
-             }
-             // Subtract the value from remaining
-             math.sub $remaining {
-               value = $mapping.value
-             }
-           }
-         }
-       }
-     }
+     // Iterate through each mapping
+     foreach ($mappings) {
+       each as $mapping {
+         // Calculate how many times this symbol fits
+         var $count {
+           value = `$remaining / $mapping.value`
+         }
+
+         // Only process if count is at least 1
+         conditional {
+           if (`$count >= 1`) {
+             // Create the repeated symbol string
+             var $symbols {
+               value = ""
+             }
+
+             // Build the symbol string by appending count times
+             // Use a range to iterate the count number of times
+             var $range_arr {
+               value = `|range:1:$count`
+             }
+
+             foreach ($range_arr) {
+               each as $_ {
+                 text.append $symbols {
+                   value = $mapping.symbol
+                 }
+               }
+             }
+
+             // Append symbols to result
+             text.append $result {
+               value = $symbols
+             }
+
+             // Subtract the value we've converted
+             var $subtracted {
+               value = `$count * $mapping.value`
+             }
+             math.sub $remaining {
+               value = $subtracted
+             }
+           }
+         }
+       }
+     }
```

**Result:** PASS (2 valid, 0 invalid)

**Solution explanation:** Instead of using a while loop to repeatedly subtract values, the new approach uses division to calculate how many times each Roman symbol fits into the remaining number, then uses a range filter to iterate that many times for symbol construction. This works around the lack of while loops in XanoScript.

---
