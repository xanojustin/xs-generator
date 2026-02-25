# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 09:35 PST] - Successful First-Pass Validation

**What I was trying to do:** Create a XanoScript coding exercise for "Replace Elements with Greatest Element on Right Side"

**What the issue was:** No issues encountered! Both the run.xs and function/replace_elements.xs files validated successfully on the first attempt.

**Why it was an issue:** N/A - This was a success case

**Positive feedback:** The documentation from `xanoscript_docs` was clear and helpful. The quick_reference mode provided concise, actionable syntax examples that made it easy to write correct code.

---

## [2026-02-25 09:35 PST] - MCParameter Format Learning

**What I was trying to do:** Call the validate_xanoscript tool via mcporter

**What the issue was:** Initially had trouble with the parameter format. The first attempt used `file_paths:='[...]'` syntax which failed with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The mcporter CLI expects `--args '{"file_paths": [...]}'` JSON format for complex parameters, not the inline `key:value` syntax

**Potential solution (if known):** The help documentation for mcporter could include more explicit examples of passing array/object parameters using the --args flag

---

## General Observations

### What Worked Well
1. The quick_reference documentation mode was perfect for getting syntax without overwhelming context
2. Having existing examples (fizzbuzz) in the repo was extremely helpful for understanding the expected structure
3. The validation tool gave clear, immediate feedback

### Suggestions for Improvement
1. Consider adding a "run" topic to xanoscript_docs that shows the full run.job syntax with all available fields
2. The run.job documentation was minimal - had to infer structure from examples
3. Would be helpful to have a documented list of all reserved variable names beyond what's in quickstart

