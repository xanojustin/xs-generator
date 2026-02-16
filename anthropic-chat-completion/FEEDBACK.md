# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 15:22 PST] - MCP Parameter Passing Issues

**What I was trying to do:**
Validate XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:**
The MCP tool failed to parse parameters correctly when using standard CLI flag syntax. Multiple attempts failed:
- `mcporter call xano validate_xanoscript --file_path /path/to/file.xs` - Treated `--file_path` as code
- `mcporter call xano validate_xanoscript '{"file_path":"/path"}'` - JSON parsing failed
- `mcporter call xano validate_xanoscript --file_path=/path` - Still treated as code

**Why it was an issue:**
This blocked validation workflow and required trial-and-error to discover the correct syntax. The error messages were misleading - saying parameters were required when they were being passed.

**Potential solution (if known):**
Either fix mcporter's parameter passing or document the exact syntax required. The working syntax is: `mcporter call xano validate_xanoscript file_path=/path/to/file.xs` (no `--` prefix, no JSON, no spaces around `=`).

---

## [2026-02-16 15:25 PST] - Input Block Syntax Limitations

**What I was trying to do:**
Define input parameters with default values and optional flags in a function.

**What the issue was:**
Tried using:
```xs
input {
  text model { 
    description = "Model ID"
    default = "claude-3-5-sonnet-20241022"
  }
  text system {
    description = "System prompt"
    optional = true
  }
}
```

Got errors:
- "The argument 'default' is not valid in this context"
- "The argument 'optional' is not valid in this context"

**Why it was an issue:**
The syntax I tried is intuitive and common in other languages/APIs. Having to move default handling into the stack block adds verbosity and separation of concerns.

**Potential solution (if known):**
Add support for `default` and `optional` in input field definitions, or document this limitation clearly with examples of the workaround (handling in stack block).

---

## [2026-02-16 15:28 PST] - Array Type Naming

**What I was trying to do:**
Define an array input parameter for messages.

**What the issue was:**
Used `object[] messages` which seems natural for an array of objects. Got error: "Use 'json' instead of 'object'".

**Why it was an issue:**
`object[]` is intuitive for typed array syntax. Having to use `json` for arrays of objects feels less type-safe and clear.

**Potential solution (if known):**
Either support `object[]` syntax or document that `json` is the catch-all type for complex/array data structures in input blocks.

---

## [2026-02-16 15:30 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Check if a string input has length > 0 using filters.

**What the issue was:**
Tried: `$input.system|strlen > 0`
Got error: "An expression should be wrapped in parentheses when combining filters and tests"

Had to change to: `($input.system|strlen) > 0`

**Why it was an issue:**
The precedence rules for filters vs operators weren't intuitive. The error message helped but this is easy to forget.

**Potential solution (if known):**
Document this clearly in the syntax guide, perhaps with examples showing common filter+operator combinations.

---

## [2026-02-16 15:15 PST] - xanoscript_docs Topic Parameter Not Working

**What I was trying to do:**
Get specific documentation topics using `xanoscript_docs({ topic: "run" })`.

**What the issue was:**
Multiple attempts to pass the topic parameter failed:
- `mcporter call xano xanoscript_docs '{"topic": "run"}'` - Returned README instead
- `mcporter call xano xanoscript_docs --topic run` - Same result
- Different JSON formats all returned the README

**Why it was an issue:**
Could not access specific topic documentation for run jobs, had to rely on general README and examples from existing code.

**Potential solution (if known):**
Fix the topic parameter parsing or provide working examples in the MCP documentation.

---

## [2026-02-16 15:35 PST] - Documentation Lacks Run Job Examples

**What I was trying to do:**
Find documentation on the exact structure of `run.job` constructs.

**What the issue was:**
The general documentation covers many constructs but didn't clearly show the run.job format with its `main`, `env`, and other properties.

**Why it was an issue:**
Had to infer the correct structure by reading existing implementation files in ~/xs/ folder.

**Potential solution (if known):**
Add a dedicated "run" topic to xanoscript_docs with complete run.job and run.service syntax reference.

---

## Summary

Overall, the validation tool is helpful once you figure out the correct syntax. The main struggles were:
1. MCP parameter passing syntax (critical - blocked validation)
2. Input block limitations (default, optional not supported)
3. Type naming (object[] vs json)
4. Filter expression precedence
5. Topic documentation not accessible

The existing ~/xs/ examples were invaluable for figuring out correct patterns.
