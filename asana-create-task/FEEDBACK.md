# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 03:47 PST] - Validate Tool Parameter Naming

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:**
I initially tried to pass `file_path` as the parameter, but the tool requires `code` parameter instead. The error message was:
```
Error: 'code' parameter is required
```

**Why it was an issue:**
The parameter name wasn't intuitive - I expected to pass a file path like many other tools, but instead need to pass the actual code content. This required reading the raw file content and passing it as a string.

**Potential solution (if known):**
The tool could accept either:
1. A `file_path` parameter for convenience
2. Or make the parameter name clearer in documentation
3. Or improve the error message to indicate both options if file_path support is added

---

## [2026-02-14 03:47 PST] - JSON Escaping in Shell Commands

**What I was trying to do:**
Pass XanoScript code containing newlines and special characters via the mcporter CLI

**What the issue was:**
The shell command required careful escaping of the XanoScript code. The code contains:
- Newlines
- Double quotes
- Special characters like `&` in `&&`
- Angle brackets in `>` comparison operators

Trying to pass raw code caused shell parsing errors.

**Why it was an issue:**
It took multiple attempts to get the escaping right. The `&` characters in `&&` operators needed special handling.

**Potential solution (if known):**
The MCP could provide:
1. A file_path option so users don't need to manually escape code
2. Or a helper script/tool to properly escape code for CLI usage
3. Or better documentation on how to escape complex code strings

---

## [2026-02-14 03:45 PST] - No Direct Syntax Documentation in Initial Response

**What I was trying to do:**
Understand XanoScript syntax for creating a run job

**What the issue was:**
The initial `xanoscript_docs` call without parameters returned a documentation index, but I had to make multiple additional calls to get:
1. Quickstart patterns
2. Functions documentation
3. Run job configuration
4. Integration patterns (api.request)

**Why it was an issue:**
Each topic required a separate API call, which was time-consuming. I had to discover which topics were relevant by trial and error.

**Potential solution (if known):**
Consider providing:
1. A "getting started" or "complete guide" topic that combines essential information
2. Or include more examples in the initial documentation overview
3. Or add a topic like "run-job-example" that shows a complete working example

---

## [2026-02-14 03:46 PST] - Boolean Default Values in Input

**What I was trying to do:**
Define a boolean input with a default value of `false`

**What the issue was:**
I was unsure of the correct syntax for boolean default values in the input block. The documentation shows examples with string defaults like `text currency?="usd"` but boolean examples weren't immediately clear.

**Why it was an issue:**
I had to guess the syntax `bool completed?=false` and hope it validated correctly. There was uncertainty about:
- Whether `false` should be quoted
- Whether the syntax was `bool completed?=false` or `bool completed? = false`

**Potential solution (if known):**
Add explicit examples for:
1. Boolean inputs with default values
2. Number/integer inputs with default values
3. Array inputs with default values

---

## General Observations

**What worked well:**
1. The documentation is comprehensive once you find the right topics
2. The validation tool catches syntax errors effectively
3. The pattern-based documentation (Quick Reference tables) is very helpful
4. Common mistakes section in quickstart saved time

**Suggestions for improvement:**
1. Add a "Run Job Example" topic showing a complete external API integration
2. Consider adding file_path support to validate_xanoscript
3. Provide a helper for escaping code when using CLI
4. Add more type-specific input examples (booleans, arrays, objects)
