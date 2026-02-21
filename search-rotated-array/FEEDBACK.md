# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 14:05 PST] - Parameter Naming Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths

**What the issue was:** I initially tried passing parameters as JSON with camelCase (`file_paths`) but the MCP wasn't recognizing the parameter. The documentation shows the parameter as `file_paths` with underscore, but I was wrapping it in JSON incorrectly.

**Why it was an issue:** It took several attempts to figure out that the `mcporter call` command expects key=value pairs directly, not JSON-wrapped parameters. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" wasn't helpful because I was technically passing `file_paths`, just in the wrong format.

**Potential solution (if known):** 
- The MCP could accept both formats (key=value and JSON)
- Better error messages could indicate the correct format: "Expected key=value format, got JSON"
- Documentation could show more examples of the correct calling convention

---

## [2026-02-21 14:08 PST] - Documentation Not Returning Detailed Content

**What I was trying to do:** Get detailed XanoScript documentation for the `quickstart`, `functions`, and `run` topics

**What the issue was:** When calling `xanoscript_docs` with specific topics like `quickstart`, `functions`, and `run`, the MCP returned the same general overview documentation instead of the specific topic content. The documentation index says these topics exist, but the actual detailed content wasn't returned.

**Why it was an issue:** I had to rely on reading existing example files from the repo to understand the syntax patterns instead of getting official documentation. This could lead to copying potentially non-idiomatic patterns.

**Potential solution (if known):**
- Ensure topic-specific documentation is actually returned when a topic is specified
- If topics aren't implemented yet, return a message like "Topic 'quickstart' not yet documented, refer to general documentation"

---

## [2026-02-21 14:10 PST] - Lack of Syntax Reference for Common Patterns

**What I was trying to do:** Find the correct syntax for `&&` (logical AND) operator

**What the issue was:** I couldn't find documentation confirming that `&&` is the correct syntax for logical AND in XanoScript. I guessed based on common programming languages, but wasn't 100% sure it would work.

**Why it was an issue:** Without clear operator documentation, developers have to guess or trial-and-error basic syntax elements.

**Potential solution (if known):**
- A syntax reference page showing all operators: arithmetic, logical, comparison
- Examples of common conditional patterns

---

## Positive Feedback

**Validation Tool Works Well:** Once I figured out the correct calling format, the validation tool was fast and accurate. It correctly identified both files as valid and gave a clear summary.

**Existing Examples Were Helpful:** Reading the existing `fizzbuzz` and `binary-search` implementations in the repo provided clear patterns to follow.

**Overall Experience:** After the initial parameter confusion, the development workflow was smooth. The XanoScript syntax is intuitive if you have experience with similar declarative languages.
