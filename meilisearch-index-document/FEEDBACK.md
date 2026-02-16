# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 07:20 PST] - validate_xanoscript Tool Interface Confusion

**What I was trying to do:**
Validate the .xs files using the Xano MCP's validate_xanoscript tool.

**What the issue was:**
Initially, I tried passing a `file_path` parameter to the validate_xanoscript tool:
```
mcporter call xano.validate_xanoscript file_path="/Users/justinalbrecht/xs/meilisearch-index-document/run.xs"
```

This returned an error: `"Error: 'code' parameter is required"`

**Why it was an issue:**
It was unclear from the initial MCP call how to use the tool. I had to read the file contents and then pass them as a `code` parameter using the `--args` JSON format, which added extra steps.

**Potential solution (if known):**
The tool could accept either:
1. A `file_path` parameter that reads the file automatically
2. A `code` parameter for direct code validation

Or the documentation could be clearer about the expected interface.

---

## [2026-02-16 07:21 PST] - JSON Escaping Complexity for Code Validation

**What I was trying to do:**
Pass multi-line XanoScript code as a JSON string to the validate_xanoscript tool.

**What the issue was:**
When using `--args` to pass the code parameter, I had to manually escape the XanoScript code for JSON:
- Escape double quotes (`"` → `\"`)
- Escape newlines
- Handle special characters like `&` in `&&` (had to use `&`)

This made the validation process cumbersome and error-prone.

**Why it was an issue:**
Validating files required constructing a complex, escaped JSON payload rather than a simple file path reference. This is particularly challenging when dealing with code that contains quotes, newlines, and special characters.

**Potential solution (if known):**
1. Support reading directly from file paths
2. Provide a simpler CLI wrapper that handles the escaping automatically
3. Allow passing code via stdin instead of JSON arguments

---

## [2026-02-16 07:15 PST] - No Direct File Path Support for Validation

**What I was trying to do:**
Validate .xs files in a directory structure without reading them first.

**What the issue was:**
The MCP tool requires the code content to be passed as a string, not as a file path. This means I have to:
1. Read the file contents
2. Escape them for JSON
3. Pass via --args

**Why it was an issue:**
In a workflow where multiple files need validation (like this run job with run.xs and function/*.xs), each file requires manual reading and escaping. This is inefficient.

**Potential solution (if known):**
Add a `file_path` parameter alternative to the `code` parameter in validate_xanoscript, or provide a batch validation mode for directories.

---

## [2026-02-16 07:18 PST] - Documentation Discovery via MCP is Excellent

**What I was trying to do:**
Learn XanoScript syntax since my training data doesn't include it.

**What worked well:**
The `xanoscript_docs` MCP tool with different topics (run, quickstart, functions, integrations, types) provided comprehensive, well-organized documentation that made it possible to write correct XanoScript code.

**Why this was helpful:**
Having structured documentation available via the MCP allowed me to understand:
- Run job structure and requirements
- Function definition patterns
- API request syntax
- Error handling with precondition vs conditional
- Input types and validation

**Potential improvements:**
1. Add a topic index or search capability to xanoscript_docs
2. Include more external API integration examples (like Meilisearch, Typesense, etc.)
3. Document common HTTP status code handling patterns

---

## [2026-02-16 07:22 PST] - Lack of Batch Validation Tool

**What I was trying to do:**
Validate all .xs files in the run job directory at once.

**What the issue was:**
Had to call validate_xanoscript twice (once for run.xs, once for function/index_document.xs) with manual file reading and JSON escaping each time.

**Why it was an issue:**
For larger projects with many files, this becomes tedious and error-prone.

**Potential solution (if known):**
Add a `validate_xanoscript_directory` tool or support for multiple `code` entries in a single call.

---

## Summary

The Xano MCP is functional and the documentation via `xanoscript_docs` is excellent. The main pain point is the validation workflow - requiring JSON-escaped code strings instead of file paths makes the development workflow more cumbersome than necessary. Adding file path support or a directory batch validation mode would significantly improve the developer experience.
