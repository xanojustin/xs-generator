# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/first_unique_char.xs
**Result:** FAIL
**Errors:**
1. [Line 8, Column 37] An expression should be wrapped in parentheses when combining filters and tests
2. [Line 40, Column 21] Expecting --> } <-- but found --> 'else'

## Validation 2 - Fixed conditional syntax and parentheses

**Files changed:** function/first_unique_char.xs
**Validation errors being addressed:**
1. [Line 8, Column 37] An expression should be wrapped in parentheses when combining filters and tests
2. [Line 28, Column 13] Expecting --> } <-- but found --> 'else'

**Diff:**
```diff
- precondition ($input.s|strlen > 0) {
+ precondition (($input.s|strlen) > 0) {

- if (`$char_counts|has:$char`) {
+ if ($char_counts|has:$char) {

- } else {
+ }
+ else {

- if (`$count == 1`) {
+ if ($count == 1) {

- if (`$min_index == -1 || $char_index < $min_index`) {
+ if ($min_index == -1 || $char_index < $min_index) {
```
**Result:** PASS - Both files now valid

---
