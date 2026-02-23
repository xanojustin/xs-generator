# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 04:35 PST] - MCP Parameter Passing Issues

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The mcporter CLI tool had inconsistent parameter parsing. When I tried to use JSON format `{"file_path": "/path/to/file"}`, the tool kept returning:
```
Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

This error persisted even though I was clearly passing the file_path parameter in JSON format.

**Why it was an issue:** This blocked validation entirely. I had to experiment with multiple parameter formats before finding one that worked.

**Solution discovered:** Use `key=value` format instead of JSON:
```bash
# This works:
mcporter call xano validate_xanoscript file_path="/path/to/file.xs"

# These don't work:
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
mcporter call xano validate_xanoscript --file_path /path/to/file.xs
```

**Potential solution:** The MCP server or mcporter should document the expected parameter format more clearly, or ideally accept both JSON and key=value formats consistently.

---

## [2026-02-23 04:38 PST] - response Variable Placement Limitation

**What I was trying to do:** Return early from a function when handling edge cases (e.g., when numerator is 0, return "0" immediately)

**What the issue was:** XanoScript doesn't allow `response = ...` assignments inside conditional blocks within the stack. The validator error was:
```
[Line 16, Column 9] Expecting --> } <-- but found --> 'response' <--
```

**Why it was an issue:** This is a common pattern in many programming languages (early returns for edge cases). Having to restructure the entire function to use a single response at the end made the code more complex and harder to follow.

**Workaround:** Use a `$result` variable throughout the function and assign to it in conditionals, then have a single `response = $result` at the end.

**Potential solution:** Consider allowing `response` assignments inside conditionals as long as they're guaranteed to execute (exhaustive conditionals). Or document this limitation more prominently in the function documentation.

---

## [2026-02-23 04:40 PST] - Variable Shadowing/Re-declaration Confusion

**What I was trying to do:** Update the `$result` variable conditionally within different branches

**What the issue was:** The XanoScript pattern for variable updates vs re-declaration is subtle. Using `var $result { value = ... }` creates a new variable in scope, while `var.update $result { value = ... }` updates an existing one.

**Why it was an issue:** I was inconsistent in my usage - sometimes using `var` to redeclare and sometimes needing `var.update`. The documentation mentions `var.update` but it's not clear when it's required vs optional.

**Potential solution:** 
1. Clearer documentation on variable scoping rules
2. Examples showing when to use `var` vs `var.update`
3. Perhaps a linter warning when shadowing variables

---

## [2026-02-23 04:42 PST] - Limited Documentation Depth

**What I was trying to do:** Understand the correct syntax for loops, conditionals, and variable manipulation

**What the issue was:** The `xanoscript_docs` function kept returning the same high-level overview documentation regardless of which topic I requested (quickstart, functions, syntax all returned similar content).

**Why it was an issue:** I had to look at existing implementations in the `~/xs/` directory to understand the actual syntax patterns used in practice.

**Potential solution:** 
1. Ensure topic-specific documentation returns detailed content for that topic
2. Include more code examples in the documentation
3. Consider adding a "patterns" or "examples" topic with common implementation patterns

