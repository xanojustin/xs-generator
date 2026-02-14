# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 06:47 PST] - Object vs json Type Confusion

**What I was trying to do:**
Create a function with an `object` type input parameter to accept arbitrary JSON payload data.

**What the issue was:**
Using `object payload` in the input block caused a cryptic parse error: "Expecting --> { <-- but found --> ' <--" at the line declaring the parameter. The error message was misleading - it suggested a brace issue when the actual problem was the type name.

**Why it was an issue:**
The documentation shows `object` as a valid type in examples like:
```xs
object[] items {
  schema { ... }
}
```

However, for a simple object parameter without a defined schema, `object` doesn't seem to work. I had to use `json` instead.

**Potential solution (if known):**
- Clarify in the documentation when to use `object` vs `json`
- If `object` requires a schema, provide a clearer error message like "object type requires schema definition"
- Consider supporting plain `object` for arbitrary/untyped JSON data

---

## [2026-02-14 06:48 PST] - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Validate XanoScript code using the MCP validate_xanoscript tool via mcporter CLI.

**What the issue was:**
Passing code with special characters (quotes, newlines, boolean operators like `&&`) through shell command line caused parse errors. The validator received corrupted input.

**Why it was an issue:**
Commands like:
```bash
mcporter call xano.validate_xanoscript code='function "test" { ... }'
```

Failed when the code contained double quotes, newlines, or `&&` operators. Even using `\n` and `\u0026` escape sequences didn't work reliably.

**Potential solution (if known):**
The solution was to use `--args` with proper JSON encoding:
```bash
mcporter call xano.validate_xanoscript --output json --args '{"code": "..."}'
```

However, this should be documented or the tool should accept a file path parameter for easier validation:
```bash
mcporter call xano.validate_xanoscript file_path="/path/to/file.xs"
```

---

## [2026-02-14 06:49 PST] - Misleading Error Messages

**What I was trying to do:**
Debug validation errors in my XanoScript function.

**What the issue was:**
The error "Expecting --> { <-- but found --> ' <--" was completely misleading. The actual issues were:
1. Using `object` instead of `json` type
2. Shell escaping corrupting the input

But the error suggested a brace/syntax issue at a line that was actually correct.

**Why it was an issue:**
Error messages should help developers find the actual problem. When the parser encounters an unexpected token, it should provide context about what it was trying to parse (e.g., "Invalid type 'object' in input declaration" vs "Expecting { but found '")

**Potential solution (if known):**
- Improve parser error messages to be more specific about the construct being parsed
- Include the actual token found and what was expected in that specific context
- Consider adding a "did you mean..." suggestion system for common mistakes

---

## [2026-02-14 06:50 PST] - Documentation Gap on Type System

**What I was trying to do:**
Understand which types can be used in input declarations without additional configuration.

**What the issue was:**
The documentation shows `object` being used with schemas but doesn't clearly explain:
- Whether `object` can be used standalone
- When to use `json` vs `object`
- What other types accept arbitrary data

**Why it was an issue:**
Trial and error was required to discover that `json` was the correct type for my use case. This wastes time and creates frustration.

**Potential solution (if known):**
Add a section to the types documentation explaining:
- `json` - for arbitrary/untyped JSON data
- `object` - requires schema definition for structure
- Clear examples of when to use each

---

## Summary

Overall the MCP worked well once I figured out the quirks. The main pain points were:
1. Type system documentation could be clearer
2. Error messages need improvement
3. Shell escaping made CLI usage difficult

The validate_xanoscript tool is very valuable - just needs some UX improvements to make it more developer-friendly.
