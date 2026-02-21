# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-20 22:05 PST - MCP Parameter Passing Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The initial attempts to call the validation tool failed with error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

I tried multiple approaches:
1. JSON object as positional arg: `mcporter call xano validate_xanoscript '{"file_path": "..."}'`
2. JSON with file_paths array: `mcporter call xano validate_xanoscript '{"file_paths": [...]}'`
3. Directory parameter: `mcporter call xano validate_xanoscript '{"directory": "..."}'`
4. Flag syntax: `mcporter call xano validate_xanoscript --file_path=...`

**Why it was an issue:** The tool was clearly receiving the call but not recognizing the parameters. This blocked validation until I found the correct syntax.

**Resolution:** Using `--args` flag worked: `mcporter call xano validate_xanoscript --args '{"file_path":"..."}'`

**Potential solution:** The mcporter skill documentation could be clearer about when to use `--args` vs positional arguments. It would also help if the error message from the tool indicated that it received the call but parameters weren't parsed correctly.

---

## 2025-02-20 22:10 PST - Successful Validation

**What I was trying to do:** Validate both the run.xs and function files

**What the issue was:** None - both files passed validation on the first attempt

**Why it was an issue:** N/A - no issues encountered

**Note:** The code was written based on studying existing examples in the ~/xs/ directory (particularly fizzbuzz and matrix-transpose). The existing patterns were clear enough to follow without needing additional documentation.

---
