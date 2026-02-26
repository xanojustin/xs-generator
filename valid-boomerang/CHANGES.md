# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/valid-boomerang/run.xs`
- `/Users/justinalbrecht/xs/valid-boomerang/function/check_valid_boomerang.xs`

**Result:** pass

Both files passed validation on the first attempt. No syntax changes were needed.

---

## Validation 2 - Renamed function to match convention

**Files changed:** 
- `/Users/justinalbrecht/xs/valid-boomerang/run.xs`
- `/Users/justinalbrecht/xs/valid-boomerang/function/valid-boomerang.xs` (renamed from `check_valid_boomerang.xs`)

**Validation errors being addressed:** None - this was a convention alignment, not a fix for validation errors

**Diff:**

`function/valid-boomerang.xs`:
```diff
- function "check_valid_boomerang" {
+ function "valid-boomerang" {
```

`run.xs`:
```diff
  run.job "Valid Boomerang Test" {
    main = {
-     name: "check_valid_boomerang"
+     name: "valid-boomerang"
```

**Result:** pass

Both files still pass validation after the rename.

**Code at this point:**

`run.xs`:
```xs
run.job "Valid Boomerang Test" {
  main = {
    name: "valid-boomerang"
    input: {
      points: [
        { x: 1, y: 1 }
        { x: 2, y: 3 }
        { x: 3, y: 2 }
      ]
    }
  }
}
```

`function/valid-boomerang.xs`:
```xs
function "valid-boomerang" {
  description = "Check if three points form a valid boomerang (not collinear)"
  input {
    object[] points {
      description = "Array of 3 points, each with x and y coordinates"
      schema {
        int x
        int y
      }
    }
  }
  stack {
    var $p1 { value = $points|first }
    var $p2 { value = $points|slice:1:2|first }
    var $p3 { value = $points|slice:2:3|first }
    
    var $x1 { value = $p1.x }
    var $y1 { value = $p1.y }
    var $x2 { value = $p2.x }
    var $y2 { value = $p2.y }
    var $x3 { value = $p3.x }
    var $y3 { value = $p3.y }
    
    var $dx1 { value = $x2 - $x1 }
    var $dy1 { value = $y2 - $y1 }
    var $dx2 { value = $x3 - $x2 }
    var $dy2 { value = $y3 - $y2 }
    
    var $cross { value = ($dy1 * $dx2) - ($dy2 * $dx1) }
    
    var $is_valid { value = $cross != 0 }
  }
  response = $is_valid
}
```
