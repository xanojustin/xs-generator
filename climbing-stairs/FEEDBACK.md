# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 06:03 PST] - Inline Comments Not Allowed

**What I was trying to do:** Add explanatory comments to variable declarations in the climbing stairs function to document what each variable represents (e.g., `$prev2` tracks ways to climb 0 steps, `$prev1` tracks ways to climb 1 step).

**What the issue was:** I wrote code like:
```xs
var $prev2 { value = 1 }  // ways to climb 0 steps
var $prev1 { value = 1 }  // ways to climb 1 step
```

The validator returned this error:
```
[Line 16, Column 31] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** The error message is cryptic and doesn't clearly indicate that inline comments are not supported. The phrase "expecting at least one iteration" is confusing and doesn't mention "comments" at all. I had to guess that the `//` on the same line as code was the problem.

**Potential solution:** 
1. Improve the error message to explicitly say something like "Inline comments are not supported. Comments must be on their own line."
2. Or update the documentation in `quickstart` or `syntax` to explicitly state that `//` comments must be on separate lines, not inline with code.

---

## [2025-02-20 06:00 PST] - Validate Tool Parameter Naming

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter to validate my .xs files.

**What the issue was:** The first attempt used `files` as the parameter name:
```bash
mcporter call xano.validate_xanoscript files='[...]'
```

This failed with: `One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

The correct parameter name is `file_paths` (with underscore and plural), not `files`.

**Why it was an issue:** The error message lists `file_paths` as an option, but the natural tendency is to use `files` (which is more common in many APIs). The error message doesn't suggest the correct parameter name when you get close.

**Potential solution:** 
1. Add `files` as an alias for `file_paths` to be more forgiving
2. Or improve the error to say something like "Did you mean 'file_paths'?"

---
