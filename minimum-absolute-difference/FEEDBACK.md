# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 11:35 PST] - Array length filter confusion

**What I was trying to do:** Get the length of an array in XanoScript

**What the issue was:** I initially used `|length` filter thinking it would return the array length (common in many languages), but the validator reported: `Unknown filter function 'length'`

**Why it was an issue:** This is a common filter name in many templating languages and programming frameworks (JavaScript, Python, Liquid, etc. all use `length`). Having to guess the correct filter name is frustrating.

**Potential solution:** 
- The Xano MCP documentation could include a quick reference table of common filters
- The error message could suggest the correct filter name (`Did you mean 'count'?`)
- Aliasing `length` to `count` would help developers coming from other languages

## [2025-02-28 11:32 PST] - MCP validate_xanoscript parameter format unclear

**What I was trying to do:** Call the validate_xanoscript tool with file paths

**What the issue was:** I initially tried various JSON formats that didn't work:
- `'{"files": [...]}'` - wrong key name
- Passing JSON directly as argument - didn't parse correctly

**Why it was an issue:** The MCP tool documentation didn't clearly indicate that I needed to use `--args` flag with JSON for complex parameters.

**Potential solution:** 
- Document the expected parameter format in the tool description
- Provide examples in the xanoscript_docs output showing how to call validation
- Support more intuitive parameter passing like `file_paths=path1,path2`

---

**Note:** The Xano MCP `xanoscript_docs` tool is helpful but the documentation returned is quite generic. Having more specific syntax examples for:
- Common array operations (sort, count, slice, access by index)
- Variable update patterns
- Loop constructs

would significantly reduce the trial-and-error cycle.
