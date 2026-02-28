# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/atbash_cipher.xs`
**Result:** FAIL (1 valid, 1 invalid)
**Errors in `function/atbash_cipher.xs`:**
- Unknown filter function 'ord' (used for getting character code)
- Unknown filter function 'chr' (used for converting code back to character)
- Parentheses issues with filter expressions

---

## Validation 2 - Replaced ASCII approach with lookup table

**Files changed:** `function/atbash_cipher.xs`
**Validation errors being addressed:** 
- `ord` and `chr` filters don't exist in XanoScript
- Cannot do character-by-character ASCII code manipulation

**Diff:**
```diff
-     var $char_code { value = $lower_char|ord }
-     // Check if character is a lowercase letter a-z
-     if ($char_code >= 97 && $char_code <= 122) {
-       // Atbash transformation: new_char = 'z' - (char - 'a') = 219 - char_code
-       var $transformed_code { value = 219 - $char_code }
-       var $transformed_char { value = $transformed_code|chr }

+     // Create the Atbash mapping object
+     var $mapping {
+       value = {
+         a: "z", b: "y", c: "x", d: "w", e: "v", f: "u",
+         g: "t", h: "s", i: "r", j: "q", k: "p", l: "o",
+         m: "n", n: "m", o: "l", p: "k", q: "j", r: "i",
+         s: "h", t: "g", u: "f", v: "e", w: "d", x: "c",
+         y: "b", z: "a"
+       }
+     }
+     
+     var $mapped { value = $mapping|get:$char }
+     
+     conditional {
+       if ($mapped != null) {
+         var.update $result { value = $result ~ $mapped }
+       }
```

**Result:** PASS (2 valid, 0 invalid)

---

**Final state:** Both files pass validation. The solution uses an object-based lookup table for character mapping instead of ASCII arithmetic.
