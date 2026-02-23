# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 20:35 PST] - mcporter call syntax confusion

**What I was trying to do:** Call the `validate_xanoscript` tool on the Xano MCP server

**What the issue was:** The mcporter CLI syntax was unclear. I tried multiple approaches:
1. `mcporter call xano validate_xanoscript '{"files": [...]}'` - JSON argument didn't work
2. `mcporter call xano validate_xanoscript --directory path` - flag syntax didn't work
3. Various other combinations failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** It took 5+ attempts to find the correct syntax. The error messages were not helpful in guiding toward the correct format.

**Potential solution (if known):** The correct syntax that eventually worked was:
```
mcporter call xano.validate_xanoscript --args '{"directory": "/path/to/dir"}'
```

The documentation could be clearer that:
1. Tool names use dot notation: `server.tool` not `server tool`
2. JSON arguments must use `--args` flag
3. The key name is `directory` not `path` or `folder`

---

## [2026-02-22 20:32 PST] - xanoscript_docs returns same generic content

**What I was trying to do:** Get specific syntax documentation for functions and quickstart topics

**What the issue was:** Calling `xanoscript_docs` with topics `quickstart` and `functions` returned the same generic overview documentation, not specific syntax details for writing functions.

**Why it was an issue:** I couldn't get detailed syntax information about:
- How to write loops in functions
- What operators are available
- How conditionals work
- Stack variable declaration patterns

**Potential solution (if known):** The documentation system may not be returning topic-specific content, or the topics don't exist as separate documents. Either the docs should return specific content per topic, or the available topics list should be accurate.

I had to resort to reading existing implementations in `~/xs/` to understand the correct syntax patterns, which worked but defeats the purpose of having documentation tools.
