# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 18:05 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` MCP tool

**What the issue was:** The tool description shows parameters like `file_path`, `file_paths`, `directory`, etc., but the correct mcporter CLI syntax was unclear. I tried multiple JSON formats that failed:
- `'{"file_paths": [...]}'` - Error about missing required parameter
- `'{"directory": "."}'` - Same error

**Why it was an issue:** The documentation shows the tool signature but not the exact mcporter call syntax. I had to guess between:
- JSON object format: `'{"file_path": "..."}'`
- Key=value format: `file_path="..."`

**Potential solution (if known):** The `mcporter describe` output should include a clear example of the exact CLI syntax for each parameter type, not just the function signature. The current "Examples" section at the bottom is truncated and doesn't show the working format.

---

## [2026-02-22 18:08 PST] - Documentation Topic Parameter Not Working as Expected

**What I was trying to do:** Get specific XanoScript documentation for `functions` and `run` topics

**What the issue was:** Calling `xanoscript_docs({"topic": "functions"})` and `xanoscript_docs({"topic": "run"})` returned the same general documentation rather than topic-specific content

**Why it was an issue:** I wanted specific syntax documentation for run jobs and functions, but received the same generic README content each time. This made it harder to find the exact syntax patterns I needed.

**Potential solution (if known):** Either:
1. Fix the topic filtering to return relevant sections only
2. Remove the topic parameter if it's not implemented
3. Or clearly document that topics are not yet supported

---

## [2026-02-22 18:10 PST] - Working Directory Sensitivity

**What I was trying to do:** Validate files using a relative directory path

**What the issue was:** When I changed to `~/xs/reorder-list` and tried to use `directory: "."`, mcporter couldn't find the xano server ("Unknown MCP server 'xano'")

**Why it was an issue:** mcporter appears to need to run from a specific working directory to find its configuration. This isn't documented clearly.

**Potential solution (if known):** Document that mcporter should be run from the workspace directory (`~/.openclaw/workspace`) or wherever the MCP configuration is stored.

---

## Summary

Overall the validation tool worked well once I figured out the correct syntax. The main struggles were:
1. Understanding the exact mcporter CLI parameter format
2. Topics in xanoscript_docs not filtering content as expected
3. Working directory requirements being unclear

The validation itself was fast and accurate - both files passed on first attempt with helpful error messages when I tested with bad syntax earlier.
