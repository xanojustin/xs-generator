# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 06:05 PST] - Missing to_char filter

**What I was trying to do:** Convert an integer (ASCII code) to a character in XanoScript

**What the issue was:** I assumed there would be a `to_char` filter (similar to `to_text`, `to_int`) to convert an ASCII code (65) to its character representation ("A"). The validator reported: "Unknown filter function 'to_char'"

**Why it was an issue:** This is a common operation in many programming languages (JavaScript: `String.fromCharCode()`, Python: `chr()`, PHP: `chr()`). Without this filter, I had to work around by creating a static array of letters ["A", "B", ... "Z"] and indexing into it.

**Potential solution:** Add a `to_char` or `chr` filter that converts an integer ASCII code to its single-character string representation. Example: `65|to_char` → "A"

---

## [2026-02-22 06:08 PST] - run.job syntax confusion

**What I was trying to do:** Create a run.job that calls a function and runs multiple tests

**What the issue was:** I initially wrote the run.job with a `stack` block like a function:
```xs
run.job "name" {
  stack { ... }
}
```

The validator rejected this with "The argument 'stack' is not valid in this context"

**Why it was an issue:** The documentation clearly shows the correct syntax (`main = { name: "...", input: {} }`), but my instinct from writing functions was to use `stack`. The error message was somewhat cryptic - it said "Expecting: one of these possible Token sequences: 1. [=] 2. []" which doesn't immediately suggest "use main = { } syntax".

**Potential solution:** The error message could be more helpful: "run.job requires a 'main' property, not 'stack'. Use: main = { name: 'function_name', input: {} }"

---

## [2026-02-22 06:10 PST] - response placement in functions

**What I was trying to do:** Return data from a function after building it inside the stack block

**What the issue was:** I placed the `response = ...` assignment inside the `stack` block at the end. The validator expected a closing `}` but found `response`.

**Why it was an issue:** The documentation shows `response = $result` outside the stack block, but it's easy to miss since the stack block contains most of the logic. The error message "Expecting --> } <-- but found --> 'response'" was actually pretty clear once I understood the structure.

**Potential solution:** The error message was reasonably clear, but maybe the docs could emphasize more strongly that `response` is a peer of `stack`, not a child.

---

## [2026-02-22 06:12 PST] - MCP validate_xanoscript works well

**Positive feedback:** The `validate_xanoscript` tool is excellent! It:
- Reports multiple errors at once
- Shows exact line and column numbers
- Displays the problematic code snippet
- Distinguishes between syntax errors and unknown filters

This made the fix iteration cycle very fast. Great developer experience!

---

## General Notes

The pattern I ended up with (a run.job that calls a test runner function, which in turn calls the actual solution function) feels a bit indirect but works. It would be nice if run.job could directly specify multiple function calls or have a way to run a sequence, but the current approach is clean and modular.
