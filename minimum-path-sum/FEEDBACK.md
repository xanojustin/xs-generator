# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-20 14:35 PST - Initial Validation Success

**What I was trying to do:** Validate the newly created XanoScript files for the minimum-path-sum exercise using the MCP validate_xanoscript tool.

**What happened:** The validation passed successfully on the first attempt for both files.

**Why this was notable:** This is the first exercise where all files passed validation without any iterations or fixes needed. The code structure followed patterns learned from previous exercises.

**What worked well:**
1. The MCP tool was responsive and returned clear results
2. The validation output clearly showed "2 valid, 0 invalid"
3. The directory parameter worked as expected

## 2025-02-20 14:30 PST - MCP Parameter Format Learning

**What I was trying to do:** Call the validate_xanoscript tool with the correct parameter format.

**What the issue was:** Initially tried using JSON format for parameters (`'{"file_paths": [...]}'`), which the MCP didn't accept. The tool expects `key:value` format.

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing because I was providing those parameters, just in the wrong format.

**Potential solution:** Documentation or examples showing the expected parameter format for MCP tools would be helpful. The error message could also be clearer about the format (e.g., "Parameter provided in wrong format, expected key:value or key=value").

## General Observations

**Positive:**
- The existing exercises in ~/xs/ served as excellent reference material
- The documentation from xanoscript_docs was helpful for understanding the structure
- The validate_xanoscript tool provides quick feedback

**No significant issues encountered** - this exercise went smoothly from start to finish.
