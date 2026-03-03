# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 08:35 PST] - MCP Tool Parameter Passing Documentation

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter

**What the issue was:** The `mcporter call` command with JSON parameters was not working correctly. The MCP expects parameters in a specific format that wasn't clear from the documentation.

**Why it was an issue:** I tried multiple approaches:
1. `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` - Error about required parameters
2. `mcporter call xano validate_xanoscript --file_paths 'path1' 'path2'` - Error about expecting array
3. `mcporter call xano validate_xanoscript --directory 'path'` - Also failed

The only method that worked was directly calling the MCP server with JSON-RPC format via stdio:
```
echo '{"jsonrpc": "2.0", "id": 1, "method": "tools/call", "params": {...}}' | npx -y @xano/developer-mcp
```

**Potential solution (if known):** 
- Document the proper mcporter call syntax with examples for each parameter type
- Consider adding a CLI wrapper that makes validation easier (e.g., `npx @xano/developer-mcp validate --files *.xs`)

---

## [2026-03-03 08:36 PST] - XanoScript Documentation Completeness

**What I was trying to do:** Learn the correct XanoScript syntax for various operations (array sorting, array element access, variable updates)

**What the issue was:** The `xanoscript_docs` MCP tool returns the same general documentation regardless of the topic parameter. I called it with topics like "essentials", "syntax", "functions", and "run" but received essentially the same high-level overview each time without specific syntax details.

**Why it was an issue:** I had to infer the correct syntax by looking at existing implementations in the ~/xs/ directory. Specifically, I was unsure about:
1. How to properly access array elements: `$arr[$idx]` vs `$arr.idx`
2. How to update variables: `var.update $var { value = ... }` syntax
3. How to do array assignment/swap: The `|set:` filter syntax
4. The exact syntax for run.job calling functions

**Potential solution (if known):**
- Ensure topic-specific documentation actually returns detailed content for that topic
- Add more code examples to the documentation covering common patterns like sorting, array manipulation, and control flow
- Consider a "patterns" or "cookbook" topic with common algorithm implementations

---

## [2026-03-03 08:37 PST] - XanoScript Array Operations

**What I was trying to do:** Implement a sorting algorithm and array element swapping for the activity selection problem

**What the issue was:** Unclear what array operations are available in XanoScript. I tried to use `$input.activities|sort:"end"` but wasn't sure if this syntax is valid or if it supports sorting objects by a key.

**Why it was an issue:** Ended up implementing bubble sort manually using loops and conditional swaps, which is O(n²) instead of the optimal O(n log n). The manual implementation also required understanding:
- Array element access: `$arr[$idx]` 
- Array element update/swap: The `|set:` filter with multiple parameters
- Variable scoping inside nested loops

**Potential solution (if known):**
- Document array filters more thoroughly (sort, set, merge, etc.)
- Provide examples of sorting objects by specific keys
- Document the exact syntax for `|set:` filter when updating array elements

---

## Summary

Overall, the exercise was successful - the code validated on the first try. The main struggles were:
1. **Tool invocation:** Difficulty calling the MCP validation tool through mcporter
2. **Documentation gaps:** Topic-specific documentation didn't provide detailed syntax information
3. **Array operations:** Unclear syntax for advanced array manipulations

The existing code examples in ~/xs/ were extremely helpful for understanding patterns. Without them, this would have been much more difficult.
