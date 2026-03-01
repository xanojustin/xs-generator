# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 22:30 PST] - Initial Setup and Documentation Retrieval

**What I was trying to do:** Retrieve XanoScript documentation from the MCP before writing code

**What the issue was:** The `xanoscript_docs` topic parameter returned the same general documentation regardless of the topic specified (essentials, run, functions all returned identical content)

**Why it was an issue:** I was hoping to get specific syntax examples for run jobs and functions, but instead had to rely on existing code examples in the `~/xs/` directory to understand the proper syntax patterns

**Potential solution:** The MCP could return topic-specific documentation that includes:
- Syntax examples for each construct type (function, run.job, etc.)
- Common patterns and best practices per construct
- Error handling examples specific to the topic

---

## [2026-02-28 22:32 PST] - No validate_xanoscript Tool Found (RESOLVED)

**What I was trying to do:** Validate the XanoScript files I created

**What the issue was:** The instructions mentioned using a `validate_xanoscript` tool on the Xano MCP, but when I list the available tools, I don't see this specific tool name

**Why it was an issue:** Without validation, I cannot confirm the code is syntactically correct before committing

**Resolution:** Found the tool using `mcporter list xano --schema`. The tool is called `xano.validate_xanoscript` (with the server prefix). This is a documentation clarity issue - the instructions said to call `validate_xanoscript` on the Xano MCP, but the actual call requires the server.tool syntax: `mcporter call xano.validate_xanoscript`

---

## [2026-02-28 22:35 PST] - Inline Comments Not Supported

**What I was trying to do:** Add explanatory comments at the end of code lines

**What the issue was:** The validator failed with error: `Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: '/'`

**Why it was an issue:** I had comments like:
```xs
var $dp_idx { value = $prev_idx } // 0 * (p_len + 1) + (j - 2)
```

XanoScript only supports comments on their own lines, not inline comments after code.

**Potential solution:** The documentation could be clearer about comment placement. The error message is also confusing - it mentions "NewlineToken" but doesn't explicitly say "inline comments are not supported." A clearer error like "Comments must be on their own line" would help.

**Workaround:** Move all comments to their own lines before the code they describe:
```xs
// Index calculation: 0 * (p_len + 1) + (j - 2)
var $dp_idx { value = $prev_idx }
```

---

## [2026-02-28 22:36 PST] - Validation Tool Works Well

**What I was trying to do:** Validate XanoScript files after fixing inline comments

**What worked well:** The `validate_xanoscript` tool correctly identified all files and gave clear feedback on which passed and which failed. The directory scanning feature is convenient.

**Why it was helpful:** After fixing the inline comment issue, both files passed validation immediately. The tool provides line and column numbers for errors.

---
