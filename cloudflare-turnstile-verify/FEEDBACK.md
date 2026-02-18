# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-18 01:17 PST - Reserved Variable Names Not Immediately Obvious

**What I was trying to do:**
Create a XanoScript function that returns a response object containing verification results.

**What the issue was:**
I used `var $response` as a variable name inside my function, which is a reserved variable in XanoScript. The validation failed with:
```
'$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
While the cheatsheet documentation does mention reserved variables (`$response`, `$output`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result`), I didn't check the list before writing code. The error was easy to fix once the validator caught it, but it caused a validation failure that required a correction cycle.

**Potential solution (if known):**
The MCP documentation could include a more prominent warning about reserved variables at the top of function-related docs. Or the `xanoscript_docs` tool could have a dedicated topic for reserved keywords/variables.

---

## 2026-02-18 01:18 PST - Tilde (~) Path Expansion Not Working in MCP

**What I was trying to do:**
Validate files using the directory parameter with `~/xs/cloudflare-turnstile-verify`.

**What the issue was:**
The MCP returned "No .xs files found in directory: ~/xs/cloudflare-turnstile-verify" when using the tilde path. I had to use the absolute path `/Users/justinalbrecht/xs/cloudflare-turnstile-verify` instead.

**Why it was an issue:**
Most CLI tools handle tilde expansion for home directories. The MCP doesn't seem to expand `~`, which is unexpected behavior for a CLI-oriented tool. It took an extra attempt to realize this was the problem.

**Potential solution (if known):**
The MCP could expand `~` to the user's home directory before processing paths, or document that absolute paths are required.

---

## 2026-02-18 01:15 PST - Variable Re-declaration Allowed Within Conditional Blocks

**What I was trying to do:**
Conditionally modify the API request payload based on whether `remoteip` was provided.

**What the issue was:**
I wrote code that re-declares `$verify_payload` inside a conditional block:
```xs
var $verify_payload { value = { ... } }
conditional {
  if ($input.remoteip != "") {
    var $verify_payload { value = { ... } }
  }
}
```

This pattern worked (no validation error), but I'm unclear if this is the idiomatic way to conditionally set values in XanoScript.

**Why it was an issue:**
The documentation doesn't clearly explain how to conditionally modify objects or variables. The conditional block approach feels verbose compared to languages with ternary operators or conditional assignment.

**Potential solution (if known):**
Add documentation on best practices for conditional value assignment. Is there a filter or operator like `|default` or `??` that works for conditional object property addition?

---

## 2026-02-18 01:20 PST - Bracket Notation for Hyphenated Keys Unclear

**What I was trying to do:**
Access Cloudflare's `error-codes` field from the API response (which contains a hyphen).

**What the issue was:**
I wasn't sure if `$verification["error-codes"]` was valid XanoScript syntax since the documentation doesn't show examples of bracket notation for field access.

**Why it was an issue:**
APIs frequently return keys with hyphens, spaces, or other characters that can't be accessed with dot notation. Without clear documentation, I had to guess that `$verification["error-codes"]` would work.

**Potential solution (if known):**
Add examples of bracket notation access in the syntax or cheatsheet documentation, specifically for hyphenated or special-character keys.

---

## 2026-02-18 01:10 PST - JSON Response Structure Documentation

**What I was trying to do:**
Understand how to access data from an API response.

**What the issue was:**
The documentation clearly states that `$api_result.response.result` contains the parsed response body, which is good. However, I initially expected `params` to mean query parameters (as in most HTTP libraries), not the request body.

**Why it was an issue:**
The documentation does warn about this ("The `params` parameter is for the **request body** (not query params)"), but the naming is counterintuitive and requires reading the docs carefully.

**Potential solution (if known):**
Consider if the MCP validation could warn when GET requests have `params` set (since GET requests shouldn't have bodies), or add a linting suggestion. Alternatively, document why `params` was chosen instead of `body`.

---
