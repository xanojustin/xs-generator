# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-25 03:33 PST - Issue 1: Using response inside conditional blocks

**What I was trying to do:** Handle the integer overflow edge case (MIN_INT / -1 = MAX_INT) by returning early from a conditional block.

**What the issue was:** I tried to use `response = 2147483647` inside an `if` block, but the validator reported: "Expecting --> } <-- but found --> 'response'"

**Why it was an issue:** XanoScript doesn't allow setting `response` inside conditional blocks. The response must be set once at the end of the function. This was confusing because many programming languages allow early returns.

**Potential solution (if known):** Document this restriction clearly. The `response` assignment can only appear:
1. At the end of the function's `stack` block
2. Or as the function's `response = $var` field outside the stack

I had to restructure my code to use a variable that gets set conditionally, then use that variable in the final response.

---

## 2025-02-25 03:35 PST - Issue 2: Inline comments cause parse errors

**What I was trying to do:** Add a comment after a variable declaration to explain the MAX_INT value.

**What the issue was:** The code `var $final_result { value = 2147483647 }  // MAX_INT` caused a parse error: "expecting at least one iteration which starts with one of these possible Token sequences... but found: '/'"

**Why it was an issue:** Comments must be on their own lines in XanoScript. The documentation says "XanoScript only supports `//` for comments" but doesn't specify that they can't be inline with code.

**Potential solution (if known):** Either:
1. Update the documentation to explicitly state that `//` comments must be on their own lines and cannot follow code on the same line
2. Or fix the parser to allow inline comments (preferred, as this is common in other languages)

---

## 2025-02-25 03:35 PST - Issue 3: $result appears to be a reserved variable name

**What I was trying to do:** Use `$result` as a variable name to store the final computation result.

**What the issue was:** The validator suggested: "`$result` is a reserved variable name. Try a different name like `$my_result`"

**Why it was an issue:** The reserved variables list in the documentation includes: `$response`, `$output`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result`, `$index`. However, I didn't see `$result` in the initial list when I scanned it.

**Potential solution (if known):** The documentation is actually correct - `$result` is listed. I just missed it. No action needed, but perhaps make the reserved variables list more prominent or alphabetically sorted for easier scanning.

---

## 2025-02-25 03:40 PST - Issue 4: MCP validate_xanoscript tool JSON parameter parsing

**What I was trying to do:** Call the validate_xanoscript tool with the directory parameter using JSON format.

**What the issue was:** I tried several formats:
- `mcporter call xano validate_xanoscript '{"directory": "/path"}'` - Error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"
- `mcporter call xano validate_xanoscript --directory /path` - Parsed `--directory` as code, giving syntax error
- `mcporter call xano validate_xanoscript file_path=/path` - This worked

**Why it was an issue:** The JSON parameter format didn't work as expected. The tool seems to expect key=value format rather than JSON.

**Potential solution (if known):** Update the MCP tool documentation to show the correct parameter format. The examples show JSON format but the actual tool seems to use key=value format.

---

## 2025-02-25 03:42 PST - Issue 5: xanoscript_docs topic parameter returns same content

**What I was trying to do:** Get specific documentation about functions and run jobs by calling `xanoscript_docs` with different topics like "functions", "run", and "quickstart".

**What the issue was:** All three calls returned the same index/overview content instead of the specific topic content.

**Why it was an issue:** I couldn't get the detailed syntax information I needed for functions and run jobs. I had to rely on existing examples in the repository instead.

**Potential solution (if known):** Fix the topic routing in the MCP tool so that specific topics return their detailed content instead of the index.

---

## General Observations

1. **Good:** The validation tool provides helpful suggestions and line/column error positions
2. **Good:** The reserved variable check caught my `$result` usage before runtime
3. **Improvement:** More examples of run.job syntax would be helpful - the documentation covers functions well but run jobs are less documented
