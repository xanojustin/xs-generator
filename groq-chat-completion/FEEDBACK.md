# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-13 09:18 PST - MCP Validation Tool Access Issues

**What I was trying to do:**
Validate the .xs files using the Xano MCP's `validate_xanoscript` tool before committing.

**What the issue was:**
Multiple approaches to call the validation tool failed:
1. `mcporter call xano.validate_xanoscript code="..."` - Server not found error
2. `mcporter call validate_xanoscript code="..."` - Unknown MCP server
3. Using `--args` with JSON escaped content - JSON parsing errors due to special characters
4. Using `--args-file` with piped JSON - Tool metadata loading issues
5. Direct MCP server execution via `npx @xano/developer-mcp server` - Session management complexity

The validation tool works when called simply with small code snippets, but fails with larger, more complex code containing newlines, quotes, and special characters.

**Why it was an issue:**
Could not validate the function file which contains complex XanoScript with:
- Multi-line strings
- Nested objects
- Array syntax
- Variable interpolation (`~` operator)

**Potential solution (if known):**
1. Add a file-based validation option: `validate_xanoscript file_path="/path/to/file.xs"`
2. Provide a CLI tool that can validate local files directly without MCP complexity
3. Add stdin support: `cat file.xs | mcporter call xano.validate_xanoscript --stdin`

---

## 2025-02-13 09:16 PST - Documentation Discovery for api.request

**What I was trying to do:**
Find the correct syntax for making HTTP requests to external APIs in XanoScript.

**What the issue was:**
The `api.request` documentation is located in the `integrations` topic, not in `functions` or `apis` topics. This was not immediately obvious.

**Why it was an issue:**
Had to search through multiple documentation topics to find the correct syntax for external API calls. The `integrations` topic covers cloud storage, Redis, security, AND external APIs - which is a broad categorization.

**Potential solution (if known):**
1. Cross-reference `api.request` in the `functions` documentation since it's commonly used in function stacks
2. Add a "Common Patterns" or "External APIs" quick reference section

---

## 2025-02-13 09:15 PST - Input Block Default Values Syntax

**What I was trying to do:**
Define default values for input parameters in a function.

**What the issue was:**
The syntax for default values in input blocks wasn't immediately clear from the quick reference. Examples showed `text name?="default"` for optional fields, but not clearly for required fields with defaults.

**Why it was an issue:**
Had to infer from examples that `text model="llama-3.3-70b-versatile"` is the correct syntax for a required field with a default value.

**Potential solution (if known):**
Add a clearer example in the functions documentation showing:
- Required field with default: `text model="default_value"`
- Optional field: `text field?`
- Optional field with default: `text field?="default"`

---

## 2025-02-13 09:14 PST - Environment Variable Access Confusion

**What I was trying to do:**
Access environment variables in the function code.

**What the issue was:**
Initially unsure whether to use `$env.groq_api_key`, `$env["groq_api_key"]`, or some other syntax.

**Why it was an issue:**
The documentation shows `$env.<name>` in one place but examples use `$env.MY_VAR` format. Needed to confirm dot notation works for custom env vars.

**Potential solution (if known):**
Add explicit examples showing custom environment variable access in the functions and integrations sections.

---
