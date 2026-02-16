# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 19:50 PST] - MCP validate_xanoscript Requires 'code' Parameter, Not File Path

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool after creating the run job files.

**What the issue was:**
The validate_xanoscript tool expects a `code` parameter containing the actual XanoScript code content, not a `file_path` parameter. My initial attempts:
```bash
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
```
Resulted in: `Error: 'code' parameter is required`

**Why it was an issue:**
Had to read the file content and pass it as a command-line argument, which caused significant shell escaping challenges. The `$` characters in XanoScript variables (`$input`, `$env`, etc.) were being interpreted by the shell.

**Potential solution (if known):**
Either:
1. Support `file_path` as an alternative to `code` parameter for easier validation
2. Provide a CLI wrapper that handles file reading automatically
3. Document the expected format more clearly with examples showing how to handle special characters

---

## [2025-02-15 19:52 PST] - Shell Escaping Nightmare for XanoScript Variables

**What I was trying to do:**
Pass XanoScript code containing `$` variables to the validator via command line.

**What the issue was:**
The shell was interpreting `$input`, `$env`, `$api_key`, etc. as shell variables before passing to mcporter. This resulted in:
- Empty strings where variables should be
- Errors like `Expecting --> function <-- but found --> '-'` because the code was malformed

**Why it was an issue:**
Took multiple attempts with different escaping strategies (single quotes, double quotes, backslash escaping) before finding a working approach using a heredoc-style script file.

**Potential solution (if known):**
1. Add a `--file` or `-f` flag to mcporter that reads directly from a file path
2. Support stdin input: `cat file.xs | mcporter call xano validate_xanoscript code=-`
3. Auto-detect if the code parameter is a file path and read it automatically

---

## [2025-02-15 19:55 PST] - Unknown Filter Functions Error

**What I was trying to do:**
Use filter functions `to_number` and `default` in my XanoScript code.

**What the issue was:**
The validator returned errors:
```
1. [Line 26, Column 37] Unknown filter function 'to_number'
2. [Line 79, Column 52] Unknown filter function 'default'
3. [Line 82, Column 46] Unknown filter function 'default'
4. [Line 96, Column 52] Unknown filter function 'default'
```

**Why it was an issue:**
The xanoscript_docs documentation shows filter syntax like `$value|trim|lower` and mentions chaining filters, but doesn't provide a comprehensive list of available filters. I assumed common filters like `to_number` and `default` would exist based on similar template languages.

**Potential solution (if known):**
1. Add a documentation topic specifically for available filters: `xanoscript_docs({ topic: "filters" })`
2. Include common filter examples in the quickstart documentation
3. Provide better error messages suggesting alternatives (e.g., "Use `??` operator instead of `|default`")

---

## [2025-02-15 19:58 PST] - Null Coalescing Operator `??` Undocumented

**What I was trying to do:**
Find the correct syntax for providing default values when a variable might be null.

**What the issue was:**
The documentation doesn't mention the `??` (null coalescing) operator that is used in existing validated code. I had to discover it by reading existing example files in the ~/xs/ directory.

Example from existing code:
```xs
var $sender {
  value = $input.from ?? "onboarding@resend.dev"
}
```

**Why it was an issue:**
Without knowing about `??`, I tried using a `|default:` filter which doesn't exist. This caused validation failures.

**Potential solution (if known):**
Add `??` to the syntax documentation with examples showing:
```xs
// Provide default when value is null
var $page_size { value = $input.page_size ?? "10" }

// Chain with object property access
var $total { value = $response|get:"total_items" ?? 0 }
```

---

## [2025-02-15 20:00 PST] - No Documentation for `run.job` Construct

**What I was trying to do:**
Create a run.xs file with the `run.job` construct and validate it.

**What the issue was:**
The validator only accepts `function` constructs. When I tried to validate the `run.xs` file containing:
```xs
run.job "Typeform Get Responses" {
  main = { ... }
  env = ["TYPEFORM_API_KEY"]
}
```

I received: `Expecting --> function <-- but found --> '-'`

**Why it was an issue:**
There's no way to validate run.job files through the MCP. I had to assume the syntax was correct based on existing examples without validation.

**Potential solution (if known):**
1. Extend validate_xanoscript to accept all XanoScript constructs (run.job, task, query, etc.)
2. Create separate validation tools for different constructs (validate_run_job, validate_task, etc.)
3. Add a validate_file tool that auto-detects the construct type from the file content

---

## [2025-02-15 20:02 PST] - xanoscript_docs Topic Parameter Not Working

**What I was trying to do:**
Get specific documentation topics like `xanoscript_docs({ topic: "tasks" })` or `xanoscript_docs({ topic: "quickstart" })`.

**What the issue was:**
Regardless of the topic parameter provided, the MCP always returned the same general documentation overview. I tried:
- `mcporter call xano xanoscript_docs '{"topic": "tasks"}'`
- `mcporter call xano xanoscript_docs '{"topic": "quickstart"}'`
- `mcporter call xano xanoscript_docs '{"topic": "run"}'`

All returned identical content.

**Why it was an issue:**
Could not access specific syntax documentation that would have helped with filter syntax, operators, and other language features.

**Potential solution (if known):**
1. Fix the topic parameter handling in the MCP
2. If topics aren't implemented, remove them from the documentation to avoid confusion
3. Provide the full comprehensive documentation as a single reference if granular topics aren't available

---

## Summary

The main pain points were:
1. **Validation workflow** - Having to pass code content instead of file paths created shell escaping complexity
2. **Missing documentation** - Key language features like `??` operator and available filters aren't documented
3. **Incomplete validation** - Can't validate run.job files, only functions
4. **Non-functional docs tool** - Topic parameter doesn't return specific documentation

Despite these issues, I was able to complete the task by:
- Reading existing validated examples from the ~/xs/ directory
- Trial and error with the validator
- Using shell script files to avoid escaping issues
