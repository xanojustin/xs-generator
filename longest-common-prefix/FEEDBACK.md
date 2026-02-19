# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 23:05 PST] - Unknown filter 'strpos'

**What I was trying to do:** Write a longest common prefix function that checks if a string starts with a specific substring

**What the issue was:** I used `$current_string|strpos:$prefix` thinking there was a strpos filter (common in many languages), but it doesn't exist in XanoScript. The validation error was: "Unknown filter function 'strpos'"

**Why it was an issue:** I needed to check if the current string starts with the prefix candidate. Without strpos, I had to find an alternative approach.

**Potential solution (if known):** After checking the syntax documentation, I found the `starts_with` filter which does exactly what I need. It would be helpful if the documentation had a "common aliases from other languages" section that maps familiar function names to XanoScript equivalents:
- `strpos` (PHP/JavaScript) → `starts_with` or `contains`
- `substr` works the same
- `strlen` works the same

---

## [2025-02-18 23:10 PST] - MCP Documentation Discovery Was Smooth

**What I was trying to do:** Access the XanoScript documentation to understand syntax

**What the issue was:** None - the `xanoscript_docs` tool worked well and provided comprehensive information

**Why it was an issue:** N/A - This is a success case

**Potential solution (if known):** The documentation was well-organized with the topic-based structure. Having examples in the quickstart guide was particularly helpful. Consider adding a "filter lookup by use case" section where developers can describe what they want to do and get the filter name.

---

## [2025-02-18 23:12 PST] - Empty Input Block Formatting

**What I was trying to do:** Write the function structure

**What the issue was:** None - I remembered from previous exercises that empty input blocks need braces on separate lines

**Why it was an issue:** N/A - Success case, knowledge carried over from FizzBuzz exercise

**Potential solution (if known):** The validation error message for this case is clear. The documentation in the functions topic explicitly mentions this requirement which is helpful.

---

## [2025-02-18 23:15 PST] - Array Index Access Syntax

**What I was trying to do:** Access array elements by index using `$input.strings[$i]`

**What the issue was:** I wasn't 100% sure if this syntax was correct, but the validator accepted it. The documentation doesn't have a clear example of array index access with variables.

**Why it was an issue:** Minor uncertainty about syntax - it worked but I wasn't sure if it was the "right" way

**Potential solution (if known):** Add a specific example in the array filters section showing variable-based index access like `$array[$index]` vs literal access `$array[0]`.

---
