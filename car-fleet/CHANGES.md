# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/car_fleet.xs
**Result:** FAIL - 3 errors found

### Errors Found:
1. Line 14: Expression should be wrapped in parentheses when combining filters and tests
2. Line 21: Expression should be wrapped in parentheses when combining filters and tests  
3. Line 42: Sort filter field name syntax issue

---

## Validation 2 - Fixed filter expression parentheses and sort syntax

**Files changed:** function/car_fleet.xs

**Validation errors being addressed:**
- `precondition ($input.position|count == $input.speed|count)` → need parentheses around filter expressions
- `if ($input.position|count == 0)` → need parentheses around filter expressions
- `$cars|sort:position:int:true` → field name needs quotes

**Diff:**
```diff
-     precondition ($input.position|count == $input.speed|count) {
+     precondition (($input.position|count) == ($input.speed|count)) {

-       if ($input.position|count == 0) {
+       if (($input.position|count) == 0) {

-     var $sorted_cars { value = $cars|sort:position:int:true }
+     var $sorted_cars { value = $cars|sort:"position":int:true }
```

**Result:** FAIL - new error on line 64 (elseif block structure)

---

## Validation 3 - Fixed sort syntax and conditional block structure

**Files changed:** function/car_fleet.xs

**Validation errors being addressed:**
- `$cars|sort:"position":int:true` → sort filter doesn't use type parameter, just field name
- Comment between elseif block and conditional closing brace caused parser error

**Diff:**
```diff
-     var $sorted_cars { value = $cars|sort:"position":int:true }
+     var $sorted_cars { value = $cars|sort:"position" }
```

The comment between the `elseif` closing brace and the `conditional` closing brace was also removed as it confused the parser:
```diff
-           }
-           // Else: car merges with current fleet (faster but blocked)
-         }
+           }
+         }
```

**Result:** PASS - both files valid!
