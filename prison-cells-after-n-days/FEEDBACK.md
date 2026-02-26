# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 05:31 PST] - Bit shift operators not supported

**What I was trying to do:** Implement a bit manipulation solution for the Prison Cells problem using bit shift operators (`<<` and `>>`) to pack the 8-cell state into an integer for efficient storage and cycle detection.

**What the issue was:** XanoScript does not support bit shift operators `<<` and `>>`. When I tried to use them:
```xs
var.update $state { value = $state | (1 << (7 - $i)) }
```

I got this error:
```
[Line 24, Column 50] Expecting token of type --> Identifier <-- but found --> '(' <--
```

**Why it was an issue:** Bit manipulation is a common and efficient way to solve this particular problem. The prison cells problem naturally maps to an 8-bit integer, making bitwise operations ideal. Without shift operators, I had to rewrite the solution to use arrays and JSON encoding for state tracking, which is less efficient.

**Potential solution (if known):** 
1. Add support for bit shift operators `<<` and `>>` in XanoScript
2. Or document the `math.bitwise.*` functions more clearly to show what bitwise operations ARE available (I found `math.bitwise.and`, `math.bitwise.or`, `math.bitwise.xor` but no shifts)
3. Consider adding `math.bitwise.shift_left` and `math.bitwise.shift_right` functions

---

## [2026-02-26 05:32 PST] - Documentation discovery for bitwise operations

**What I was trying to do:** Find alternative ways to perform bit manipulation after discovering shift operators weren't available.

**What the issue was:** I found references to `math.bitwise.*` in the documentation index, but finding the actual documentation for these functions required searching through the syntax docs. The bitwise functions (`math.bitwise.and`, `math.bitwise.or`, `math.bitwise.xor`) are documented in the Math Functions section, but there's no mention of shift operations.

**Why it was an issue:** It wasn't immediately clear what bitwise operations were available without reading through the entire syntax documentation. A dedicated "Bitwise Operations" section or table would be helpful.

**Potential solution (if known):** 
1. Create a dedicated section in the docs for bitwise operations
2. Include a table showing all available bitwise functions and operators
3. Document workarounds for missing operations (e.g., use multiplication by 2 for left shift, division by 2 for right shift)

---

## [2026-02-26 05:33 PST] - Using JSON encoding for state keys works well

**What I was trying to do:** Find a way to use arrays as keys in the cycle detection map.

**What the issue was:** I needed to track seen states for cycle detection. Since XanoScript objects only support text keys, I had to encode the array state somehow.

**Why it was an issue:** Initially I was going to convert the array to a text representation manually, but then I discovered the `json_encode` filter works perfectly for this:
```xs
var $state_key { value = $current|json_encode }
```

**Positive feedback:** The `json_encode` filter made this easy! It's a nice feature that arrays can be serialized to JSON and used as object keys. This should be documented as a pattern for using complex values as map keys.

---
