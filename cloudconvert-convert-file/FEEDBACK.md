# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 03:25 PST] - While Loops Not Supported

**What I was trying to do:**
Create a polling loop to check the status of a CloudConvert conversion job until it completed.

**What the issue was:**
Attempted to use a `while` loop which resulted in a parse error: "Expecting --> 'each' <-- but found --> '\n' <--". 

**Why it was an issue:**
XanoScript does not support `while` or `for` loops. The documentation doesn't clearly list what control flow structures AREN'T available. I had to discover through trial and error that only `conditional` (if/elseif/else) and `each` (for array iteration) are supported.

**Potential solution (if known):**
- Document clearly what control flow structures are available vs not available
- Consider adding `while` loop support for polling/waiting use cases
- Or provide a `util.poll` helper for common polling patterns

---

## [2026-02-16 03:27 PST] - Reserved Variable Name '$response'

**What I was trying to do:**
Create a variable named `$response` to build the function response before returning it.

**What the issue was:**
Got error: "'$response' is a reserved variable name and should not be used as a variable."

**Why it was an issue:**
I needed to build up a complex response object incrementally before returning it. The reserved name restriction wasn't obvious, and the error only appeared during validation.

**Potential solution (if known):**
- Document the list of reserved variable names in the syntax guide
- Or allow `$response` as a local variable since `response = ...` is the actual return syntax

---

## [2026-02-16 03:22 PST] - Index Type 'index' Not Valid

**What I was trying to do:**
Create database table indexes using type `"index"` based on common SQL terminology.

**What the issue was:**
Error: "Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`"

**Why it was an issue:**
The documentation doesn't clearly specify what index types are available. I assumed `"index"` was a valid generic index type.

**Potential solution (if known):**
- Document all valid index types and when to use each
- Consider aliasing `"index"` to `"btree"` for better UX

---

## [2026-02-16 03:18 PST] - Validate Tool Requires 'code' Parameter Not 'file_path'

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool by passing a file path.

**What the issue was:**
The tool requires a `code` parameter with the actual file content, not a `file_path`. The error message was: "'code' parameter is required"

**Why it was an issue:**
It's cumbersome to read files and pass their content via command line, especially with special characters that need escaping.

**Potential solution (if known):**
- Support both `code` and `file_path` parameters
- Or document clearly that file content must be passed, not paths

---

## [2026-02-16 03:20 PST] - MCP Server Connection Drops

**What I was trying to do:**
Run multiple validate calls in a loop to validate all .xs files in the folder.

**What the issue was:**
Got "Unknown MCP server 'xano'" error when trying to validate files in a loop. The MCP connection seems to drop between calls.

**Why it was an issue:**
Had to validate files individually instead of batching them, which was slower.

**Potential solution (if known):**
- Improve MCP server connection persistence
- Or add a batch validate function that accepts multiple files

---

## [2026-02-16 03:15 PST] - Foreach/Each Syntax Confusion

**What I was trying to do:**
Loop through an array of tasks from the CloudConvert API response.

**What the issue was:**
Initially tried `foreach ($array) { each as $item { ... } }` based on seeing both keywords in documentation, but the correct syntax is `each ($array as $item) { ... }`.

**Why it was an issue:**
The quickstart documentation shows `each ($items as $item)` but also mentions `foreach` in some contexts. The relationship between these wasn't clear.

**Potential solution (if known):**
- Clarify in documentation that `each` is the loop construct, `foreach` is not a separate keyword
- Or show more examples of array iteration patterns

---

## General Feedback

**Documentation Gaps:**
- No clear list of reserved words/variable names
- No explicit list of control flow structures (and which are NOT supported)
- Index types not documented
- While loops not mentioned as unsupported

**MCP Tool Improvements:**
- Would be helpful to have `validate_xanoscript_files` that accepts a glob pattern
- Better error messages showing the actual invalid code snippet

**XanoScript Wishlist:**
- While loops for polling scenarios
- Break/continue for loop control
- Support for `$response` as a local variable name

