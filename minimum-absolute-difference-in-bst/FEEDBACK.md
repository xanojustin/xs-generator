# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-02 22:35 PST - Inline comments not allowed on same line as code

**What I was trying to do:** Write a comment on the same line as code to document what the value 2147483647 represents (Max int).

**What the issue was:** The validator rejected the line `var $min_diff { value = 2147483647 }  // Max int` with error: "Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: '/'"

**Why it was an issue:** Common programming languages (JavaScript, Python, Java, etc.) all support inline comments after code on the same line. This is a natural way to document specific values without cluttering the code with separate comment lines.

**Potential solution (if known):** 
- Either update the parser to allow `//` comments anywhere (not just at the start of lines)
- Or document this restriction clearly in the XanoScript documentation under the "Comments" section

---

## 2026-03-02 22:30 PST - Initial MCP validation workflow

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:** The tool requires specific parameter format (`file_paths` array with absolute paths) which wasn't immediately clear from the documentation. I initially tried `files` parameter and relative paths which failed.

**Why it was an issue:** Had to experiment to find the correct parameter name and that absolute paths were required.

**Potential solution (if known):** 
- Document the exact parameter format in the MCP tool description
- Allow relative paths (relative to working directory)
- Consider adding an example call in the tool description
