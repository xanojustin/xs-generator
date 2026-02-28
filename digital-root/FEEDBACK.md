# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 14:35 PST] - validate_xanoscript file_paths argument format

**What I was trying to do:** Validate multiple XanoScript files using the `validate_xanoscript` tool with the `file_paths` parameter.

**What the issue was:** The MCP tool expects `file_paths` to be an array, but it's not clear from the CLI how to pass an array parameter. I tried:
1. `mcporter call xano.validate_xanoscript file_paths=/path/to/file1.xs,/path/to/file2.xs` - Failed (expects array, received string)
2. `mcporter call xano.validate_xanoscript file_paths=/path1 file_paths=/path2` - Failed (same error)

**Why it was an issue:** The tool documentation shows `file_paths` as an array type but doesn't provide clear CLI examples for how to pass arrays. This caused confusion and required trial and error.

**Potential solution (if known):** 
- Add CLI examples in the tool description showing the `--args '{"file_paths": ["path1", "path2"]}'` syntax
- Or support a simpler comma-separated format that the tool parses internally
- Or document that users should use `--args` with JSON for complex parameter types

**Resolution:** Eventually found the correct syntax: `mcporter call xano.validate_xanoscript --args '{"file_paths": ["path1.xs", "path2.xs"]}'`

---

## [2026-02-28 14:30 PST] - MCP documentation request format

**What I was trying to do:** Get XanoScript documentation using the `xanoscript_docs` tool.

**What the issue was:** Initially wasn't sure which topics to request and in what order. The documentation is comprehensive but finding the right starting point took some exploration.

**Why it was an issue:** Without guidance on which topics are essential for different use cases (e.g., "if you're writing a function, read topics X, Y, Z first"), it requires some guesswork.

**Potential solution (if known):**
- Add a "getting started" or "learning path" topic that recommends the order for reading docs
- Or add a `use_case` parameter to docs that returns relevant topics for common scenarios (function writing, API creation, etc.)

**Resolution:** Used trial and error to find that `essentials`, `functions`, and `run` were the key topics for this exercise.

---

No other issues encountered. The xanoscript_docs tool worked well once I understood the topic structure, and validation passed on the first attempt after getting the correct syntax.
