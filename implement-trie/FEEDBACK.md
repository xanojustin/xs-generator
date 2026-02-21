# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 00:08 PST] - Issue 1: Incorrect type syntax (object[] vs json[])

**What I was trying to do:** Define the input type for an array of objects in the function input block

**What the issue was:** I used `object[] inputs` but XanoScript expects `json[] inputs`

**Why it was an issue:** The validation error was:
```
[Line 5, Column 20] Expecting --> { <-- but found --> '
' <--
💡 Suggestion: Use "json" instead of "object"
```

The error message pointed to the newline after the type declaration, which was confusing. The actual issue was that `object` is not a valid type - it should be `json`. The error location (column 20) was at the end of `object[]` where the parser expected a `{` for an inline schema definition, not a newline.

**Potential solution:** The error message could be improved to directly say "Unknown type 'object'. Did you mean 'json'?" instead of the cryptic "Expecting { but found newline" message.

---

## [2026-02-21 00:10 PST] - Issue 2: While loop syntax requires 'each' block

**What I was trying to do:** Write a standard while loop to iterate through characters in a string

**What the issue was:** I wrote:
```xs
while ($i < ($input.operations|count)) {
  // loop body
}
```

But XanoScript requires an `each` block inside the while loop:
```xs
while ($i < ($input.operations|count)) {
  each {
    // loop body
  }
}
```

**Why it was an issue:** The validation error was:
```
[Line 28, Column 45] Expecting --> each <-- but found --> '
' <--
```

This was confusing because I thought `each` was only used for `foreach` loops. The documentation shows while loops with `each` but it's easy to miss since most languages don't require this.

**Potential solution:** 
1. Make `each` optional for while loops (most intuitive)
2. OR provide a clearer error message like: "While loops require an 'each' block. Did you mean: while (condition) { each { ... } }?"

---

## [2026-02-21 00:12 PST] - Issue 3: Filter precedence with parentheses

**What I was trying to do:** Compare the result of a filter operation with a value

**What the issue was:** I initially wrote expressions like `$arr|count == 0` without parentheses

**Why it was an issue:** This isn't actually a validation error - the code validates fine. But I noticed in the documentation that filters bind greedily and can cause unexpected results at runtime. I had to carefully wrap filter expressions in parentheses.

Example I used:
```xs
while ($i < ($input.operations|count)) {  // Note the parentheses
```

**Potential solution:** Consider making the parser smarter about filter precedence, or provide a lint warning when filter expressions are used in comparisons without parentheses.

---

## [2026-02-21 00:15 PST] - Issue 4: No boolean type, use bool

**What I was trying to do:** (Didn't actually hit this, but noticed in suggestions)

**What the issue was:** The validator suggested using `bool` instead of `boolean`

**Why it was an issue:** I didn't actually use `boolean` in my code, but the validator suggested it as a fix in the error message. This is minor but could confuse developers coming from languages that use `boolean`.

**Potential solution:** Consider accepting both `bool` and `boolean` as aliases, or make the error message clearer: "Use 'bool' type instead of 'boolean' (XanoScript uses 'bool')"

---

## General Observations

### What worked well:
1. The MCP validate_xanoscript tool is fast and provides helpful suggestions
2. The documentation via `xanoscript_docs` is comprehensive
3. The quick_reference mode is useful for saving context tokens

### What could be improved:
1. The error messages sometimes point to the wrong location (e.g., pointing to newline instead of the actual type error)
2. The `each` requirement in while loops is unusual and not clearly highlighted
3. Would be nice to have a simple language reference card with all syntax patterns

### Feature requests:
1. Auto-formatter for XanoScript (like prettier/go fmt)
2. LSP support for real-time error highlighting in editors
3. More examples in the documentation showing common patterns like data structures (trees, graphs, etc.)
