# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 06:33 PST] - Filter compatibility with array types

**What I was trying to do:** Add validation to ensure the input array has at least one element

**What the issue was:** I tried to use `filters=min_count:1` on an `int[]` type input, but got the error:
```
[Line 4, Column 24] Filter 'min_count' cannot be applied to input of type 'int'
```

**Why it was an issue:** I assumed common validation filters like `min_count` would work on arrays, similar to how `min:1` works on integers. The error message was slightly confusing because it said "int" rather than "int[]" — it took a moment to realize the filter simply doesn't apply to array types.

**Potential solution:** Documentation could clarify which filters work with which types, or the error message could suggest alternative approaches (like using a precondition to check array length, which is what I ended up doing).

---

## [2026-03-02 06:35 PST] - Array element access syntax uncertainty

**What I was trying to do:** Access array elements by index within the sliding window algorithm

**What the issue was:** I used `$input.nums[$i]` and `$input.nums[$start_index]` syntax for array access, but I wasn't 100% sure if this was the correct XanoScript syntax since the documentation examples mostly show iteration with `foreach` rather than index-based access.

**Why it was an issue:** The documentation doesn't clearly show if bracket notation `array[index]` is the preferred way to access array elements by index. I inferred it from common programming language patterns, but explicit confirmation in the docs would help.

**Potential solution:** The documentation could include a section on "Array Operations" showing both iteration patterns and direct index access patterns, including any bounds checking behavior.

---

## [2026-03-02 06:30 PST] - Positive experience: Good error suggestions

**What I was trying to do:** Validate the XanoScript code

**What worked well:** The validation tool provided helpful suggestions alongside errors:
- "Use 'type[]' instead of 'array'"
- "Use 'int' instead of 'integer' for type declaration"

These contextual hints are valuable because they address common mistakes developers might make coming from other languages.

**Why it helped:** Even though the main error wasn't directly about type names, having these reminders in the error output prevents follow-on errors and helps solidify XanoScript conventions.

---

## General Observations

### What Worked Well
1. The MCP setup was straightforward — already configured and working
2. The quick reference documentation was well-organized and easy to scan
3. Error messages included line/column positions which made fixes fast
4. The validation tool correctly identified the exact issue

### Suggested Documentation Improvements
1. **Filter compatibility matrix:** A table showing which filters work with which types would prevent trial-and-error
2. **Array access patterns:** More examples of index-based array operations
3. **Math operations:** Clarification on how division works (int/int vs int/decimal) and whether explicit casting is needed

### MCP Tool Feedback
- The `xanoscript_docs` tool is helpful but could benefit from search functionality or more granular topics
- Having a topic specifically for "common filters by type" would be useful
