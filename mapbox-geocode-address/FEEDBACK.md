# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-17 09:18 PST - Filter Expression Parentheses Issue

**What I was trying to do:**
Create a run job that extracts data from an API response and builds an object with that data. Specifically, I was trying to extract the first element from an array using `|first` and provide a default value using `?? ""`.

**What the issue was:**
When writing this line:
```xs
place_type: $first_result.place_type|first ?? ""
```

The validator threw an error:
```
[Line 66, Column 9] An expression should be wrapped in parentheses when combining filters and tests
```

**Why it was an issue:**
This was confusing because the error message wasn't clear about what "filters and tests" meant. I had to look at the documentation to understand that when combining a filter (like `|first`) with the null coalescing operator (`??`), the filter expression needs to be wrapped in parentheses.

The fix was to break it into a separate variable:
```xs
var $place_type_first { value = ($first_result.place_type|first) ?? "" }
```

**Potential solution (if known):**
- The error message could be more specific: "Wrap the filter expression in parentheses: `($first_result.place_type|first) ?? ""`"
- Or the syntax could allow unwrapped filters in object literal values
- Documentation could have a clearer example of this specific pattern

---

## 2026-02-17 09:15 PST - Finding the Validate Tool

**What I was trying to do:**
Validate my XanoScript files before committing them.

**What the issue was:**
I knew I needed to validate the files, but I wasn't sure which MCP tool to use. The task instructions mentioned `validate_xanoscript` but I had to discover the exact MCP tool name by listing available tools.

**Why it was an issue:**
Minor friction - I had to run `mcporter list xano` to discover the available tools and find `validate_xanoscript`.

**Potential solution (if known):**
The task template could include the exact command to run validation, or the validate tool could be more prominently documented in the Xano MCP server.

---

## 2026-02-17 09:15 PST - General Learning Curve

**What I was trying to do:**
Write my first XanoScript run job from scratch.

**What the issue was:**
The documentation is comprehensive but finding the right topic required some trial and error. I needed to call multiple `xanoscript_docs` topics:
- `run` - for run.job structure
- `quickstart` - for common patterns
- `integrations/external-apis` - for api.request syntax
- `syntax` - for filter reference

**Why it was an issue:**
It took several minutes to gather all the necessary documentation. The structure wasn't immediately obvious - for example, understanding that `run.xs` is separate from `function/*.xs` files.

**Potential solution (if known):**
- A "run job quickstart" guide that shows the complete structure in one place
- A single-page reference for common integration patterns
- Example run jobs in the docs could be more discoverable

---

## Summary

Overall, the Xano MCP worked well once I understood the patterns. The validation tool is essential and caught a real syntax issue. The main friction points were:

1. **Filter + operator combinations need clearer documentation** - The parentheses requirement isn't obvious
2. **Documentation discovery** - Had to query multiple topics to get the full picture
3. **Error message specificity** - Could suggest the exact fix

The documentation quality is high - it was comprehensive and accurate. Just needed to know which topics to query.
