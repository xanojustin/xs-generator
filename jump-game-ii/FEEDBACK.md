# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 15:35 PST] - Comment Syntax Not Documented/Unsupported

**What I was trying to do:** Add comments to the XanoScript code to document the algorithm and explain the logic

**What the issue was:** The validator rejected `//` style single-line comments with a cryptic parse error:
```
[Line 21, Column 32] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

The error message doesn't clearly indicate that `//` comments are not supported - it just says it expected a newline but found `/`.

**Why it was an issue:** I had to remove all comments from the code to make it valid. This reduces code readability and maintainability. The quickstart documentation and examples I reviewed didn't show any comment syntax, so I assumed `//` comments might work (common in many languages).

**Potential solution:** 
1. Document the supported comment syntax clearly in the quickstart or syntax documentation
2. If comments aren't supported, explicitly state this
3. If they are supported with different syntax (like `/* */` or `#`), provide examples
4. Improve the parser error message to say something like "Comments are not supported" or "Use X syntax for comments"

---

## [2026-02-22 15:32 PST] - No Comment Support in XanoScript Examples

**What I was trying to do:** Find examples of properly commented XanoScript code

**What the issue was:** Looking at existing exercises in `~/xs/`, none of them have comments in the `.xs` files. The existing code I checked (like `jump-game/function/jumpGame.xs`) has no comments either.

**Why it was an issue:** Without examples or documentation about comments, developers have to guess at the syntax or omit comments entirely.

**Potential solution:** 
1. Add a note in the xanoscript_docs about whether comments are supported
2. If not supported, explain the rationale and suggest alternatives (like descriptive variable names and the `description` field)
3. Consider adding comment support in a future version of XanoScript

---

## [2026-02-22 15:30 PST] - MCP Tool Worked Well

**Positive feedback:** The `validate_xanoscript` tool worked correctly and provided helpful error messages with line/column numbers. After fixing the comment issue, validation passed immediately.

The `xanoscript_docs` with `mode=quick_reference` was very useful for getting concise syntax information without burning too many tokens.
