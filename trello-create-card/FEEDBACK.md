# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-14 00:47 PST - MCP Tool Parameter Discovery Issue

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool from the Xano MCP.

**What the issue was:**
The MCP tool requires a `code` parameter (not `file_path` as I initially assumed). The error message `'code' parameter is required` was clear, but I had to discover this through trial and error.

**Why it was an issue:**
This caused multiple failed attempts before understanding the correct parameter name. The tool documentation didn't clearly indicate what parameters were required.

**Potential solution:**
Add clearer parameter documentation or examples to the MCP tool description. Consider supporting both `code` (raw string) and `file_path` (path to file) for convenience.

---

## 2026-02-14 00:48 PST - JSON Escaping and Shell Quoting Issues

**What I was trying to do:**
Pass XanoScript code content to the validate_xanoscript tool via mcporter CLI.

**What the issue was:**
Multiple attempts to pass the code content failed:
1. `cat file.xs | jq -Rs '{code: .}' | mcporter call xano validate_xanoscript -` - Resulted in "Expecting 'function' but found '-'" error
2. Using stdin `-` wasn't working as expected
3. Shell quoting with nested quotes caused parsing errors

The working solution was: `mcporter call xano validate_xanoscript --args "$(jq -Rs '{code: .}' ~/xs/trello-create-card/function/create_card.xs)"`

**Why it was an issue:**
Wasted significant time trying different shell piping approaches. The error "Expecting 'function' but found '-" was misleading - it made me think the XanoScript syntax was wrong when actually the JSON wasn't being passed correctly.

**Potential solution:**
- Add a `file_path` parameter alternative that reads the file directly
- Provide CLI examples in the MCP tool documentation
- Consider adding a dedicated `xano validate-file <path>` command to mcporter

---

## 2026-02-14 00:45 PST - XanoScript Documentation Depth

**What I was trying to do:**
Understand the proper syntax for `run.job` constructs and function definitions.

**What the issue was:**
The `xanoscript_docs` tool returns generic documentation that doesn't provide specific syntax details for constructs like `run.job`. I had to examine existing implementations in the ~/xs/ folder to understand the proper structure.

**Why it was an issue:**
The documentation mentions "run" as a topic but doesn't provide concrete examples of run.job syntax, input/output formats, or the relationship between run.xs and function files.

**Potential solution:**
- Add specific documentation for `run.job` syntax with complete examples
- Include a "Run Job Quick Start" section showing the file structure and naming conventions
- Document the `main`, `input`, `env` blocks for run.job specifically

---

## 2026-02-14 00:50 PST - No run.job-Specific Validation Errors

**What I was trying to do:**
Understand what constructs are validatable by the validate_xanoscript tool.

**What the issue was:**
Both the `run.xs` (run.job construct) and `function/create_card.xs` (function construct) passed validation, but I wasn't sure if run.job has different validation rules or if it's fully supported.

**Why it was an issue:**
Uncertainty about whether the run.job syntax is correct or if the validator is just lenient. The documentation doesn't clarify which constructs can be validated.

**Potential solution:**
Document which XanoScript constructs are supported by the validation tool and any limitations.

---

## Summary

Overall the MCP worked well once I figured out the correct invocation pattern. The main struggles were:
1. Parameter naming (`code` vs `file_path`)
2. Shell/JSON escaping for CLI usage
3. Lack of specific run.job documentation

The validation tool itself works correctly once invoked properly.
