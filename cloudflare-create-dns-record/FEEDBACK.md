# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 16:17 PST] - MCP Documentation Access Pattern

**What I was trying to do:**
Access XanoScript documentation to understand syntax before writing code.

**What the issue was:**
The task prompt said to call `xanoscript_docs` on the xano MCP, but there was no explicit instruction on HOW to access the MCP. I had to:
1. First try running `npx -y @xano/developer-mcp xanoscript_docs` which hung
2. Check if mcporter was configured (it was)
3. Discover that the server was already running via mcporter daemon
4. Figure out the correct command: `mcporter call xano.xanoscript_docs`

**Why it was an issue:**
The task said I MUST call the MCP but didn't specify the mechanism. I had to deduce the correct path through trial and error.

**Potential solution (if known):**
Include in task prompts: "Use `mcporter call xano.<tool_name>` to interact with the Xano MCP."

---

## [2026-02-16 16:20 PST] - Environment Variable Constraint Clarification

**What I was trying to do:**
Understand how to access environment variables in a run.job input block.

**What the issue was:**
The documentation clearly states that `$env` variables cannot be used in `run.job` or `run.service` input blocks. This was surprising because it seems like a natural place to use defaults. I had to read carefully to understand this limitation.

**Why it was an issue:**
Initially I wanted to set defaults like `zone_id: $env.CLOUDFLARE_ZONE_ID` but that's invalid. I had to pass them as actual inputs instead.

**Potential solution (if known):**
The documentation is clear, but a brief comment in examples showing "can't use $env here" would help.

---

## [2026-02-16 16:22 PST] - String Concatenation Syntax

**What I was trying to do:**
Build dynamic URLs and error messages using string concatenation.

**What the issue was:**
I had to carefully check the documentation for the correct concatenation operator. XanoScript uses `~` (tilde) for string concatenation, which is different from many languages.

**Why it was an issue:**
If I hadn't read the syntax docs, I might have tried `+` or `.` like in other languages.

**Potential solution (if known):**
The quick reference in the docs is helpful. Maybe include a "Common gotchas" section for developers coming from JavaScript/Python.

---

## [2026-02-16 16:25 PST] - api.request params Parameter Naming

**What I was trying to do:**
Make a POST request with a JSON body.

**What the issue was:**
The `api.request` operation uses `params` for the request body, which is counterintuitive. Most developers would expect `body` or `payload`. I only discovered this from reading the documentation example.

**Why it was an issue:**
The naming is confusing - `params` typically means query parameters in HTTP terminology.

**Potential solution (if known):**
Consider aliasing `body` as an alternative to `params`, or at minimum add a prominent note in the docs.

---

## [2026-02-16 16:26 PST] - Validation Success

**What I was trying to do:**
Validate my XanoScript files.

**What went well:**
The `validate_xanoscript` tool worked perfectly with the directory parameter. It found all .xs files and validated them in one call. Clear output showing which files passed.

**No issues here - this worked great!**

---

## Summary

Overall, the MCP worked well once I understood the access pattern. The documentation is comprehensive but has some naming conventions that differ from typical expectations. The validation tool is excellent and saved a lot of debugging time.
