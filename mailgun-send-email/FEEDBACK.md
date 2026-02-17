# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-16 16:48 PST - File Paths Parameter Format Issue

**What I was trying to do:**
Validate multiple .xs files at once using the `validate_xanoscript` tool with the `file_paths` parameter.

**What the issue was:**
The MCP tool documentation says `file_paths` accepts "Array of file paths for batch validation" and the example shows `value1,value2`. I tried:
- `file_paths=/Users/justinalbrecht/xs/mailgun-send-email/run.xs,/Users/justinalbrecht/xs/mailgun-send-email/function/send_email.xs`

This caused the validator to split the string into individual characters and treat each character as a separate file path, resulting in errors like:
```
File not found: U
File not found: s
File not found: e
...
```

**Why it was an issue:**
The comma-separated string format doesn't work as expected. The tool appears to be splitting the string character-by-character rather than by comma-delimited values.

**Potential solution (if known):**
The MCP should either:
1. Properly parse comma-separated values in the string
2. Accept a proper JSON array format for the file_paths parameter
3. Document the correct format more clearly if it requires something different

Workaround is to validate files one at a time using `file_path` instead of `file_paths`.

---

## 2026-02-16 16:50 PST - Reserved Variable Name Error

**What I was trying to do:**
Create a response variable in my function to return data to the caller.

**What the issue was:**
I used `var $response { ... }` inside my function, which is a reserved variable name. The validator correctly caught this:
```
1. [Line 69, Column 13] '$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
While the validator caught it (which is good!), it's easy to forget that `$response` is reserved. The error message was very helpful and suggested using `$my_response` instead.

**Potential solution (if known):**
The documentation mentions reserved variables in the quickstart, but it might be worth adding a lint warning or more prominent reminder in function examples since `$response` is a natural name developers might reach for.

---

## 2026-02-16 16:45 PST - Directory Path Resolution with ~

**What I was trying to do:**
Validate all .xs files in a directory using the `directory` parameter with a tilde path: `directory=~/xs/mailgun-send-email`

**What the issue was:**
The tool reported "No .xs files found in directory: ~/xs/mailgun-send-email" even though files existed. The tilde expansion wasn't working.

**Why it was an issue:**
Users naturally use `~` for home directory in shell commands. The MCP doesn't expand this, requiring absolute paths.

**Potential solution (if known):**
The MCP should expand `~` to the user's home directory, or at least document that absolute paths are required.

---

## 2026-02-16 16:46 PST - Documentation Gap on api.request Body Parameter

**What I was trying to do:**
Send a POST request with a request body to the Mailgun API.

**What the issue was:**
Initially I thought the parameter would be called `body` (like most HTTP libraries), but after checking the docs I found it uses `params` for the request body, which is counterintuitive.

**Why it was an issue:**
The naming is unexpected - `params` usually means query parameters, not request body. The documentation does call this out with a warning which is helpful:
> "Important: The params parameter is used for the request body (POST/PUT/PATCH), not query parameters."

**Potential solution (if known):**
Consider aliasing `body` to `params` for better developer experience, or at minimum keep the prominent warning in docs.

---

## Summary

Overall the MCP worked well once I understood the quirks:
- ✅ The `xanoscript_docs` tool is excellent - comprehensive documentation
- ✅ The validator gives helpful error messages with line/column numbers
- ✅ Validation catches reserved variable names and type errors
- ⚠️ File path handling could be more robust (tilde expansion, array parsing)
- ⚠️ Some parameter names are counterintuitive but documented

The documentation is very thorough and helped me write correct XanoScript despite never having used it before.
