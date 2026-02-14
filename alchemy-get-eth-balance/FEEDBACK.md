# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 13:47 PST] - MCP Validation Tool Connection Issues

**What I was trying to do:**
Validate the XanoScript files I created (run.xs, function/fetch_eth_balance.xs, table/wallet_query.xs) using the Xano MCP `validate_xanoscript` tool.

**What the issue was:**
The `mcporter call xano.validate_xanoscript` command consistently returned errors:
```
{
  "server": "xano",
  "tool": "validate_xanoscript",
  "error": "Unknown MCP server 'xano'.",
  "issue": {
    "kind": "other",
    "rawMessage": "Unknown MCP server 'xano'."
  }
}
```

This occurred even though `mcporter list` showed the xano server as healthy with 6 tools.

**Why it was an issue:**
Without validation, I couldn't confirm my XanoScript syntax was correct before committing. I had to rely on comparing my files against existing examples, which is error-prone.

**Potential solution:**
- The mcporter MCP call routing might have issues with the xano server
- Consider adding a simpler CLI entry point like `xano validate <file.xs>` 
- Better error messages when the MCP server is unreachable vs when code is invalid

---

## [2026-02-14 13:50 PST] - Direct MCP Validation Had Poor Output

**What I was trying to do:**
Work around the mcporter issue by calling the Xano MCP server directly via npx and stdio.

**What the issue was:**
When calling via `npx -y @xano/developer-mcp@latest --stdio`, the validation ran but:
1. Output was mixed with server startup messages ("Xano Developer MCP server running on stdio")
2. Had to use complex shell scripting to extract just the JSON response
3. For run.xs, got cryptic error: "Expecting --> function <-- but found --> '('"

**Why it was an issue:**
The error message was confusing because the run.xs file followed the documented syntax exactly:
```xs
run.job "Alchemy Get ETH Balance" {
  main = { ... }
  env = [...]
}
```

The validator seemed to expect only `function` constructs, not `run.job` constructs. This makes it impossible to validate run.xs files.

**Potential solution:**
- The validator should accept all XanoScript constructs (run.job, run.service, function, table, etc.)
- Clearer error messages indicating what constructs are valid
- Separate validation modes or better auto-detection

---

## [2026-02-14 13:52 PST] - Lack of Clear Validation Success Feedback

**What I was trying to do:**
Confirm that my function/fetch_eth_balance.xs file was valid.

**What the issue was:**
When I tried to validate the function file directly via npx, I got no clear output - just "(no output)" or empty results. It was unclear whether:
- The file was valid (no errors = valid?)
- The validation failed to run
- The output was being swallowed somewhere

**Why it was an issue:**
Without explicit "No errors found" or "Valid XanoScript" message, I couldn't confidently say my files were correct.

**Potential solution:**
- Always return a clear result: "Valid" or "Invalid: X errors"
- Include success/failure status in the JSON response
- Document expected output format

---

## [2026-02-14 13:55 PST] - Documentation Gaps for Run Job Development

**What I was trying to do:**
Create a complete run job with supporting files (function, table).

**What the issue was:**
The xanoscript_docs topic="run" was helpful but lacked:
1. A complete end-to-end example showing all files
2. Guidance on when to use tables vs just functions
3. Best practices for error handling in run jobs specifically
4. How to test run jobs locally before deployment

**Why it was an issue:**
Had to piece together information from multiple doc topics and existing examples in the ~/xs folder.

**Potential solution:**
- Add a "run job quickstart" with all required files
- Include a template/boilerplate section
- Add testing/debugging guidance for run jobs

---

## [2026-02-14 14:00 PST] - String Escaping Challenges in Validation

**What I was trying to do:**
Pass XanoScript code containing quotes and newlines to the validator via JSON.

**What the issue was:**
Had to use complex sed/jq escaping to get the code into the JSON payload:
```bash
CODE=$(cat file.xs | sed 's/\\/\\\\/g; s/"/\\"/g; s/\n/\\n/g')
```

**Why it was an issue:**
This is error-prone and makes it hard to validate files quickly during development.

**Potential solution:**
- Support file path input: `validate_xanoscript file_path="./run.xs"`
- Support stdin input more cleanly
- Provide a simple CLI wrapper: `xano-validate file.xs`

---

## Summary

The Xano MCP provides good documentation but the validation tooling has usability issues:
1. mcporter integration is unreliable for the xano server
2. Direct MCP calls require complex shell scripting
3. Error messages could be clearer
4. Missing support for validating run.job constructs
5. No simple file-based validation workflow

I validated my files by comparing against existing working implementations, which worked but isn't ideal.
