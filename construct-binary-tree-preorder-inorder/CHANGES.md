# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `/Users/justinalbrecht/xs/construct-binary-tree-preorder-inorder/run.xs`
- `/Users/justinalbrecht/xs/construct-binary-tree-preorder-inorder/function/buildTree.xs`

**Result:** FAIL

**Error:**
```
✗ buildTree.xs: Found 1 error(s):
1. [Line 23, Column 5] Expecting --> } <-- but found --> 'each' <--
```

**Code at this point:** The `each` loop had incorrect syntax using `each ($input.inorder as $val)` which is not valid XanoScript.

---

## Validation 2 - Fixed array iteration syntax

**Files changed:** 
- `/Users/justinalbrecht/xs/construct-binary-tree-preorder-inorder/function/buildTree.xs` → renamed to `build_tree.xs`
- `/Users/justinalbrecht/xs/construct-binary-tree-preorder-inorder/run.xs`

**Validation errors being addressed:** 
The `each` block cannot take parameters like `each ($input.inorder as $val)`. XanoScript uses `each` only as a body block for `while` loops, not as a foreach-style iterator.

**Changes made:**
1. Rewrote the inorder map building to use `while` with index counter instead of foreach
2. Used `array.push` instead of `merge` for adding to arrays
3. Used `math.add` for incrementing counters
4. Renamed function from `buildTree` to `build_tree` (snake_case convention)
5. Updated run.xs to reference the correct function name

**Diff (conceptual - file was rewritten):**
```diff
- // Old: Invalid foreach syntax
- each ($input.inorder as $val) {
-   var $inorderMap { value = $inorderMap|set:($val|to_text):$idx }
- }

+ // New: Valid while + each syntax
+ while ($idx < $inorder_len) {
+   each {
+     var $val { value = $input.inorder[$idx] }
+     var $inorder_map { value = $inorder_map|set:$key:$idx }
+     math.add $idx { value = 1 }
+   }
+ }
```

**Result:** PASS - Both files validated successfully

---

## Summary

Total validations: 2
Final result: All files pass validation
