# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 22:35 PST] - Unknown filter function 'str_split'

**What I was trying to do:** Split a string into individual characters to iterate through them for the valid parentheses algorithm.

**What the issue was:** I initially used `$input.s|str_split:1` assuming that was the filter name and syntax for splitting a string into characters (similar to JavaScript's `split('')`). The validation failed with "Unknown filter function 'str_split'".

**Why it was an issue:** I had to guess the filter name since I didn't have immediate access to the full syntax documentation. Common variations I might have tried include:
- `str_split` (what I tried)
- `string_split`
- `split_string`
- `explode`

**Potential solution (if known):** 
1. The correct filter is `split:""` with an empty string delimiter
2. Better documentation discoverability - perhaps the MCP could suggest similar filters when an unknown one is encountered
3. A dedicated `chars` filter for this common use case would be helpful

---

## [2025-02-19 22:30 PST] - MCP parameter format confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my .xs files.

**What the issue was:** The error message said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" but I was using JSON format. I had to switch to key=value format (`directory=/Users/justinalbrecht/xs/valid-parentheses`) for the tool to accept the parameter.

**Why it was an issue:** Inconsistent parameter passing formats between different tools can be confusing. I initially tried:
- JSON format in the call: `'{"file_paths": [...]}'`
- Different parameter names like `file_paths` vs `files`

**Potential solution (if known):**
1. Consistent parameter format documentation
2. Better error messages that show example usage
3. Support for both JSON and key=value formats consistently

---

## [2025-02-19 22:25 PST] - Documentation lookup for syntax details

**What I was trying to do:** Find the correct syntax for string manipulation filters.

**What the issue was:** The `xanoscript_docs` tool returned high-level documentation rather than specific syntax details for the filters I needed. I had to search through the syntax documentation to find the `split` filter information.

**Why it was an issue:** It took multiple attempts to locate the specific information about string splitting. The documentation is comprehensive but finding the exact filter name and syntax required reading through a large document.

**Potential solution (if known):**
1. A filter reference lookup tool that accepts filter names and returns usage
2. Better search/indexing in the documentation
3. Auto-complete or suggestion features in the validation tool

---
