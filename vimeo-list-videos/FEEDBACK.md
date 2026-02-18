# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 07:16 PST] - Issue: Optional Chaining Operator Not Supported

**What I was trying to do:**
Access nested properties from Vimeo API response data safely, like `$video.privacy?.view` to get the privacy setting that might not exist.

**What the issue was:**
XanoScript doesn't support the JavaScript-style optional chaining operator (`?.`). I used `$video.privacy?.view ?? "unknown"` which caused a parse error.

**Why it was an issue:**
This is a very common pattern in modern languages for safely accessing nested object properties. Without it, the code is more verbose and harder to read.

**Potential solution (if known):**
I had to work around this by using the `get` filter twice: `($video|get:"privacy":{})|get:"view":"unknown"`. 

It would be helpful if:
1. XanoScript supported optional chaining syntax like `$video.privacy?.view`
2. OR the `get` filter supported dot notation paths like `$video|get:"privacy.view":"default"`
3. OR there was a `get_nested` filter that could traverse paths

---

## [2026-02-18 07:15 PST] - Issue: Documentation Discovery

**What I was trying to do:**
Understand XanoScript syntax for the first time to write the run job.

**What the issue was:**
The xanoscript_docs tool has many topics but it's not immediately obvious which ones are most important for a beginner. I had to call it multiple times with different topics to get the full picture.

**Why it was an issue:**
The first-time experience could be smoother with a "getting started" guide or a recommended reading order.

**Potential solution (if known):**
- Add a "start" or "getting-started" topic that provides a curated learning path
- Include topic relationships in the docs ("After reading this, see: functions, apis")

---

## [2026-02-18 07:14 PST] - Positive: Validation Tool is Excellent

**What I was trying to do:**
Validate my XanoScript code for syntax errors.

**What the experience was:**
The `validate_xanoscript` tool worked perfectly. It:
- Found the exact line and column of the error
- Provided a helpful suggestion ("Use text instead of string")
- Showed the actual code that caused the issue
- Supported directory validation for batch checking

**Why it was helpful:**
Without this tool, I would have had to deploy and test to find syntax errors. The immediate feedback loop made development much faster.

---

## [2026-02-18 07:13 PST] - Issue: Unclear Reserved Variable List

**What I was trying to do:**
Name my variables appropriately without conflicts.

**What the issue was:**
The quickstart docs mention `$response`, `$input`, `$env`, etc. are reserved, but I initially tried using `$result` as a variable name which is also reserved (used in reduce operations).

**Why it was an issue:**
Got an error about reserved variable names. The list in the docs is helpful but could be more comprehensive.

**Potential solution (if known):**
- Add `$result` to the reserved variable documentation table
- Consider adding all reserved names to a dedicated topic like `xanoscript_docs topic=reserved`

---

## [2026-02-18 07:12 PST] - Issue: api.request params vs body Naming

**What I was trying to do:**
Send a POST request with a JSON body.

**What the issue was:**
The documentation warns that `params` is used for the request body, not `body`. This is counterintuitive and different from most HTTP libraries.

**Why it was an issue:**
Had to consciously remember to use `params` instead of `body` which is the more common convention.

**Potential solution (if known):**
- Consider aliasing `body` to also work for the request body
- Or at least show a warning if someone uses `body` suggesting they might mean `params`

---

## General Notes

### What Worked Well:
1. The `xanoscript_docs` tool provides comprehensive documentation
2. The `validate_xanoscript` tool is fast and accurate
3. The run.job syntax is clean and intuitive
4. Error messages are generally helpful with line/column information

### Suggestions for Improvement:
1. Add syntax highlighting support for `.xs` files in common editors (VS Code, etc.)
2. Consider adding a `xanoscript format` command to auto-format code
3. A cookbook of common API integration patterns would be helpful
4. The MCP could benefit from a `generate_xanoscript` tool that creates boilerplate based on API specs

### Overall Experience:
Good! Once I understood the syntax patterns, writing XanoScript was straightforward. The validation tool made debugging fast. The main friction points were around JavaScript-style syntax that doesn't work (optional chaining) and naming conventions that differ from expectations (params vs body).
