# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 14:35 PST] - Run job syntax confusion

**What I was trying to do:** Create a run.job that contains test logic to call my function multiple times with different inputs.

**What the issue was:** I incorrectly structured the run.job with a `description` and `stack` block, similar to how functions are structured. The validation failed with errors like "The argument 'description' is not valid in this context" and "The argument 'stack' is not valid in this context."

**Why it was an issue:** The quick reference documentation for run jobs only showed:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

But didn't clearly explain that run.job is just a configuration entry point and cannot contain logic directly. I had to read the full documentation to understand that:
1. run.job can ONLY have `main` and `env` properties
2. All logic must be in separate functions
3. There's no `description`, `stack`, `input`, or `return` blocks in run.job

**Potential solution (if known):** 
- The quick reference could include a clearer note: "run.job is a configuration-only construct - all logic must be in functions"
- An example showing "WRONG: putting logic in run.job" vs "RIGHT: delegating to a function" would help

---

## [2026-02-26 14:37 PST] - Documentation lookup efficiency

**What I was trying to do:** Get the correct syntax for run jobs after my initial attempt failed validation.

**What the issue was:** I had to call `xanoscript_docs` with `mode='full'` to get the complete information about run jobs. The `mode='quick_reference'` gave me the basic structure but not the critical constraint that run.job cannot have a stack block.

**Why it was an issue:** It took two documentation lookups (first quick_reference, then full) to get the information I needed. The quick reference made it seem like I understood run jobs, but I was missing crucial constraints.

**Potential solution (if known):**
- The quick_reference for run could include a "Constraints" or "Important Notes" section with key restrictions
- Something like: "⚠️ run.job can only contain `main` and `env` - no stack, description, or other function blocks allowed"

---

## [2026-02-26 14:40 PST] - Overall MCP experience

**What went well:**
- The `validate_xanoscript` tool is fast and provides helpful error messages with line/column positions
- The full documentation is comprehensive once you find the right section
- Having the docs available via MCP is much better than guessing syntax

**What could be improved:**
- The distinction between "quick_reference" and "full" mode wasn't immediately obvious - I started with quick_reference assuming it had everything I needed
- The error message suggestion "Use decimal instead of number" was confusing when my issue wasn't about type names
- It would be helpful if the validation error could suggest looking at specific documentation topics

**General feedback:**
The MCP is working well overall. The main friction point is understanding the architectural patterns (run.job as config-only, functions for logic) which could be more prominent in the quick reference docs.
