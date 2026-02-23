# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 11:02 PST] - Comment parsing issue with tree diagrams

**What I was trying to do:** Create a run.xs file with detailed comments explaining the test cases, including ASCII tree diagrams.

**What the issue was:** The XanoScript parser failed with error: "Expecting: Expected an object {} but found: '{'" at line 32 where the input block started. The issue appeared to be related to the multi-line comment containing ASCII tree diagrams with special characters like `/`, `\`, and `->`.

**Why it was an issue:** The error message was misleading - it suggested a syntax error in the `input:` block, but the actual problem was in the comment block above. The parser seemed to have trouble with comments containing certain character sequences or formatting.

**Potential solution:** 
1. Better error messages that indicate when the issue is in a comment block
2. Documentation about which characters/sequences are not allowed in comments
3. The parser should be more tolerant of comment content, or at least provide line-accurate error reporting

---

## [2025-02-23 11:05 PST] - MCP validate_xanoscript parameter format unclear

**What I was trying to do:** Call the validate_xanoscript tool with multiple file paths.

**What the issue was:** It took multiple attempts to figure out the correct parameter format. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" didn't indicate the correct JSON structure needed.

**Why it was an issue:** I tried several approaches before finding that `--args '{"file_paths":[...]}'` was the correct syntax. The tool schema wasn't readily available.

**Potential solution:**
1. Include example usage in the tool description
2. Support simpler parameter passing like `file_paths:path1,file_paths:path2` or positional arguments

---

## [2025-02-23 11:00 PST] - Limited documentation on run.job syntax

**What I was trying to do:** Understand the exact syntax for run.job files, particularly the `main` block structure.

**What the issue was:** The xanoscript_docs topic for "run" didn't provide specific syntax examples for run.job definitions. I had to look at existing files in the xs/ directory to understand the pattern.

**Why it was an issue:** Without working examples, it would be difficult to know that run.job uses `main = { name: "..." input: { ... } }` syntax, especially the colon-based key-value format which differs from the `key = value` format used elsewhere.

**Potential solution:**
1. Add a dedicated "run" topic to xanoscript_docs with run.job syntax examples
2. Include common patterns like calling functions with inputs, handling responses, etc.

---

## General Observations

**Positive:**
- The function syntax is clean and easy to understand once you see examples
- Recursive function calls work well (important for tree problems)
- The validation tool provides helpful line/column error reporting

**Areas for improvement:**
- The documentation index mentions "run" as a topic but the content doesn't seem to be specific to run jobs
- Error messages could be more specific about whether issues are in code vs comments
- A quick reference card for common constructs would be helpful