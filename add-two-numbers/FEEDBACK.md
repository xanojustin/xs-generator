# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 14:05 PST] - Comment restrictions in run.job input blocks

**What I was trying to do:** Create a run.xs file with comments inside the input block to document the test data

**What the issue was:** The validator rejected the file with error "Expected an object {} but found '{'" pointing to the line with `input: {`

**Why it was an issue:** This error message was confusing - it suggested the issue was with the opening brace, but the actual problem was comments inside the input block. I had to discover through trial and error that comments are not allowed inside the `input` block of a `run.job`.

**Potential solution:** Either:
1. Allow comments inside input blocks (preferred - comments are useful for documentation)
2. Provide a clearer error message like "Comments are not allowed inside input blocks"

---

## [2026-02-23 14:08 PST] - Blank line restrictions before function declaration

**What I was trying to do:** Create a function file with a blank line between the header comments and the function declaration for visual separation

**What the issue was:** The validator rejected the file with error "Expecting function but found \"'\"" pointing to an empty line

**Why it was an issue:** The error message was misleading - it said it found a quote character when actually it was just a blank line. This suggests the parser was confused by the blank line and gave an inaccurate error message.

**Potential solution:** Either:
1. Allow blank lines between comments and declarations (more flexible formatting)
2. Provide a clearer error message like "Unexpected blank line before function declaration"

---

## [2026-02-23 14:10 PST] - Error message clarity

**What I was trying to do:** Debug validation errors

**What the issue was:** Error messages didn't clearly indicate the actual problem

**Why it was an issue:** The error messages pointed to the wrong location or suggested wrong expectations. For example, saying "Expected function but found '\"'" when the actual issue was a blank line, not a quote character.

**Potential solution:** Improve error message context to better identify the actual structural issue. The parser should detect when unexpected tokens appear (like blank lines or comments in restricted areas) and report them specifically.
