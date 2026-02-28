# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 13:35 PST] - Response keyword inside conditional blocks

**What I was trying to do:** Return early from a function when handling edge cases (empty array, single element, already sorted array).

**What the issue was:** I tried to use `response = 0` inside a `conditional { if (...) }` block, which caused a parse error: "Expecting --> } <-- but found --> 'response' <--"

**Why it was an issue:** Coming from other programming languages, it's natural to want to return early with a value. I assumed `response =` could be used anywhere in the function to set the return value. The error message was helpful but could be more explicit about where `response` is allowed.

**Potential solution (if known):** 
- Improve error message to say something like: "'response' can only be used at the function level, not inside conditional blocks. Use 'return' to exit early or set a variable and assign to response at the end."
- Document this limitation more prominently in the functions documentation

---

## [2025-02-28 13:36 PST] - Array slice syntax uncertainty

**What I was trying to do:** Extract a subarray from the input array to find min/max values.

**What the issue was:** I wasn't sure about the slice filter syntax. I used `$input.nums|slice:$left:($right + 1)` but wasn't confident if this was correct.

**Why it was an issue:** The documentation mentions filters but doesn't provide comprehensive examples of all array filters and their parameter formats. I had to guess based on patterns from other languages.

**Potential solution (if known):**
- A more comprehensive filter reference with parameter examples would be helpful
- Especially for array operations like slice, map, filter, etc.

---

## [2025-02-28 13:37 PST] - MCP file_paths parameter type confusion

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter.

**What the issue was:** I initially tried passing `file_paths="["...", "..."]"` as a JSON string, but got an error: "expected array, received string". I had to switch to using the `directory` parameter instead.

**Why it was an issue:** The MCP schema shows `file_paths?: string[]` but it's not clear from the CLI how to pass an actual array vs a string representation of an array.

**Potential solution (if known):**
- Document how to pass array parameters via mcporter CLI
- Or support both array JSON strings and actual arrays

---

## General Observations

**Positive:**
- The validation tool is very helpful with line/column numbers
- The suggestions for common mistakes (like using "int" instead of "integer") are useful
- The `xanoscript_docs` tool is comprehensive

**Could be improved:**
- More examples in the documentation for real-world algorithms
- A quick reference card for common patterns (early return, array manipulation, etc.)
