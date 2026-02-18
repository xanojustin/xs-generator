# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-18 14:47 PST - MCP Parameter Naming Confusion

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The MCP tool requires parameters named `file_path` (or `file_paths`, `directory`, or `code`) but the documentation I initially saw suggested using `path`. When I tried `path="/path/to/file"`, I got an error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** This blocked validation until I figured out the correct parameter name. The error message was clear enough, but it would be helpful if the documentation explicitly showed the correct parameter names.

**Potential solution (if known):** 
- Update the MCP server documentation to show example calls with correct parameter names
- Consider accepting `path` as an alias for `file_path` for convenience
- Add examples in the docs showing: `validate_xanoscript(file_path: "/path/to/file.xs")`

---

## 2026-02-18 14:47 PST - Lack of Tool Schema Discovery

**What I was trying to do:** Understand what parameters the `validate_xanoscript` tool accepts

**What the issue was:** I couldn't easily discover the tool's schema without trial and error. I had to guess the parameter names based on the error message.

**Why it was an issue:** This slowed down development as I had to make multiple attempts to find the right parameter format.

**Potential solution (if known):**
- Add a `schema` parameter to tools that returns the expected input schema
- Or add documentation comments in the MCP server that get exposed via the protocol

---

## 2026-02-18 14:45 PST - Initial MCP Access Confusion

**What I was trying to do:** Call `xanoscript_docs` on the xano MCP as instructed in the task

**What the issue was:** I wasn't sure if the MCP was already configured or how to access it. I had to check if `mcporter` was available and then list servers to see if xano was configured.

**Why it was an issue:** Minor friction at startup - I wasn't sure if I needed to install/configure the MCP first.

**Potential solution (if known):**
- Consider documenting the expected MCP setup in task instructions
- Or check if the task environment should pre-configure MCP servers

---

## Summary

Overall, the Xano MCP worked well once I figured out the correct parameter names. All files passed validation on the first attempt, which suggests the XanoScript documentation I retrieved was accurate and comprehensive. The main friction points were around tool discovery and parameter naming conventions.