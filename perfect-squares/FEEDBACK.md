# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 12:35 PST] - MCP Connection Issues with Stdio Transport

**What I was trying to do:** Call the `validate_xanoscript` tool on the Xano MCP server

**What the issue was:** Initially received "Unknown MCP server 'xano'" errors when trying to call the validation tool using the syntax `mcporter call xano.validate_xanoscript files:=...`

**Why it was an issue:** The tool was listed in `mcporter list` but couldn't be called directly. This blocked validation until I figured out the correct syntax.

**Potential solution (if known):** The issue was resolved by using `--args` flag with JSON payload instead of inline parameters. It would be helpful if:
1. The error message suggested using `--args` for stdio-based MCP servers
2. Documentation showed examples for both HTTP and stdio transport MCPs
3. The inline parameter syntax worked consistently across transport types

**Workaround used:**
```bash
mcporter call "xano.validate_xanoscript" --args '{"directory":"/path/to/dir"}'
```

---

## [2026-02-22 12:35 PST] - No Issues with XanoScript Syntax

**What I was trying to do:** Write XanoScript code for the Perfect Squares exercise

**What the issue was:** None - code passed validation on first attempt

**Why it was an issue:** N/A

**Potential solution (if known):** The documentation at `xanoscript_docs` was comprehensive and clear. Following the patterns from:
- `functions` topic for function structure
- `run` topic for run.job syntax  
- `quickstart` topic for common patterns (loops, conditionals, variable access)

Helped ensure correct syntax. Key helpful patterns:
- Using `$input.n` for input access (not bare `$n`)
- Using `text` not `string`, `int` not `integer`
- Using `elseif` not `else if`
- Wrapping filter expressions in parentheses when comparing
