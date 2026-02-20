# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 16:35 PST] - MCP Server Unavailable in Execution Environment

**What I was trying to do:** Validate the XanoScript files (`run.xs` and `function/factorial.xs`) using the `validate_xanoscript` MCP tool as required by the exercise instructions.

**What the issue was:** The Xano MCP server was not configured/available in the execution environment. Multiple attempts failed:

1. `mcporter list` returned "No MCP servers configured"
2. `mcporter call xano validate_xanoscript` returned "Unknown MCP server 'xano'"
3. No config file found at `~/.mcporter/config.json`
4. The `mcporter` binary exists at `/opt/homebrew/bin/mcporter` but no server configuration was loaded

**Why it was an issue:** This blocked the validation workflow which is a critical step in the exercise requirements. Without validation:
- Cannot confirm syntax correctness
- Cannot identify and fix errors iteratively
- Cannot guarantee the code will run in Xano
- The CHANGES.md cannot properly document the write→validate→fix loop

**Potential solution (if known):**
1. Ensure the MCP server configuration persists across shell sessions
2. Document the MCP setup process in the exercise instructions for cases where the server isn't pre-configured
3. Consider adding a setup check at the start of the exercise workflow
4. Provide fallback validation method (e.g., Xano CLI if installed)

---

## [2026-02-19 16:36 PST] - Documentation Gaps for Run Job Syntax

**What I was trying to do:** Find specific documentation about the `run.job` construct syntax, particularly how it calls functions via `main = { name: ..., input: ... }`.

**What the issue was:** The `xanoscript_docs` tool with topic `run` returned generic documentation that didn't cover the specific `run.job` syntax used in the exercises. The existing exercises use a pattern like:

```xs
run.job "Test Name" {
  main = {
    name: "function_name"
    input: {
      param: value
    }
  }
}
```

But the documentation focused on `task` constructs and general workspace structure, not the `run.job` specific syntax.

**Why it was an issue:** Had to infer the correct syntax by reading existing exercise implementations rather than official documentation. This is error-prone and doesn't clarify:
- What other fields are available in the `main` block
- Whether `function.run` is an alternative syntax
- How to handle multiple test cases in one run job
- How to capture/log the function response

**Potential solution (if known):**
1. Add a specific `run` topic section covering `run.job` constructs
2. Include examples of function invocation patterns
3. Document the relationship between `run.job` and `function.run` (if they are alternatives)
4. Provide examples of run jobs with multiple test inputs

---

## [2026-02-19 16:37 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with the correct parameter format.

**What the issue was:** Initial attempts used JSON format which the MCP didn't accept:
```bash
# This didn't work:
mcporter call xano validate_xanoscript '{"file_paths": [...]}'
```

The correct format appears to be a key: value syntax, but this wasn't clear from the initial documentation.

**Why it was an issue:** Wasted multiple attempts trying different JSON variations before realizing the parameter format was different. Error messages weren't helpful in guiding toward the correct format.

**Potential solution (if known):**
1. Include clear examples of mcporter call syntax in the MCP tool descriptions
2. Improve error messages to suggest correct format when JSON is detected
3. Document the parameter format convention (appears to be `key: value` rather than JSON)

---

## General Observations

**Positive:**
- The existing exercises provided excellent reference patterns
- Once MCP is working, the validation feedback with line/column positions sounds valuable
- The documentation index is comprehensive

**Challenges:**
- MCP server configuration appears fragile/non-persistent
- Finding specific syntax details requires trial-and-error or reading existing code
- No clear fallback when MCP validation is unavailable
