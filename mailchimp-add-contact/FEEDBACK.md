# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 23:20 PST - Filter Expression Parentheses Issue

**What I was trying to do:**
Validate the add_contact.xs function file using the Xano MCP validate_xanoscript tool.

**What the issue was:**
The validator reported an error on line 99: "An expression should be wrapped in parentheses when combining filters and tests"

The problematic code was:
```xs
if ($tags_array|count > 0) {
```

**Why it was an issue:**
The syntax documentation mentions this rule briefly: "When concatenating strings that use filters, wrap each filtered expression in parentheses", but it wasn't immediately clear that this also applies to comparison expressions. The error message was helpful but I had to search through the syntax docs to understand the fix.

**Potential solution:**
- The quick_reference for syntax could explicitly mention this rule with an example like `if ($array|count > 0)` vs `if (($array|count) > 0)`
- A linting suggestion or auto-fix capability in the validator would be helpful

---

## 2026-02-13 23:15 PST - MCP Tool Call Format

**What I was trying to do:**
Call the validate_xanoscript tool with code from a file.

**What the issue was:**
Initially tried to use jq to construct JSON: `--args "$(cat run.xs | jq -Rs '{code: .}')"` but mcporter errored with "Unknown MCP server 'xano'". The error message was misleading - the real issue was the JSON format, not the MCP server.

**Why it was an issue:**
The error message was confusing because it said "Unknown MCP server" when actually the server is known. It took a couple attempts to find the correct syntax: `mcporter call xano.validate_xanoscript code="$CODE"`.

**Potential solution:**
- Better error messages when JSON parsing fails vs when MCP server is actually unknown
- Documentation examples for passing multi-line code strings to tools

---

## 2026-02-13 23:10 PST - XanoScript Syntax Learning Curve

**What I was trying to do:**
Write the XanoScript code for the Mailchimp function.

**What the issue was:**
The xanoscript_docs tool is excellent and provided clear examples, but I had to call it multiple times to get all the information needed (run docs, function docs, syntax docs). Also, the syntax for filters with comparison operators wasn't immediately obvious.

**Why it was an issue:**
Had to make multiple separate calls to get complete context. The syntax for `var.update` and conditional blocks could use more examples in the quick reference.

**Potential solution:**
- A combined "writing a complete run job" example that shows run.xs + function.xs together
- More examples of common patterns like building JSON payloads incrementally
- A cheat sheet specifically for the `var` and `var.update` syntax

---

## General Notes

**What worked well:**
- The validate_xanoscript tool caught the syntax error immediately
- The error message included line and column numbers which was very helpful
- The xanoscript_docs tool has comprehensive documentation
- Once I understood the parentheses rule, the fix was simple

**Overall experience:**
The development flow was smooth. The validation tool is essential - don't write XanoScript without it! The syntax is clean and intuitive once you learn the basic patterns. The main friction points were around filter expression syntax and MCP tool invocation format.
