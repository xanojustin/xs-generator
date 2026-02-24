# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 17:05 PST] - Early return pattern not supported

**What I was trying to do:** Implement a guard clause to handle the empty array edge case at the beginning of the function.

**What the issue was:** I wrote:
```xs
if ($n == 0) {
  response = $result
}
```

This caused the error: `Expecting --> } <-- but found --> 'if'`

**Why it was an issue:** XanoScript doesn't support bare `if` statements at the stack level, nor does it support early returns from functions. The `response` can only be set at the end of the function block, not inside the stack.

**Potential solution (if known):** The documentation mentions `conditional` for if/else logic, but doesn't clearly explain that early returns aren't supported. It would be helpful to have:
1. A note in the documentation about the fact that `response` can only be set once at the end
2. A pattern guide for handling edge cases without early returns
3. Clearer error messaging - the error said "Expecting } but found 'if'" which doesn't clearly indicate that bare if statements aren't allowed

---

## [2026-02-23 17:08 PST] - Filter expression parentheses requirement unclear

**What I was trying to do:** Concatenate two filtered values into a string.

**What the issue was:** I wrote:
```xs
var $range_str { value = $start|to_text ~ "->" ~ $end|to_text }
```

This caused the error: `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:** The error message was helpful (suggested parentheses), but I had to guess whether to wrap the entire expression or just the filtered parts. Wrapping just the filtered parts worked:
```xs
var $range_str { value = ($start|to_text) ~ "->" ~ ($end|to_text) }
```

**Potential solution (if known):** The documentation on filters could include an example of using filters in string concatenation expressions. A clear example like:
```xs
// Correct
var $result { value = ($var|to_text) ~ " suffix" }

// Incorrect
var $result { value = $var|to_text ~ " suffix" }
```

---

## [2026-02-23 17:00 PST] - MCP parameter format inconsistency

**What I was trying to do:** Call the `validate_xanoscript` tool with JSON parameters.

**What the issue was:** Initially tried passing JSON like `'{"file_path": "/path"}'` but that didn't work. Had to use the `key=value` format instead: `file_path=/path`.

**Why it was an issue:** The tool description shows JSON examples but mcporter actually uses key=value format. This was confusing.

**Potential solution (if known):** Update the tool description to show the mcporter-specific format (key=value) instead of or in addition to the JSON examples. Or make mcporter accept both formats.
