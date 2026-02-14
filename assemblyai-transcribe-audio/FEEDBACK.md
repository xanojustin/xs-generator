# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 11:50 PST] - MCP Tool Invocation Difficulties

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool

**What the issue was:**
The mcporter CLI had multiple issues invoking the validation tool:
1. The `--args` flag with stdin (`-`) didn't work: "No number after minus sign in JSON"
2. The `@file.json` syntax wasn't supported: "Unexpected token '@'"
3. Passing code directly via shell escaping was extremely fragile
4. The xano MCP server wasn't always discoverable (daemon not running)

**Why it was an issue:**
I had to write a custom Node.js script to spawn the MCP server process and communicate via JSON-RPC over stdin/stdout. This is way more complex than it should be.

**Potential solution:**
- mcporter should support reading from stdin for --args
- The validation tool should accept a file_path parameter in addition to code
- Better daemon management or automatic server startup

---

## [2026-02-14 11:55 PST] - Optional Input Syntax Confusion

**What I was trying to do:**
Define optional input parameters with null defaults: `text language_code?=null`

**What the issue was:**
The validator error: "Expecting: one of these possible Token sequences... [Identifier]... but found: 'null'"

It seems `null` is not a valid default value for optional text inputs. I had to remove the default entirely (`text language_code?`) instead.

**Why it was an issue:**
The documentation shows `?=` syntax for optional fields but doesn't clearly explain what values are valid as defaults. I assumed `null` would work like in other languages.

**Potential solution:**
- Document valid default values for each type
- Allow `null` as a valid default for all nullable types
- Better error messages explaining what defaults are accepted

---

## [2026-02-14 12:00 PST] - While Loops Not Supported

**What I was trying to do:**
Implement polling logic using a `while` loop to check transcription status

**What the issue was:**
The validator error: "Expecting --> each <-- but found --> '\n'"

XanoScript doesn't support `while` loops. Only `each` (foreach) is available for iteration.

**Why it was an issue:**
I needed to poll an API until a condition was met (transcription completed). Without while loops, I had to redesign the approach to return immediately instead of polling.

**Potential solution:**
- Add `while` loop support for polling/async patterns
- Or document a recommended pattern for polling (recursion? external scheduler?)

---

## [2026-02-14 12:05 PST] - Reserved Variable Name Error

**What I was trying to do:**
Use `$response` as a variable name inside my function

**What the issue was:**
Error: "'$response' is a reserved variable name and should not be used as a variable."

I had to rename it to `$result` instead.

**Why it was an issue:**
The documentation mentions `$response` is reserved in the context of the function response, but it's also reserved for local variables. This wasn't immediately clear.

**Potential solution:**
- Document all reserved variable names clearly
- Better error message suggesting alternatives

---

## [2026-02-14 12:10 PST] - Documentation Gaps

**What I was trying to do:**
Find examples of:
1. How to properly structure run.job files
2. Valid input parameter syntax
3. Available loop constructs
4. Variable naming rules

**What the issue was:**
Had to piece together information from multiple `xanoscript_docs` calls and trial-and-error.

**Why it was an issue:**
The documentation is comprehensive but finding specific syntax details requires knowing which topic to query.

**Potential solution:**
- A single "Syntax Cheat Sheet" topic with all valid constructs
- More cross-references between related topics
- Example: a "Common Patterns" section for polling, pagination, etc.

---

## Summary

The main pain points were:
1. **Tool invocation** - mcporter CLI limitations made validation difficult
2. **Syntax discovery** - trial-and-error required to find valid patterns
3. **Missing constructs** - no while loops limits certain use cases
4. **Error messages** - could be more helpful with suggestions

The MCP server itself worked well once I figured out how to communicate with it. The validation was accurate and helpful once invoked.
