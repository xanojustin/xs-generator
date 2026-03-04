# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 23:05 PST] - Object Array Schema Definition

**What I was trying to do:** Define an input parameter for an array of coordinate pairs (balloons represented as [x_start, x_end])

**What the issue was:** I initially tried to define the schema using numeric indices like `int 0` and `int 1` to represent tuple-like arrays:
```xs
schema {
  int 0
  int 1
}
```

This resulted in: `Expecting token of type --> Identifier <-- but found --> '0' <--`

**Why it was an issue:** XanoScript doesn't support numeric field names in schemas. I had to use named fields (`start` and `end`) instead, which also required changing the input format from arrays to objects in run.xs.

**Potential solution (if known):** 
- Better documentation or examples for array-of-tuple patterns
- Support for tuple/array schemas where elements don't need names (e.g., `int[]` for fixed-size tuples)
- A note in the types documentation about this limitation

---

## [2026-03-03 23:08 PST] - Filter Expression Parentheses

**What I was trying to do:** Compare the count of an array to zero in a conditional

**What the issue was:** I wrote:
```xs
if ($input.points|count == 0) {
```

This resulted in: `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:** Filters bind greedily to the left, so the parser was treating `count == 0` as a filter argument. The fix was:
```xs
if (($input.points|count) == 0) {
```

**Potential solution (if known):**
- The quick_reference documentation covers this well - I should have checked it first
- Perhaps the error message could suggest the fix more explicitly: "Wrap $input.points|count in parentheses"

---

## [2026-03-03 23:08 PST] - Early Return Syntax

**What I was trying to do:** Return early from a function with a value

**What the issue was:** I tried:
```xs
response = 0
return
```

This resulted in a parse error because `response` is not valid inside the stack block.

**Why it was an issue:** I didn't know the correct early return syntax. The proper syntax is:
```xs
return { value = 0 }
```

**Potential solution (if known):**
- Make the early return syntax more prominent in the function documentation
- The essentials quick_reference has it, but it's easy to miss
- Perhaps add a dedicated "Early Return" section in the functions documentation with multiple examples

---

## General Feedback

**What worked well:**
- The MCP validation tool is very helpful with clear error messages
- The quick_reference mode of xanoscript_docs is concise and useful
- Having both topic and file_path modes for docs is great

**What could be improved:**
- More examples of common patterns (like coordinate pairs, matrix inputs, etc.)
- A migration guide from common languages (JS/Python) showing equivalent patterns
- Validation could suggest fixes for common mistakes (like missing parentheses on filters)
