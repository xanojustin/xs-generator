# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 03:47 PST] - No Major Issues Encountered

**What I was trying to do:**
Create a XanoScript run job for Microsoft Graph API email sending functionality.

**What the issue was:**
No significant issues encountered during this implementation. The development process was smooth.

**Why it was an issue:**
N/A - This is a positive feedback entry documenting successful usage.

**Potential solution (if known):**
The MCP and documentation worked well. The xanoscript_docs tool provided clear guidance on:
- Run job structure (run.job vs run.service)
- Function syntax with input blocks and stack blocks
- API request patterns with error handling
- Precondition validation patterns

---

## [2025-02-16 03:48 PST] - Documentation Clarification on api.request params vs body

**What I was trying to do:**
Send POST request body data to Microsoft Graph API endpoints.

**What the issue was:**
Initially unsure whether to use `body` or `params` for the POST request payload in `api.request`.

**Why it was an issue:**
Common convention in many languages uses `body` for POST data, but XanoScript uses `params`.

**Potential solution (if known):**
The quickstart documentation actually has a "Common Mistakes" section that covers this exact issue (#3: Using `body` instead of `params` for api.request). This was helpful! However, it might be worth emphasizing this more prominently in the main syntax documentation or adding IDE autocomplete hints.

---

## [2025-02-16 03:50 PST] - Conditional elseif Syntax

**What I was trying to do:**
Create conditional logic for handling HTML vs Text email content types.

**What the issue was:**
Had to verify whether to use `else if` (two words) or `elseif` (one word).

**Why it was an issue:**
Different languages use different conventions. JavaScript uses `else if`, some languages use `elseif` or `elif`.

**Potential solution (if known):**
The quickstart documentation has a "Common Mistakes" section that explicitly shows this (#1: Using `else if` instead of `elseif`). This was very helpful. The documentation is well-structured to prevent these syntax errors.

---

## [2025-02-16 03:52 PST] - String Concatenation Pattern

**What I was trying to do:**
Build URLs and strings with variable interpolation (e.g., OAuth token URL with tenant ID).

**What the issue was:**
Understanding the proper pattern for string concatenation with the `~` operator, especially when combining with filters.

**Why it was an issue:**
The documentation mentions parentheses are needed when using filters with concatenation, which is a subtle but important detail.

**Potential solution (if known):**
The quickstart docs have clear examples of this in the "Common Mistakes" section (#2). The pattern is:
```xs
var $url { value = "https://" ~ $env.DOMAIN ~ "/path" }
```

---

## Summary

Overall, the Xano MCP server and documentation performed well:

1. **xanoscript_docs tool** - Provided comprehensive, well-organized documentation
2. **validate_xanoscript tool** - Validated both files successfully on first attempt
3. **Documentation structure** - The "Common Mistakes" section in quickstart is excellent and prevented several errors
4. **Tool availability** - mcporter integration worked smoothly

**Suggestions for improvement:**
1. Consider adding a linter or formatter CLI tool for XanoScript
2. The `api.request` documentation could emphasize `params` vs `body` more prominently
3. A syntax highlighting VS Code extension would be helpful for local development

---

*Generated during automated run job creation for microsoft-graph-send-email*