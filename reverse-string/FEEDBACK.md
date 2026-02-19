# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 09:45 PST] - Early Return Syntax Confusion

**What I was trying to do:** Implement an early return in a function when the input is null or empty.

**What the issue was:** I initially wrote `response = ""` inside a conditional block, which caused a validation error:
```
[Line 14, Column 9] Expecting --> } <-- but found --> 'response' <--
```

Then I tried `return ""` (similar to other languages), which also failed:
```
[Line 14, Column 16] Expecting: one of these possible Token sequences... but found: '""'
```

**Why it was an issue:** The XanoScript syntax for early return is `return { value = ... }`, which is different from most programming languages where you can simply `return value`. This wasn't immediately obvious from the initial error message.

**Potential solution:** 
- Add clearer error messages for return statements suggesting the correct syntax
- Include a code example or quick reference in the validation error output

---

## [2025-02-19 09:42 PST] - MCP Tool Response Parsing

**What I was trying to do:** Call the `validate_xanoscript` MCP tool and parse its response.

**What the issue was:** Initially, I was looking for `json.result` directly, but the actual validation result is nested in `json.result.content[0].text`. The initialize response and the tool call response have different structures, and I was accidentally capturing the initialize response instead of the validation result.

**Why it was an issue:** This caused confusion because I thought the validation wasn't returning any results, when in fact I was just looking at the wrong part of the response.

**Potential solution:**
- Document the MCP response structure more clearly
- Consider having the validation tool return a more structured response (e.g., `{ valid: true/false, errors: [...] }` instead of a text message)

---

## [2025-02-19 09:40 PST] - Filter Chaining Syntax

**What I was trying to do:** Chain multiple filters together to reverse a string: `$input.str|split:""|reverse|join:""`

**What the issue was:** The documentation clearly states that `reverse` is an array filter, not a string filter, and to reverse a string you need to: split → reverse → join. However, this isn't a common pattern in most languages where strings are reversible directly.

**Why it was an issue:** I had to look up the correct filter chain in the documentation. While the docs are clear about this, it's an extra step that could be avoided with a dedicated `str_reverse` filter.

**Potential solution:**
- Consider adding a `str_reverse` filter for convenience
- Or add a note in the string filters section about the split-reverse-join pattern for string reversal
