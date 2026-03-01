# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/fraction_addition.xs`

**Result:** Failed - 3 errors

**Validation errors:**
1. [Line 34, Column 37] An expression should be wrapped in parentheses when combining filters and tests
2. [Line 53, Column 29] An expression should be wrapped in parentheses when combining filters and tests  
3. [Line 65, Column 25] Expecting --> ) <-- but found --> 'as' <--

---

## Validation 2 - Fixed filter expressions and foreach syntax

**Files changed:** `function/fraction_addition.xs`

**Validation errors being addressed:**
- Filter expressions in conditionals need parentheses: `$current|strlen > 0` → `($current|strlen) > 0`
- foreach syntax was wrong: `foreach ($fractions as $fraction)` → `foreach ($fractions) { each as $fraction { ... } }`

**Diff:**
```diff
-              if ($current|strlen > 0) {
+              if (($current|strlen) > 0) {
```
```diff
-    foreach ($fractions as $fraction) {
-      each {
+    foreach ($fractions) {
+      each as $fraction {
```

**Result:** ✅ Pass - All files valid

