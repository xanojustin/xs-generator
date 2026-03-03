# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/sliding_window_minimum.xs`
**Result:** Fail (3 errors)

### Errors Found:

1. **[Line 5, Column 42]** The argument 'filters' is not valid in this context
   - Code: `int k { description = "Window size", filters = "min:1" }`
   - Issue: filters value shouldn't be quoted as a string

2. **[Line 5, Column 42]** Expected value of `filters` to be `null`
   - Same issue as above

3. **[Line 22, Column 32]** Comments must be on their own line
   - Code: `var $deque { value = [] }  // Stores indices...`
   - Issue: Inline comments are not allowed in XanoScript

---

## Validation 2 - Fixed filters syntax and moved comments

**Files changed:** `function/sliding_window_minimum.xs`
**Validation errors being addressed:** All 3 errors from Validation 1
**Diff:**
```diff
   input {
     int[] nums { description = "Array of integers" }
-    int k { description = "Window size", filters = "min:1" }
+    int k filters = min:1 { description = "Window size" }
   }
```

And moved inline comments to their own lines.

**Result:** Fail (1 error - while loop syntax)

---

## Validation 3 - Fixed while loop syntax (added `each` blocks)

**Files changed:** `function/sliding_window_minimum.xs`
**Validation errors being addressed:** 
- `[Line 32, Column 59]` while loops need `each` blocks inside them

**Diff:**
```diff
         while (($deque|count) > 0 && $continue_checking) {
-          var $back_idx { value = $deque|last }
-          ...
+          each {
+            var $back_idx { value = $deque|last }
+            ...
+          }
         }
```

Applied same fix to both while loops.

**Result:** Pass - All files valid!

