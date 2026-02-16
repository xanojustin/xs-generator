# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 10:20 PST] - MCP Tool Parameter Naming

**What I was trying to do:**
Validate XanoScript files using the MCP's `validate_xanoscript` tool.

**What the issue was:**
The error message said: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

I initially tried `file="path"` which failed. Then I tried `file_path="path"` which worked.

**Why it was an issue:**
The error message lists `file_path` as an option, but the actual working parameter name isn't clearly documented in the help output. It would be helpful to have the correct parameter name in the error message or docs.

**Potential solution:**
Update error messages to show the exact parameter names that work, or provide a help/example command showing correct usage.

---

## [2025-02-16 10:25 PST] - Reserved Variable Name Error

**What I was trying to do:**
Create a variable named `$response` to hold the response object before returning it.

**What the issue was:**
Validation failed with: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:**
I forgot that `$response` is reserved (it's in the quickstart docs but easy to miss). The error message was very helpful and suggested using `$my_response` instead.

**Potential solution:**
The error message is already excellent! It tells you exactly what's wrong and suggests alternatives. No changes needed here.

---

## [2025-02-16 10:15 PST] - Documentation Access Pattern

**What I was trying to do:**
Access XanoScript documentation via the MCP to learn the syntax.

**What the issue was:**
Had to figure out the correct command structure. Initially wasn't sure if I needed to use `xanoscript_docs` as a tool or function.

**Why it was an issue:**
The MCP has a `xanoscript_docs` tool but it took a few tries to get the syntax right: `mcporter call --stdio "npx -y @xano/developer-mcp@latest" xanoscript_docs topic=functions`

**Potential solution:**
Add a "Getting Started" example in the MCP documentation showing common commands like:
- `xanoscript_docs topic=quickstart` 
- `validate_xanoscript file_path="./file.xs"`

---

## [2025-02-16 10:30 PST] - Object Literal Syntax

**What I was trying to do:**
Create an object with key-value pairs in XanoScript.

**What the issue was:**
Initially wrote `{ key = value }` using `=` instead of `:` for object properties.

**Why it was an issue:**
This is a common mistake listed in the quickstart docs. It's different from many other languages that use `=` for object properties.

**Potential solution:**
The documentation already covers this well in "Common Mistakes" section. The validation could potentially catch this and give a helpful error message suggesting `:` instead of `=`.

---

## [2025-02-16 10:32 PST] - String Concatenation with Filters

**What I was trying to do:**
Concatenate strings with filtered values like `$status ~ " - " ~ $data|json_encode`

**What the issue was:**
This pattern causes a parse error. You need parentheses around filter expressions: `($data|json_encode)`

**Why it was an issue:**
This is documented in "Common Mistakes" but easy to forget. The error message from validation wasn't super clear about needing parentheses.

**Potential solution:**
The validation could detect this pattern and suggest wrapping filter expressions in parentheses.

---

## General Observations

### What Worked Well:
1. The `xanoscript_docs` tool is excellent - comprehensive documentation with examples
2. The validation tool gives helpful, specific error messages with line numbers
3. The quickstart docs with "Common Mistakes" section saved a lot of time

### Suggestions for Improvement:
1. Add a "cheat sheet" MCP command that outputs the most common patterns
2. Consider a `validate_directory` command to validate all .xs files in a folder at once
3. The `run.job` vs `run.service` distinction could use more real-world examples
4. Would be helpful to have an `init` or `scaffold` command to create boilerplate run.job structures

---

## Documentation Quality Assessment

| Topic | Rating | Notes |
|-------|--------|-------|
| Quickstart | ⭐⭐⭐⭐⭐ | Excellent examples and common mistakes |
| Functions | ⭐⭐⭐⭐⭐ | Clear structure and patterns |
| Run Jobs | ⭐⭐⭐⭐ | Good but could use more examples |
| External APIs | ⭐⭐⭐⭐⭐ | Clear patterns for api.request |
| Tasks | ⭐⭐⭐⭐⭐ | Great examples for scheduled jobs |

Overall the documentation is very high quality and made development much easier!