# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-21 10:35 PST - Filter expression parentheses requirement

**What I was trying to do:** Write a precondition to check if an input array is empty

**What the issue was:** The validation failed with: "An expression should be wrapped in parentheses when combining filters and tests"

My original code:
```xs
precondition ($input.nums|count > 0) {
```

**Why it was an issue:** I intuitively thought the filter would bind tightly to the variable and then the comparison would happen, but XanoScript requires explicit parentheses around the filter expression when combined with comparisons.

**Potential solution:** 
1. The error message was actually helpful and told me exactly what to do
2. Could consider making the parser smarter to handle this common pattern automatically
3. Documentation could include this specific pattern (filter + comparison) as a common pitfall example

---

## 2025-02-21 10:30 PST - Initial setup and MCP tool discovery

**What I was trying to do:** Call the Xano MCP `xanoscript_docs` tool to get documentation

**What the issue was:** I initially tried to use `--params '{"topic": "functions"}'` which is a common pattern in other CLI tools, but mcporter uses a different syntax.

**Why it was an issue:** Had to look up the help to find the correct syntax: `mcporter call xano.xanoscript_docs topic=functions`

**Potential solution:** The mcporter documentation or the initial MCP docs could show a quick example of the correct parameter passing syntax right at the top

---

## 2025-02-21 10:32 PST - Finding the validation tool

**What I was trying to do:** Validate my XanoScript files

**What the issue was:** I knew there was a validation tool but wasn't sure of the exact name. Had to list the xano server tools to find `validate_xanoscript`.

**Why it was an issue:** Minor friction - could be smoother if the docs mentioned the validation tool name prominently

**Potential solution:** Add a "Getting Started" section to the main Xano MCP docs that mentions `validate_xanoscript` as the essential first tool to use when writing code

---

## Overall Experience

The MCP worked well once I got the hang of it. The validation error messages are clear and actionable. The main areas for improvement are:

1. **Parameter syntax documentation** - Make the `key=value` pattern more prominent
2. **Common patterns section** - Document the "filter with comparison needs parentheses" pattern as a common gotcha
3. **Quick reference card** - A one-page cheatsheet showing the most common validation patterns would be helpful
