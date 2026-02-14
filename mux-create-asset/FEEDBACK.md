# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 14:20 PST] - Boolean Type Naming

**What I was trying to do:**
Create a function input parameter for a boolean flag (test_mode).

**What the issue was:**
I used `boolean test_mode = false` which resulted in a parse error. The correct type is `bool` not `boolean`.

**Why it was an issue:**
The error message was "Expecting --> } <-- but found --> 'boolean'" which was confusing - it didn't clearly indicate that `boolean` is not a valid type. Many languages use `boolean` (Java, TypeScript) while others use `bool` (C, C++, Go).

**Potential solution:**
- Add a clearer error message like "Unknown type 'boolean'. Did you mean 'bool'?"
- Include common type aliases in the parser for better DX

---

## [2026-02-14 14:25 PST] - Reserved Variable Names

**What I was trying to do:**
Declare a variable to hold the response data before returning it at the end of the function.

**What the issue was:**
I used `var $response` and got an error that `$response` is reserved. I then tried `var $output` and got the same error. The reserved variable names aren't clearly documented in the quickstart.

**Why it was an issue:**
Had to guess multiple variable names before finding one that worked (`$api_data`). Wasted time on trial and error.

**Potential solution:**
- List all reserved variable names in the quickstart documentation
- Or provide a helpful error: "$response is reserved, try $result or $data instead"

---

## [2026-02-14 14:28 PST] - Variable Redeclaration in Conditional Blocks

**What I was trying to do:**
Initialize a variable before a conditional block and then assign different values to it in if/else branches.

**What the issue was:**
I tried to use `var $api_data` in both the if and else branches after declaring it earlier, causing a parse error "Expecting --> } <-- but found --> ','".

**Why it was an issue:**
The error message didn't explain that I was redeclaring a variable. In many languages, variable shadowing is allowed or the error would be clearer.

**Potential solution:**
- Allow variable shadowing within conditional blocks (common in modern languages)
- Or provide a clearer error: "Variable '$api_data' already declared in this scope"

---

## [2026-02-14 14:30 PST] - MCP Tool Discovery

**What I was trying to do:**
Call the validate_xanoscript MCP tool.

**What the issue was:**
The mcporter call syntax wasn't immediately obvious. I tried `mcporter call xano.validate_xanoscript` and `mcporter call xano validate_xanoscript` before finding the correct format. Also had issues with the `--config` path when not running from the workspace directory.

**Why it was an issue:**
Took several attempts to find the right syntax with the config flag.

**Potential solution:**
- Document the exact mcporter call syntax in the skill documentation
- Maybe provide a wrapper script or command that handles config automatically

---

## [2026-02-14 14:32 PST] - Base64 Encoding Confusion

**What I was trying to do:**
Pass code to the validate_xanoscript tool via the mcporter CLI.

**What the issue was:**
Initially tried base64 encoding the code thinking that was required, but the tool expects raw text. The error showed base64 decoded content which was confusing.

**Why it was an issue:**
Wasted time encoding/decoding when the tool just wanted the raw code string.

**Potential solution:**
- Clarify in tool documentation that `code` parameter takes raw text, not base64
- Or support both formats and auto-detect

---

## General Observations

**What worked well:**
- The `xanoscript_docs` tool with topics is excellent for learning syntax
- The validation tool gives precise line/column error locations
- The quickstart documentation has good examples

**What could be improved:**
- A single "validate file" command that takes a file path would be more convenient than passing code as a string
- An "init" or "scaffold" command to create boilerplate run jobs would speed up development
- The error messages could be more helpful with suggestions for common mistakes
