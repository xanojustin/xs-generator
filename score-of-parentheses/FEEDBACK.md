# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 17:05 PST] - xanoscript_docs unavailable in sub-agent context

**What I was trying to do:** Get XanoScript syntax documentation from the MCP using the `xanoscript_docs` tool

**What the issue was:** The sub-agent trying to call `xanoscript_docs` timed out with error "Unknown MCP server '@xano/developer-mcp'"

**Why it was an issue:** I couldn't get official syntax documentation before writing code, which led to using incorrect syntax assumptions

**Potential solution:** Ensure MCP is configured and available in sub-agent contexts, or provide fallback documentation access

---

## [2026-02-26 17:10 PST] - validate_xanoscript filter naming confusion

**What I was trying to do:** Get the length of a string in XanoScript

**What the issue was:** I assumed the filter was `|length` (common in many languages), but XanoScript uses `|strlen`. The validation error was clear but required a lookup of existing code to find the correct filter name.

Error message:
```
[Line 18, Column 27] Unknown filter function 'length'
```

**Why it was an issue:** Without access to xanoscript_docs, I had to grep through existing files to find examples of string length usage. This is inefficient.

**Potential solution:** The xanoscript_docs tool (when available) should be the primary source. Alternatively, a quick reference card for common filters (strlen, substr, split, merge, etc.) would be helpful.

---

## [2026-02-26 17:12 PST] - Substring syntax unclear

**What I was trying to do:** Extract a single character from a string at position $i

**What the issue was:** I tried array-style slicing `$input.s[$i:$i+1]` but XanoScript uses filter syntax `$input.s|substr:$i:1`

Error message:
```
[Line 20, Column 40] Expecting --> ] <-- but found --> ':' <--
```

**Why it was an issue:** The error message indicated a syntax issue but didn't suggest the correct alternative. Had to look at existing code (add_strings.xs) to find the correct `|substr:index:length` syntax.

**Potential solution:** Error messages could suggest the correct XanoScript pattern when array-style access is detected on text types.

---

## Positive Feedback

The `validate_xanoscript` tool via mcporter works well:
- Clear file-by-file results
- Line/column positioning for errors
- Batch validation via directory parameter is convenient
- The "Suggestion" feature in errors is helpful when available

---

## Recommendations

1. **Ensure MCP availability:** The @xano/developer-mcp should be accessible from sub-agents, not just the main session
2. **Quick reference:** Consider adding a `cheatsheet` mode to xanoscript_docs that returns just common patterns
3. **Better error suggestions:** When common mistakes are detected (like `|length` or array slicing on strings), suggest the XanoScript equivalent
