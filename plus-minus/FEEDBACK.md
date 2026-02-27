# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 15:35 PST] - Tool Parameter Syntax Confusion

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The tool documentation shows the parameters as JSON-like objects (e.g., `file_path?: string, file_paths?: string[]`) but I struggled to find the correct command-line syntax for mcporter. I tried several approaches:
- `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` (JSON syntax)
- `mcporter call xano validate_xanoscript --file_path "..."` (flag syntax)
- `mcporter call xano validate_xanoscript file_path="..."` (key=value syntax)

All of these failed with various errors like "Expecting --> function <-- but found --> '- <--" or "File not found"

**Why it was an issue:** It took multiple attempts to discover that the correct syntax is:
```
mcporter call xano validate_xanoscript file_path=/full/path/to/file.xs
```

**Potential solution (if known):** 
- Provide clearer documentation or examples in the tool description showing the exact mcporter CLI syntax
- Consider accepting JSON-style parameters more consistently across tools
- The `file_paths` array parameter didn't work for me at all - unclear if it's supported in the mcporter CLI

---

## [2025-02-27 15:40 PST] - Documentation Tool Returns Generic Content

**What I was trying to do:** Get specific XanoScript syntax documentation for run jobs and functions using `xanoscript_docs`

**What the issue was:** When I called `xanoscript_docs` with topics like "run", "essentials", or "functions", I received the same generic README content instead of specific syntax guidance. For example, I wanted to see:
- The exact syntax for `run.job` constructs
- How to use `function.run` to call functions from run jobs
- Specific examples of conditional statements and loops

But the returned docs were all the same high-level overview.

**Why it was an issue:** I had to rely on reading existing exercise implementations to understand the correct syntax rather than getting definitive documentation from the MCP.

**Potential solution (if known):**
- The topic filtering doesn't seem to be working correctly - all topics return the same content
- Consider adding code examples for common patterns like run.job, function definitions, conditionals, and loops
- The `mode` parameter might help but I didn't experiment with it

---

## [2025-02-27 15:45 PST] - Ternary Operator Syntax Uncertainty

**What I was trying to do:** Use a ternary/conditional expression for handling the empty array edge case

**What the issue was:** I wanted to write something like:
```
value = $total > 0 ? ($positive_count / $total) : 0
```

But I had no documentation confirming this syntax works in XanoScript. I tried it based on intuition from other languages, but I wasn't sure if it would validate.

**Why it was an issue:** Lack of clear documentation about expression syntax and operators made me uncertain about the code I was writing.

**Potential solution (if known):**
- Document all supported operators including ternary/conditional expressions
- Provide a clear syntax reference for expressions in the essentials or syntax topics
