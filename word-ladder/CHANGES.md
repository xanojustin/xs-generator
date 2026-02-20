# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/word_ladder.xs`
**Result:** Fail (3 errors)

### Errors:
1. `[Line 15]` Unknown filter function `array_flip`
2. `[Line 17]` Unknown filter function `default`
3. `[Line 34]` Expecting expression but found '{' (dynamic object key syntax)

---

## Validation 2 - Fixed filter and object syntax issues

**Files changed:** `function/word_ladder.xs`
**Validation errors being addressed:**
- `array_flip` doesn't exist → Replaced with manual iteration to check if word exists
- `default` filter doesn't exist → Replaced with `??` operator
- Dynamic object key syntax `{ ($key): value }` invalid → Used `set` filter instead

**Diff:**
```diff
-     var $word_set { value = $input.word_list|array_flip }
-     var $has_end {
-       value = ($word_set|get:($input.end_word)|default:null) != null
-     }
+     // Check if end_word is in word_list by iterating
+     var $end_found { value = false }
+     foreach ($input.word_list) {
+       each as $word {
+         conditional {
+           if ($word == $input.end_word) {
+             var $end_found { value = true }
+           }
+         }
+       }
+     }
```

```diff
-     var $visited { value = { ($input.begin_word): true } }
+     var $visited { value = {} }
+     var $visited {
+       value = $visited|set:($input.begin_word):true
+     }
```

**Result:** Fail (2 errors)

---

## Validation 3 - Fixed array_search and comment issues

**Files changed:** `function/word_ladder.xs`
**Validation errors being addressed:**
- `array_search` filter doesn't exist → Replaced with manual foreach loop
- Comments inside expression blocks cause parse errors → Moved comments to their own lines

**Diff:**
```diff
-     // Edge case: if end_word not in word_list, no valid path
-     // Check if end_word is in word_list using array_search
-     var $end_index {
-       value = $input.word_list|array_search:($input.end_word)
-     }
-     
-     conditional {
-       if ($end_index == -1) {
-         return { value = 0 }
-       }
-     }
+     // Edge case: if end_word not in word_list, no valid path
+     // Check if end_word is in word_list by iterating
+     var $end_found { value = false }
+     foreach ($input.word_list) {
+       each as $word {
+         conditional {
+           if ($word == $input.end_word) {
+             var $end_found { value = true }
+           }
+         }
+       }
+     }
+     
+     conditional {
+       if (!$end_found) {
+         return { value = 0 }
+       }
+     }
```

```diff
-             var $char_code { value = 97 }  // 'a'
-             while ($char_code <= 122) {    // 'z'
+             // 'a' = 97, 'z' = 122 in ASCII
+             var $char_code { value = 97 }
+             while ($char_code <= 122) {
```

**Result:** Fail (1 error)

---

## Validation 4 - Fixed chr filter issue

**Files changed:** `function/word_ladder.xs`
**Validation errors being addressed:**
- `chr` filter doesn't exist for converting ASCII to character → Replaced with pre-defined alphabet array

**Diff:**
```diff
-     // Alphabet array for character substitution
-     var $alphabet { value = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] }
...
-             var $char_code { value = 97 }
-             while ($char_code <= 122) {
-               each {
-                 // Build new word by changing character at position $i
-                 var $before { value = $current_word|substr:0:$i }
-                 var $after {
-                   value = $current_word|substr:($i + 1)
-                 }
-                 // Convert char code to character using chr filter
-                 var $new_char {
-                   value = $char_code|chr
-                 }
-                 var $new_word {
-                   value = $before ~ $new_char ~ $after
-                 }
+     // Alphabet array for character substitution
+     var $alphabet { value = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] }
...
+             // Iterate through each letter in alphabet
+             foreach ($alphabet) {
+               each as $letter {
+                 // Build new word by changing character at position $i
+                 var $before { value = $current_word|substr:0:$i }
+                 var $after {
+                   value = $current_word|substr:($i + 1)
+                 }
+                 var $new_word {
+                   value = $before ~ $letter ~ $after
+                 }
```

**Result:** ✅ Pass (both files valid)
