# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 21:05 PST] - File paths parsing issue in validate_xanoscript

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP appears to parse the comma-separated string as individual characters instead of as an array of file paths. When I passed:
```
file_paths=/Users/justinalbrecht/xs/number-complement/run.xs,/Users/justinalbrecht/xs/number-complement/function/number_complement.xs
```

It treated each character after the comma as a separate file path, resulting in errors like:
```
File not found: U
File not found: s
File not found: e
File not found: r
...
```

**Why it was an issue:** Could not use the `file_paths` parameter as documented/intended for batch validation

**Potential solution (if known):** The MCP should properly parse comma-separated values as an array, or the documentation should clarify the expected format (e.g., JSON array or repeated flags)

**Workaround used:** Used `directory` parameter instead, which worked correctly

---

## [2025-02-25 21:08 PST] - Integer division operator `//` not supported

**What I was trying to do:** Perform integer division using `//` operator (common in Python and other languages)

**What the issue was:** XanoScript doesn't support `//` for integer division. The error was:
```
Expecting: one of these possible Token sequences:
but found: '/'
```

**Why it was an issue:** Had to switch to regular division `/` which may have different behavior with floating point numbers, though in this case with integers it worked fine

**Potential solution (if known):** Document that integer division uses regular `/` and truncates automatically for int types, or provide a `math.div` or `math.floor` function for explicit integer division

---

## [2025-02-25 21:12 PST] - `for` loop syntax requires `as $variable`

**What I was trying to do:** Create a simple for loop that runs N times without needing the index

**What the issue was:** The `for` loop requires `each as $variable` syntax even if the index variable isn't used:
```
[Line 34, Column 12] Expecting --> as <-- but found --> '{' <--
```

Code that failed:
```xs
for ($bit_count) {
  each {
    math.multiply $mask { value = 2 }
  }
}
```

**Why it was an issue:** The documentation example shows `each as $i` but doesn't make it clear that the `as $variable` part is required, not optional

**Potential solution (if known):** Update the quick reference documentation to emphasize that `as $variable` is required syntax, not optional

---

## [2025-02-25 21:15 PST] - Math operation names inconsistent with documentation

**What I was trying to do:** Use `math.multiply` and `math.subtract` based on what seemed like logical naming

**What the issue was:** The actual supported operations are `math.mul`, `math.sub`, `math.add` (short forms), not the full words:
```
Expecting: one of these possible Token sequences:
  1. [add]
  2. [div]
  3. [mod]
  4. [mul]
  5. [sub]
  6. [bitwise]
but found: 'multiply'
```

**Why it was an issue:** The error message was actually very helpful and showed the correct names, but the documentation could be clearer about the short form naming convention

**Potential solution (if known):** The quick reference could list all the math operations with their exact names

---

## [2025-02-25 21:18 PST] - XOR operator `^` not directly supported

**What I was trying to do:** Use the XOR operator `^` to flip bits

**What the issue was:** The `^` operator is not directly supported in XanoScript expressions:
```
[Line 46, Column 28] Expecting --> } <-- but found --> '$mask' <--
Code at line 46: value = $input.num ^ $mask
```

**Why it was an issue:** Had to find a workaround using subtraction instead of XOR

**Potential solution (if known):** The documentation mentions `math.bitwise` is available but doesn't show the syntax for how to use it (e.g., `math.bitwise { op = "xor" }` or similar). Would be helpful to have examples of bitwise operations.

**Workaround used:** Used mathematical approach: `mask - num` instead of `num ^ mask`

---

## General Feedback

### Positive
- The validation tool is very helpful with precise line/column error reporting
- Error messages often include helpful suggestions
- The documentation structure is good with the quick reference format

### Areas for improvement
1. **File path array parsing** - Fix or document the `file_paths` parameter format
2. **Complete operator list** - A comprehensive list of supported operators in expressions
3. **Math operation reference** - A table showing all math operations with exact syntax
4. **Bitwise operations** - Documentation and examples for `math.bitwise`
5. **Loop syntax** - Clarify which parts of loop syntax are required vs optional
