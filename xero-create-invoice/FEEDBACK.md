# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 06:47 PST] - Initial File Validation Failure with Cryptic Error

**What I was trying to do:**
Create the initial XanoScript files (run.xs and function/create_xero_invoice.xs) and validate them using the MCP validate_xanoscript tool.

**What the issue was:**
The validation failed with errors like:
```
1. [Line 3, Column 1] Expecting --> run <-- but found --> '
' <--
```

The error message suggested there was a stray quote character, but the files looked correct when viewed. This appeared to be a character encoding or invisible character issue.

**Why it was an issue:**
The error message was confusing and didn't clearly indicate what was wrong. I had to rewrite the files completely to fix the issue. The error suggested a quote character when the actual problem was likely line endings or invisible characters from the file creation process.

**Potential solution (if known):**
- The MCP could provide clearer error messages about character encoding issues
- Suggest checking for BOM (Byte Order Mark) or line ending issues
- Provide a "fix" option or auto-cleanup for common invisible character issues

---

## [2026-02-18 06:50 PST] - Confusion About Object Syntax in Different Contexts

**What I was trying to do:**
Write the run.xs file with the proper syntax for the `main` and `input` blocks.

**What the issue was:**
There was confusion about when to use colons (`:`) vs equals (`=`) in object definitions. The run.xs documentation showed this syntax:
```
run.job "Name" {
  main = {
    name: "function_name"
    input: {
      key: value
    }
  }
}
```

But it's not immediately clear that:
1. Top-level properties use `=` (main =, env =)
2. Nested objects use `:` (name:, input:)
3. No commas are used anywhere

**Why it was an issue:**
I had to carefully study the examples in the documentation to understand the pattern. Without the quickstart docs, I would have made syntax errors.

**Potential solution (if known):**
- A syntax cheat sheet in the MCP documentation that clearly shows "In run.xs use X, in function/*.xs use Y"
- The validate tool could suggest fixes for common syntax mismatches

---

## [2026-02-18 06:52 PST] - Documentation Search Could Be Better

**What I was trying to do:**
Find documentation about the `run.job` construct specifically.

**What the issue was:**
The `xanoscript_docs` tool has topics but doesn't have a way to quickly reference just the `run.job` syntax without loading the entire "run" topic documentation (which is lengthy). 

The documentation is comprehensive but finding the specific piece of information requires scanning through large text blocks.

**Why it was an issue:**
It took extra time to locate the exact syntax for the run.job construct and understand the expected structure.

**Potential solution (if known):**
- Add a quick_reference mode that returns just syntax patterns without explanatory text
- Allow searching for specific keywords like `run.job` or `api.request`
- Provide an interactive "help" tool that answers specific syntax questions

---

## [2026-02-18 06:55 PST] - String Concatenation Syntax Not Obvious

**What I was trying to do:**
Concatenate strings for building the Authorization header (Bearer + token).

**What the issue was:**
The documentation mentions `~` as the string concatenation operator, but it's buried in the quickstart examples. It's not immediately discoverable without reading through the full quickstart guide.

**Why it was an issue:**
Had to search through documentation to find the correct operator. Common operators like `+` don't work for string concatenation in XanoScript.

**Potential solution (if known):**
- A dedicated "Operators" section in the documentation
- Better discoverability of common operators

---

## [2026-02-18 07:00 PST] - Overall Positive Experience

**What went well:**
- Once the documentation was retrieved, the patterns were clear
- The validation tool provided fast feedback
- The error messages (once visible character issues were resolved) were specific about line/column numbers
- The MCP tools are responsive and easy to use

**General suggestions:**
1. Add a "xanoscript validate --fix" option that auto-corrects common syntax errors
2. Provide a single-page syntax reference for quick lookups
3. Add a "xanoscript new" command that scaffolds a basic run.job structure
4. Consider adding JSON schema files for IDE autocomplete support
