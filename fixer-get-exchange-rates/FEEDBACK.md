# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 08:17 PST] - Array Default Value Syntax Issue

**What I was trying to do:**
Define a default value for an array input parameter in a function input block.

**What the issue was:**
I tried to use this syntax:
```xs
input {
  text[] target_currencies?=["EUR", "GBP", "JPY", "CAD", "AUD"]
}
```

This resulted in a validation error:
```
[Line 5, Column 31] Expecting: one of these possible Token sequences...
but found: '['
```

**Why it was an issue:**
The error message was cryptic and didn't clearly indicate that array literals cannot be used as default values in input blocks. I had to guess that the issue was with the array syntax and move the default value handling into the stack block using the null coalescing operator (`??`).

**Potential solution:**
- Document that array/object default values must be handled in the stack block, not in the input declaration
- Or support array literals as default values (preferred)
- Improve error message to say something like "Array default values are not supported in input blocks, use null coalescing operator in stack instead"

---

## [2025-02-18 08:15 PST] - MCP Tool Discovery

**What I was trying to do:**
Find the correct tool name for validating XanoScript files.

**What the issue was:**
Had to discover that the MCP tool is called `validate_xanoscript` by exploring available tools. The documentation mentioned validation but didn't explicitly show the tool name.

**Why it was an issue:**
Minor friction - had to run mcporter list to see available tools.

**Potential solution:**
Include the specific MCP tool names in the documentation examples so users know exactly what to call.

---

## [2025-02-18 08:15 PST] - Documentation Discovery Time

**What I was trying to do:**
Learn XanoScript syntax for creating a run job.

**What the issue was:**
Had to call `xanoscript_docs` multiple times with different topics (`run`, `quickstart`, `functions`, `integrations`, `integrations/external-apis`) to get complete information. Each call returned only partial documentation.

**Why it was an issue:**
Took 5+ API calls just to get the basic information needed for a simple run job. This is inefficient and burns tokens.

**Potential solution:**
- Add a "complete" or "all" topic that returns comprehensive documentation
- Or add cross-references in each topic showing related topics to call
- Or create a quick reference cheat sheet topic

---

## [2025-02-18 08:16 PST] - Reserved Variable Names Confusion

**What I was trying to do:**
Decide on variable naming conventions.

**What the issue was:**
The documentation lists reserved variables but doesn't explain WHY they are reserved or what happens if you use them. I initially wanted to use `$response` for my API response but had to use `$api_result` instead.

**Why it was an issue:**
Had to read through documentation to find the reserved names list and then think about alternative names.

**Potential solution:**
- Explain the purpose of each reserved variable
- Consider allowing shadowing with a warning instead of hard errors

---
