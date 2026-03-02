# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 14:05 PST] - Blank lines after comments cause parse errors

**What I was trying to do:** Create a XanoScript function with header comments explaining the problem

**What the issue was:** The XanoScript parser fails when there's a blank line between `//` comments and the function declaration. The error message says "Expecting --> function <-- but found --> '\n' <--" which suggests the parser doesn't handle blank lines after comments properly.

**Why it was an issue:** This is unexpected behavior - most languages allow blank lines between comments and code. The error message is confusing because it says it found a newline character when it expected `function`, but the real issue is that the blank line itself is being treated as unexpected content.

**Potential solution (if known):** 
1. The parser should handle blank lines after comments gracefully
2. Or document this restriction clearly in the syntax guide
3. The error message could be improved to say something like "Blank lines not allowed after comments"

---

## [2025-03-02 14:03 PST] - Backtick expressions in conditionals unclear

**What I was trying to do:** Use modulo operator inside conditional expressions

**What the issue was:** I wasn't sure whether to use `$reduced_p % 2 == 0` or `` `$reduced_p % 2 == 0` `` in the conditional. The documentation shows backticks for expressions but it's not clear when they're required vs optional.

**Why it was an issue:** Unclear syntax leads to trial-and-error coding. I had to guess that backticks are needed for expressions containing operators.

**Potential solution (if known):** 
1. Clarify in the documentation when backticks are required
2. Provide examples showing conditionals with and without backticks

---

## [2025-03-02 14:02 PST] - No way to easily view validation errors inline

**What I was trying to do:** Get structured validation error data to automatically update CHANGES.md

**What the issue was:** The MCP returns errors in a text format that's parsed from JSON, making it harder to programmatically extract line/column numbers and error messages.

**Why it was an issue:** While the text format is human-readable, structured JSON with fields like `line`, `column`, `message`, `severity` would be more useful for automated tooling.

**Potential solution (if known):** 
1. Return validation errors in a structured JSON format
2. Or provide a `--format json` option for machine-readable output

---

## [2025-03-02 14:00 PST] - File path handling in validate_xanoscript

**What I was trying to do:** Validate files using relative paths from the exercise directory

**What the issue was:** The validator couldn't find files when using relative paths like `run.xs` and `function/mirror_reflection.xs` even though the working directory was correct.

**Why it was an issue:** Had to switch to absolute paths `/Users/justinalbrecht/xs/mirror-reflection/run.xs` which is less convenient.

**Potential solution (if known):** 
1. Support relative paths from current working directory
2. Or add a `cwd` parameter to specify the working directory
