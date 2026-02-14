# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 21:50 PST] - Conditional Expression Syntax Confusion

**What I was trying to do:**
Create a run job that conditionally sets the meeting type (1 for instant, 2 for scheduled) based on whether a `start_time` parameter was provided.

**What the issue was:**
I initially tried to use a `conditional` block directly inside an object definition like this:
```xs
var $meeting_payload {
  value = {
    topic: $input.topic,
    type: conditional {
      if ($input.start_time != null) { 2 }
      else { 1 }
    },
    duration: $input.duration
  }
}
```

This resulted in a validation error: "Expected an expression but found: 'conditional'"

**Why it was an issue:**
The documentation shows that `conditional` can be used as an expression to return values, but it's unclear when this works vs when it doesn't. The syntax documentation shows:
```xs
var $tier_limit {
  value = conditional {
    if ($auth.tier == "premium") { 1000 }
    elseif ($auth.tier == "pro") { 500 }
    else { 100 }
  }
}
```

But using it inside an object literal `{ ... }` doesn't seem to work. I had to restructure the code to use `conditional` outside of the object, or avoid it entirely by restructuring the logic.

**Potential solution (if known):**
The documentation could clarify that `conditional` expressions work as variable assignments but not as values inside object literals. Or, if this is supposed to work, the parser may need to be updated to handle conditional expressions inside object definitions.

---

## [2026-02-13 21:52 PST] - Validating Multi-File Projects

**What I was trying to do:**
Validate all .xs files in the run job project before committing.

**What the issue was:**
The `validate_xanoscript` tool only accepts a single `code` parameter as a string. For multi-file projects, I need to call validation separately for each file and pass the code as a string argument. This is cumbersome for larger projects with many files.

**Why it was an issue:**
When validating, I had to:
1. Read each file separately
2. Escape the content properly for shell/command line
3. Call validation for each file individually

There's no way to validate an entire folder or pass multiple files at once.

**Potential solution (if known):**
Add support for:
- `file_path` parameter to validate a file directly from disk
- `files` array to validate multiple files in one call
- Or a `folder` parameter to validate all .xs files in a directory

---

## [2026-02-13 21:55 PST] - Optional Input Parameters

**What I was trying to do:**
Define an optional input parameter for `start_time` in the function input block.

**What the issue was:**
I tried using `text? start_time` to indicate an optional text parameter. I wasn't sure if this was the correct syntax for optional parameters in XanoScript.

**Why it was an issue:**
The types documentation was in `xanoscript_docs({ topic: "types" })` but I had already moved past that. The syntax docs mentioned input blocks but didn't explicitly show how to mark parameters as optional.

**Potential solution (if known):**
The quickstart documentation could include a clear example of optional parameter syntax with the `?` marker.

---

## General Feedback

### Positive
- The `xanoscript_docs` tool is comprehensive and well-organized by topic
- The validation tool provides clear line/column error positions
- The documentation structure (file_path-based context) is helpful for getting relevant docs

### Suggestions
1. **Consolidated validation**: A way to validate an entire project/folder at once would be helpful
2. **IDE/language server**: Would be great to have LSP support for real-time validation in editors
3. **More examples**: The documentation has good examples, but more real-world integration examples (like OAuth flows) would be valuable
4. **Error message clarity**: Some errors like "Expected an expression but found: 'conditional'" could suggest alternatives or link to relevant docs
