# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-19 23:32 PST - MCP Server Discovery Issues

**What I was trying to do:** Call the `validate_xanoscript` tool on the Xano MCP to validate my code.

**What the issue was:** The MCP server name wasn't being found when calling `mcporter call xano validate_xanoscript ...` from within the `~/xs/queue-operations` directory. The error was "Unknown MCP server 'xano'".

**Why it was an issue:** I had to figure out that the xano MCP was configured with a specific working directory (`/Users/justinalbrecht/.openclaw/workspace/config`). I had to run mcporter commands from the workspace directory instead of from the exercise directory.

**Potential solution:** The MCP configuration could either:
1. Allow the server to be discovered from any directory
2. Document the working directory requirement more prominently
3. Support a `--cwd` override in mcporter call commands

---

## 2025-02-19 23:35 PST - File Path Resolution in Validation

**What I was trying to do:** Validate the XanoScript files using relative paths.

**What the issue was:** When calling `validate_xanoscript` with relative paths like `"run.xs"`, the tool couldn't find the files because it was looking relative to the MCP's configured working directory, not my current directory.

**Why it was an issue:** I had to use absolute paths (`/Users/justinalbrecht/xs/queue-operations/run.xs`) for the validation to work.

**Potential solution:** 
1. The validation tool could resolve paths relative to the current working directory
2. Or add a `directory` parameter to set the base path for relative file paths
3. Document this behavior clearly in the tool description

---

## 2025-02-19 23:36 PST - Unclear Input Optional Syntax

**What I was trying to do:** Mark an input parameter as optional using `optional = true`.

**What the issue was:** The validation error said "The argument 'optional' is not valid in this context" and "Expected value of `optional` to be `null`". This was confusing because I thought `optional = true` would be the correct way to mark something optional.

**Why it was an issue:** I had to remove the `optional = true` entirely. I'm still not sure what the correct syntax is for optional inputs, or if all inputs are implicitly optional in XanoScript.

**Potential solution:**
1. Clarify in documentation how to mark inputs as optional
2. If there's a different syntax (like `optional = null` or no marker at all), provide examples
3. The error message could suggest the correct approach

---

## 2025-02-19 23:37 PST - Reserved Variable Names Not Documented

**What I was trying to do:** Create a variable named `$error` to store error messages.

**What the issue was:** Got a validation error that `$error` is reserved, but the documentation I saw only listed: `$response`, `$output`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result` as reserved. `$error` was not in that list.

**Why it was an issue:** I had to rename my variable to `$error_msg`. If `$error` is reserved, it should be documented along with the other reserved variables.

**Potential solution:** Update the reserved variables list in the documentation to include `$error` and any other reserved names.

---

## 2025-02-19 23:30 PST - Limited XanoScript Syntax Documentation

**What I was trying to do:** Understand the exact syntax for XanoScript constructs like `run.job`, `function`, conditional statements, and loops.

**What the issue was:** The `xanoscript_docs` tool returned general documentation but not specific syntax patterns. I had to look at existing implementations in `~/xs/` to understand the correct syntax.

**Why it was an issue:** Without access to existing code examples, I wouldn't have known:
- The exact structure of a `run.job` with `main = { name: "...", input: {...} }`
- How to use `var.update` for incrementing counters
- The pattern for array manipulation (merge, creating new arrays)
- How to use conditional/if-elseif-else blocks

**Potential solution:**
1. Add a "syntax patterns" or "examples" topic to `xanoscript_docs` that shows common code patterns
2. Include more complete function examples in the documentation
3. Consider adding a `validate_xanoscript --fix` mode that suggests corrections

---

## 2025-02-19 23:40 PST - No Quick Reference for Common Operations

**What I was trying to do:** Find quick syntax for common operations like:
- Array operations (append, remove first element, get length)
- String operations
- Variable updates

**What the issue was:** The documentation mentioned filters like `|merge` and `|count` but didn't provide a comprehensive list or examples of how to use them in context.

**Why it was an issue:** I had to infer usage from existing code examples. For example, I wasn't sure if `$queue|merge:[$item]` was the correct way to append to an array.

**Potential solution:**
1. Add a "cheatsheet" or "quick reference" topic to the documentation
2. Include common patterns for data structure manipulation
3. Show before/after examples for array operations

---

## Summary

Overall, the MCP validation tool works well once you understand its quirks. The main pain points were:
1. Working directory sensitivity for MCP server discovery
2. Absolute path requirements for file validation
3. Incomplete documentation of reserved variable names
4. Unclear optional input syntax
5. Need for more complete syntax examples in documentation

The validation error messages were actually quite helpful (showing line/column numbers and the problematic code), which made fixing issues straightforward once I understood what they meant.
