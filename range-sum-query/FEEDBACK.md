# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 09:35 PST] - Run Job Cannot Contain Function Definitions

**What I was trying to do:** Create a run job that calls a helper function to run multiple test cases, with both the run.job and the helper function in the same file.

**What the issue was:** I initially tried to put both the `run.job` and a `function` definition in the same `run.xs` file:

```xs
run.job "Range Sum Query Tests" {
  main = {
    name: "run_tests"
  }
}

function "run_tests" {
  // ... test logic
}
```

This resulted in the validation error:
```
[Line 7, Column 1] Redundant input, expecting EOF but found: function
```

**Why it was an issue:** The error message was clear, but I initially misunderstood the architecture. I thought the run.xs file could contain supporting functions like other XanoScript files. It wasn't immediately obvious that functions must be in separate files under the `function/` directory.

**Potential solution (if known):** 
- Documentation could explicitly state that `run.xs` can ONLY contain `run.job` or `run.service` definitions
- A more descriptive error message like "Functions must be defined in separate files within the function/ directory" would help
- The run.xs documentation shows examples with separate function files, but doesn't explicitly prohibit functions in run.xs

---

## [2026-03-03 09:32 PST] - File Path Expansion Issue

**What I was trying to do:** Validate files using the `directory` parameter with a tilde path (`~/xs/range-sum-query`).

**What the issue was:** The MCP returned "No .xs files found in directory: ~/xs/range-sum-query" because the tilde wasn't expanded to the full home directory path.

**Why it was an issue:** Had to use the absolute path `/Users/justinalbrecht/xs/range-sum-query` instead. This is minor but could trip up users who expect standard shell tilde expansion.

**Potential solution (if known):** The MCP could handle tilde expansion for better UX, or the documentation could note that absolute paths are required.

---

## [2026-03-03 09:30 PST] - MCP Discovery Was Smooth

**What I was trying to do:** Find and use the Xano MCP server to get XanoScript documentation.

**What the issue was:** None - the `mcporter list` command found the xano server immediately, and `xanoscript_docs` worked perfectly.

**Why it was an issue:** N/A - this was a positive experience.

**Potential solution (if known):** The MCP setup was already configured, so this worked seamlessly. Good developer experience here.

---
