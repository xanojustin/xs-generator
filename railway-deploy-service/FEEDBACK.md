# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-16 05:20 PST - MCP Server Connection Issues

**What I was trying to do:**
Call the Xano MCP validate_xanoscript tool using mcporter

**What the issue was:**
The mcporter tool couldn't find the 'xano' MCP server even though it was shown in `mcporter list xano --schema`. Got error:
```
[mcporter] Unknown MCP server 'xano'.
```

**Why it was an issue:**
Had to figure out how to call the MCP server directly via npx with stdio, which was non-obvious and required crafting raw JSON-RPC requests.

**Potential solution:**
- Better mcporter integration documentation
- Auto-registration of MCP servers in mcporter config
- Or provide a CLI wrapper like `xano validate <file.xs>`

---

## 2026-02-16 05:22 PST - JSON-RPC Method Name Confusion

**What I was trying to do:**
Call the validate_xanoscript tool via JSON-RPC

**What the issue was:**
Initially tried calling `tools/validate_xanoscript` directly but got "Method not found" error. Had to use `tools/call` with the tool name in params instead.

**Why it was an issue:**
The MCP protocol requires calling `tools/call` with the actual tool name in the params, not calling the tool name as the method directly. This wasn't immediately obvious.

**Potential solution:**
- Document the correct JSON-RPC calling pattern in MCP docs
- Provide a simple CLI: `npx @xano/developer-mcp validate file.xs`

---

## 2026-02-16 05:25 PST - Input Filters Syntax Confusion

**What I was trying to do:**
Define required input fields with filters in a function

**What the issue was:**
Tried multiple wrong syntaxes:
```xs
// Wrong 1: filters as property
filters = ["trim", "required"]

// Wrong 2: filters inline with required
filters=trim|required

// Wrong 3: filters as assignment
filters = required
```

The correct syntax is:
```xs
text project_id filters=trim {
  description = "..."
}
```
And `required` is NOT a filter - it's implicit when there's no `?` modifier.

**Why it was an issue:**
The documentation shows `text name filters=trim` but doesn't clearly explain that:
1. `required` is not a filter you can apply
2. Required is the default (no `?` means required)
3. The `?` modifier makes it optional, not the other way around

**Potential solution:**
- Add a clear section in types docs explaining required vs optional
- Show a comparison table of wrong vs right syntax
- Consider adding `required` as an explicit filter for clarity (even if redundant)

---

## 2026-02-16 05:30 PST - Filter `required` Error Message

**What I was trying to do:**
Use `filters=trim|required` on text inputs

**What the issue was:**
Got error: "Filter 'required' cannot be applied to input of type 'text'"

This was confusing because `required` semantically makes sense for text fields.

**Why it was an issue:**
The error message suggests `required` exists but can't be used on text, when actually `required` isn't a filter at all - it's part of the type modifier system (`?` for optional).

**Potential solution:**
- Better error message: "'required' is not a filter. Use 'text name' for required fields, 'text name?' for optional"
- Or add `required` as a no-op filter that validates the field is required

---

## 2026-02-16 05:32 PST - Input Block Multi-line Requirement

**What I was trying to do:**
Define multiple inputs in the input block

**What the issue was:**
Initially thought this would work:
```xs
input {
  text project_id filters=trim { description = "..." }
  text service_name filters=trim { description = "..." }
}
```

But the documentation says multi-line inputs each need to be on their own line (no wrapping). The braces with descriptions make it unclear if this counts as multi-line.

**Why it was an issue:**
Ambiguity about what constitutes "one line" when there are braces involved.

**Potential solution:**
- Clarify in docs: inputs with `{ description = ... }` blocks count as multi-line and need separate lines
- Or allow single-line format even with descriptions

---

## Summary

The Xano MCP works well once you figure out the calling pattern, but the learning curve for XanoScript syntax is steep due to:
1. Implicit vs explicit concepts (required being default)
2. Filter syntax placement
3. Lack of clear error messages guiding to correct syntax

The validation tool is excellent - once I got it working, it caught my errors quickly with line/column info. The main friction was understanding the correct syntax to begin with.
