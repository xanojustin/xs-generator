# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/isPangram.xs`
**Result:** FAIL

**Validation errors:**
```
✗ isPangram.xs: Found 1 error(s):

1. [Line 17, Column 45] Unknown filter function 'array_unique'

Code at line 17:
  var $unique_chars { value = $char_array|array_unique }
```

**Code at this point:** Used non-existent `array_unique` filter (thought it existed based on other languages).

---

## Validation 2 - Attempted fix with strpos and if statements

**Files changed:** `function/isPangram.xs`
**Validation errors being addressed:** `array_unique` filter doesn't exist

**Diff:**
```diff
-    // Get unique characters using array_unique
-    var $unique_chars { value = $char_array|array_unique }
+    // Check each letter - count how many are present
+    var $count { value = 0 }
+    
+    // Check 'a'
+    if (($letters_only|strpos:"a") >= 0) {
+      $count = $count + 1
+    }
+    // ... (26 if statements for each letter)
+    
+    // Check if all 26 letters were found
+    var $is_pangram { value = $count == 26 }
```

**Result:** FAIL

**Validation errors:**
```
1. [Line 20, Column 5] Expecting --> } <-- but found --> 'if' <--
```

---

## Validation 3 - Final fix using `unique` filter

**Files changed:** `function/isPangram.xs`
**Validation errors being addressed:** Cannot use standalone `if` statements in stack blocks

**Diff:**
```diff
-    // Check each letter - count how many are present
-    var $count { value = 0 }
-    \-    // Check 'a'
-    if (($letters_only|strpos:"a") >= 0) {
-      $count = $count + 1
-    }
-    // ... 25 more if statements ...
+    // Get unique characters using the unique filter
+    var $unique_chars { value = $char_array|unique }
+
+    // Count unique letters
+    var $unique_count { value = ($unique_chars|count) }
 
     // Check if we have all 26 letters of the alphabet
-    var $is_pangram { value = $count == 26 }
+    var $is_pangram { value = $unique_count == 26 }
```

**Result:** PASS

Both files validated successfully:
- `/Users/justinalbrecht/xs/pangram-check/function/isPangram.xs`
- `/Users/justinalbrecht/xs/pangram-check/run.xs`
