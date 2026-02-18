# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 03:47 PST - Comment Parsing Issue at Start of Files

**What I was trying to do:**
Create a XanoScript run job with commented headers explaining what the file does (standard practice in most programming languages).

**What the issue was:**
The Xano MCP validator (`validate_xanoscript`) rejects files that start with `//` comments. When I had files starting with:
```xs
// Stripe Create Subscription - Run Job Configuration
// This run job creates a Stripe subscription for a customer

run.job "Stripe Create Subscription" {
```

The validator returned:
```
[Line 3, Column 1] Expecting --> run <-- but found --> '' <---
```

This error message is confusing because:
1. Line 3 DOES contain `run.job`
2. The error says it found a single quote character `'` instead
3. There's no single quote at that position

**Why it was an issue:**
This blocked validation until I removed all comments from the start of files. The error message doesn't clearly indicate that comments at the top of files are the problem. It made me think there was an encoding issue or invisible character problem.

**Potential solution:**
1. Either support comments at the start of files (preferred - standard in most languages)
2. Or provide a clear error message like: "Comments not allowed at start of file. Move comments below the declaration."

---

## 2025-02-18 03:45 PST - File Path Parameter Parsing Issue

**What I was trying to do:**
Validate multiple files at once using the `file_paths` parameter with comma-separated paths as documented.

**What the issue was:**
When calling:
```
mcporter call xano.validate_xanoscript file_paths="/path/to/file1.xs,/path/to/file2.xs"
```

The MCP treated the comma-separated string as individual characters, resulting in 142 "file not found" errors for each character in the path string (e.g., "File not found: U", "File not found: s", "File not found: e", etc.).

**Why it was an issue:**
The `file_paths` parameter doesn't work as expected. I had to fall back to using the `directory` parameter or validating single files with `file_path`.

**Potential solution:**
Fix the array parameter parsing for `file_paths` so it correctly handles comma-separated values or document that users should use the `directory` parameter instead.

---

## 2025-02-18 03:44 PST - Limited Documentation on Stripe Integration Patterns

**What I was trying to do:**
Build a Stripe integration with proper authentication.

**What the issue was:**
The xanoscript_docs mention Stripe briefly in the external APIs section, but don't provide guidance on:
1. Stripe's form-encoded parameter format (different from JSON)
2. Stripe's Basic auth pattern (API key base64-encoded, not Bearer token)
3. How to handle array parameters like `items[0][price]` in form encoding

**Why it was an issue:**
Had to rely on general HTTP knowledge and Stripe's API docs rather than Xano-specific guidance. The examples show Bearer token auth but not Basic auth patterns.

**Potential solution:**
Add a specific Stripe integration example to the docs showing:
- Basic auth header construction
- Form-encoded POST body
- Array parameter handling for Stripe's nested object format

---

## General Feedback

### What Worked Well
1. The `directory` validation parameter worked perfectly once I discovered it
2. Error messages include line/column numbers which is helpful
3. The xanoscript_docs tool provides comprehensive syntax documentation

### Suggestions for Improvement
1. Allow comments at the top of .xs files - this is standard practice
2. Fix the `file_paths` array parameter parsing
3. Add more real-world integration examples (Stripe, SendGrid, etc.)
4. Consider supporting both `//` and `/* */` comment styles for familiarity
