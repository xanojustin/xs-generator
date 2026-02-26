# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 16:05 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Validate a XanoScript function that checks if an input array is empty using the `|count` filter combined with a comparison.

**What the issue was:** The validator rejected this code:
```xs
if ($input.nums|count == 0) {
```

With the error:
```
[Line 9, Column 32] An expression should be wrapped in parentheses when combining filters and tests
```

**Why it was an issue:** The documentation mentions that filters need parentheses when combined with other operations, but this specific case (using `|count` in a comparison) wasn't immediately obvious. The error message was helpful, but I had to think about whether to wrap just the filter `($input.nums|count)` or the entire comparison `($input.nums|count == 0)`.

**Potential solution (if known):** 
1. The documentation in `quickstart` could include a specific example for this common pattern of checking array length
2. The error message could show the suggested fix explicitly, e.g.: "Try: `($input.nums|count) == 0`"

---

## [2026-02-25 16:00 PST] - Validation Tool Path Handling

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:** The validation tool requires absolute paths. When I tried using relative paths like `run.xs` or `function/degree_of_array.xs` from within the directory, it returned "File not found" errors.

**Why it was an issue:** This wasn't documented in the tool description I could see. I had to guess that absolute paths were required.

**Potential solution (if known):** 
1. The MCP tool could support relative paths from the current working directory
2. Or document clearly that absolute paths are required
3. Add a `cwd` parameter to allow specifying a working directory

---

## [2026-02-25 16:00 PST] - Object Key Handling for Non-String Types

**What I was trying to do:** Use integers as keys in hash maps to track element frequencies and positions in an array.

**What the issue was:** XanoScript object keys must be strings, so I had to convert integers to text using `|to_text` for each hash map operation:
```xs
value = $frequency|get:($num|to_text):0
value = $frequency|set:($num|to_text):$current_freq
```

**Why it was an issue:** This adds verbosity and potential performance overhead. It's also not immediately clear from the documentation that object keys are always strings.

**Potential solution (if known):** 
1. Document this limitation clearly in the `types` or `syntax` documentation
2. Consider allowing automatic coercion of integer keys to strings in the XanoScript interpreter
3. Or provide a dedicated map/dictionary type that supports non-string keys

