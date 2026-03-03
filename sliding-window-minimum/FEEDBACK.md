# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 14:05 PST] - Filters syntax confusion

**What I was trying to do:** Add input validation using filters (min:1) to the k parameter

**What the issue was:** I initially wrote:
```xs
int k { description = "Window size", filters = "min:1" }
```
This caused two errors:
1. The argument 'filters' is not valid in this context
2. Expected value of `filters` to be `null`

I then tried without quotes:
```xs
int k { description = "Window size" filters = min:1 }
```
Which also failed.

**Why it was an issue:** The documentation shows `int age? filters=min:0` which puts filters OUTSIDE the braces, not inside. This was counter-intuitive since `description` goes inside braces.

**Potential solution:** Make filters placement more consistent (either all inside braces or all outside), or improve documentation to explicitly show the difference between field-level properties (inside braces) and type-level modifiers (outside braces).

---

## [2026-03-03 14:08 PST] - Inline comments not allowed

**What I was trying to do:** Add explanatory comments at the end of lines

**What the issue was:** Code like:
```xs
var $deque { value = [] }  // Stores indices, maintains increasing order of values
```
Caused parse error: "expecting at least one iteration which starts with one of these possible Token sequences"

**Why it was an issue:** Most programming languages allow inline comments. I had to move all comments to their own lines.

**Potential solution:** Support inline comments (// at end of line) as it's standard in most languages and improves code readability.

---

## [2026-03-03 14:12 PST] - While loop requires `each` block

**What I was trying to do:** Create a while loop for the deque processing logic

**What the issue was:** I wrote:
```xs
while (($deque|count) > 0 && $continue_checking) {
  var $back_idx { value = $deque|last }
  ...
}
```

This failed with: "Expecting --> each <-- but found --> '"

**Why it was an issue:** The documentation does show `each` inside while loops, but it's easy to miss and the error message is cryptic. The requirement that while loops must contain an `each` block is unusual.

**Potential solution:** 
1. Improve the error message to explicitly say "while loops must contain an 'each' block"
2. Consider allowing direct statements in while loops without the `each` wrapper for simpler use cases

---

## [2026-03-03 14:15 PST] - Block properties vs object literals confusion

**What I was trying to do:** Understand when to use commas

**What the issue was:** Block properties (using `=`) don't use commas, but object literals (using `:`) do:
```xs
// Block - no commas
throw {
  name = "Error"
  value = "message"
}

// Object literal - requires commas
{ type: "single", paging: { page: 1, per_page: 25 } }
```

**Why it was an issue:** This is documented but easy to mix up, especially when nesting objects inside blocks.

**Potential solution:** Consider allowing optional commas in blocks (ignored by parser) to reduce friction for developers used to JSON/JS syntax.

---

## General Feedback

### Positive
- The validation tool is excellent - provides specific line/column numbers and helpful suggestions
- The error messages often include the actual code that failed, making debugging easier
- Documentation is comprehensive with good examples

### Suggestions
1. **Syntax consistency:** Consider making filters placement consistent with description (both inside or both outside braces)
2. **Inline comments:** Add support for end-of-line comments
3. **While loop syntax:** Either make `each` optional in while loops or provide a clearer error message
4. **File path expansion:** The MCP doesn't expand `~` to home directory - would be convenient if it did
