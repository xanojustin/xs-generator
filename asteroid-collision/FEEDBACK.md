# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 13:33 PST] - While Loop Syntax Confusion

**What I was trying to do:** Implement a while loop for the asteroid collision algorithm that processes collisions between asteroids.

**What the issue was:** The XanoScript validator rejected my while loop with the error: "Expecting --> each <-- but found --> '"

I initially wrote:
```xs
while ($survives && $current < 0 && ($stack|count) > 0 && $stack|last > 0) {
  // logic here
}
```

**Why it was an issue:** The documentation shows while loops need an `each` block inside them, but this wasn't immediately obvious. The quickstart documentation shows:
```xs
while ($counter < 10) {
  each {
    var.update $counter { value = $counter + 1 }
  }
}
```

But I initially missed this detail. The error message "Expecting each" was helpful, but it took a moment to understand that `each` is a required wrapper block inside while loops.

**Potential solution:** Could the documentation or error messages be clearer about the requirement for `each` blocks inside while loops? Perhaps mention this more prominently in the quickstart section on loops.

---

## [2025-02-26 13:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Use the `|last` filter on an array within a while loop condition.

**What the issue was:** Got the error: "An expression should be wrapped in parentheses when combining filters and tests"

My code:
```xs
while ($survives && $current < 0 && ($stack|count) > 0 && $stack|last > 0) {
```

**Why it was an issue:** The `$stack|last > 0` part needed to be wrapped in parentheses: `($stack|last) > 0`. This is documented in the "Common Mistakes" section, but it's easy to forget when writing code.

**Potential solution:** The error message is actually quite helpful and points directly to the solution. The documentation also covers this well in the quickstart. This is more of a learning curve issue than a tooling problem.

---

## General Observations

1. **Good:** The MCP validation tool is very helpful for catching syntax errors before deployment.

2. **Good:** Error messages include the actual line of code that failed, making debugging easier.

3. **Suggestion:** The `each` block requirement inside while loops could be highlighted more prominently in the documentation, as it's different from most other programming languages.

4. **Suggestion:** It would be helpful to have a full syntax reference page that shows all the required block structures (like `each` inside `while`, `stack` as parent for loops, etc.) in one place.
