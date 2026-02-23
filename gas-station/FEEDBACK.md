# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 12:00 PST - Initial Setup and Validation

**What I was trying to do:** Create a new XanoScript coding exercise (gas-station problem) following the established pattern

**What the issue was:** The MCP `validate_xanoscript` tool expects `file_paths` parameter as a JSON array string, not as a `files` object. The documentation didn't clearly specify the exact parameter format.

**Why it was an issue:** My first attempt used `{"files": [...]}` which returned an error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required". I had to try different parameter names to find the correct one.

**Potential solution:** The MCP documentation could include example calls showing the exact parameter format expected for each tool. Something like:
```
validate_xanoscript(file_paths: '["/path/to/file.xs"]')
```

---

## 2025-02-23 12:05 PST - Successful Validation

**What I was trying to do:** Validate the gas_station.xs and run.xs files

**What the issue was:** No issues encountered - both files passed validation on first attempt

**Why it was an issue:** N/A - Successful validation

**Notes:** The gas station implementation followed the same patterns from existing exercises (two-sum, etc.) which helped ensure correctness. The MCP validation tool worked correctly once the right parameter format was used.
