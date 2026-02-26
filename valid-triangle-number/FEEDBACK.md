# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-26 12:33 PST - Input Block Description Syntax Unclear

**What I was trying to do:** Add a description to the input parameter `sides` in my function

**What the issue was:** I initially wrote the description as a separate line after the field declaration:
```xs
input {
  int[] sides filters=nonempty
  description = "Array of integers representing potential triangle side lengths"
}
```

This resulted in the error: `Expecting --> } <-- but found --> 'description' <--`

**Why it was an issue:** The documentation in `xanoscript_docs(topic='functions')` shows the basic structure but doesn't clearly show where the description goes in the input block. The quickstart shows `description = "..."` inside braces, but I didn't realize it needed to be attached directly to the field declaration.

**Potential solution (if known):** 
- The functions documentation could show a complete example with input descriptions
- Could include something like: `int[] sides { description = "..." }` in the quick reference

---

## 2025-02-26 12:33 PST - Filter 'nonempty' Not Valid for int[]

**What I was trying to do:** Ensure the input array is not empty by using the `nonempty` filter

**What the issue was:** I wrote `int[] sides filters=nonempty` and got: `Filter 'nonempty' cannot be applied to input of type 'int'`

**Why it was an issue:** I assumed filters could be applied to any type including arrays. The error message was a bit confusing because it said "input of type 'int'" when I was working with `int[]`. Also, there's no clear list in the quickstart of which filters work with which types.

**Potential solution (if known):**
- The error message could clarify it's about the array element type, not the array itself
- A reference table of filters by applicable type would be helpful
- For arrays, perhaps a `min_count` or similar validation would be useful

---

## 2025-02-26 12:35 PST - Positive Feedback - Validation Tool Works Well

**What went well:**
- The `validate_xanoscript` tool provided clear line/column positions for errors
- The suggestions were helpful (though the "use int instead of integer" suggestion was not applicable since I was already using int)
- The tool successfully validated both files after fixes
- The mcporter CLI integration is smooth

**Suggestions for improvement:**
- Could validate multiple files in one call (file_paths parameter exists but had shell escaping issues)
- Would be nice to have a `--fix` mode that auto-fixes simple issues like description placement

---
