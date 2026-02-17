# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 18:16 PST] - JSON Parameter Passing Issue

**What I was trying to do:**
Call the `validate_xanoscript` tool with JSON parameters to validate my XanoScript files.

**What the issue was:**
The mcporter call syntax for JSON parameters was unclear from the documentation. Multiple attempts failed:
- `mcporter call xano validate_xanoscript '{"topic": "run"}'` - failed with "unknown sort specifier"
- `mcporter call xano xanoscript_docs --topic run --mode quick_reference` - failed with "too many positional arguments"
- `mcporter call xano validate_xanoscript '{"directory": "/path"}'` - failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:**
I couldn't figure out the correct syntax to pass JSON parameters to MCP tools. The tool expects properly formatted JSON but shell escaping and the mcporter CLI argument parsing made it difficult.

**Potential solution:**
The SKILL.md for mcporter mentions `--args` flag which eventually worked: `mcporter call xano.validate_xanoscript --args '{"directory":"/path"}'`. This should be more prominently documented or the error messages should suggest using `--args` for JSON parameters.

---

## [2025-02-16 18:17 PST] - Run Job Documentation Incomplete

**What I was trying to do:**
Understand the proper structure and syntax for Xano run jobs.

**What the issue was:**
The `xanoscript_docs` tool returned the same generic documentation for all topics (run, quickstart, etc.) - just the overview/quick reference without topic-specific details. I had to examine existing implementations in the ~/xs folder to understand the actual run.job syntax.

**Why it was an issue:**
Without access to existing examples, I would not have known:
- The exact syntax for `run.job` blocks
- The structure of the `main`, `input`, and `env` fields
- How to reference functions from run jobs

**Potential solution:**
The xanoscript_docs topic parameter should return topic-specific documentation. The "run" topic should return detailed run job syntax, examples, and configuration options specific to run jobs.

---

## [2025-02-16 18:18 PST] - Missing XanoScript Syntax Documentation

**What I was trying to do:**
Write proper XanoScript code for an API integration (Shopify).

**What the issue was:**
I couldn't find detailed documentation on:
- How to construct JSON payloads with nested objects
- The proper way to use filters like `join` on arrays
- How to concatenate strings with the `~` operator
- The exact syntax for conditional blocks and throw statements

**Why it was an issue:**
I had to infer syntax from existing examples. For example, I wasn't sure if `$input.tags|join:","` was valid syntax for joining an array into a comma-separated string for Shopify's tags field.

**Potential solution:**
Provide more comprehensive syntax documentation with examples for:
- String operators (concatenation with `~`)
- Array filters (join, map, filter)
- JSON object construction
- Error handling patterns (throw, try/catch if supported)

---

## [2025-02-16 18:19 PST] - No Tool Discovery for xanoscript_docs

**What I was trying to do:**
List available documentation topics before calling xanoscript_docs.

**What the issue was:**
There's no way to list available topics for xanoscript_docs. I had to guess based on the index table returned in the documentation.

**Why it was an issue:**
I wasn't sure which topics were valid or what they contained before calling them.

**Potential solution:**
Add a `xanoscript_docs_list` tool or include a `--list-topics` flag to show available documentation topics.

---

## [2025-02-16 18:20 PST] - Validation Tool Worked Well

**What I was trying to do:**
Validate my XanoScript files before committing.

**What happened:**
Once I figured out the correct `--args` syntax, the validation tool worked perfectly and gave clear output showing all files were valid.

**Positive feedback:**
The validation tool is helpful and provides good feedback when files are valid. The error message format with line/column information would be useful for debugging syntax errors.

---
