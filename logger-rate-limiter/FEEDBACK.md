# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-28 03:05 PST - Initial Design Confusion

**What I was trying to do:** Design a logger rate limiter function that maintains state between calls

**What the issue was:** Initially, I wasn't sure how to handle state persistence in XanoScript functions. A rate limiter needs to remember when each message was last printed.

**Why it was an issue:** Functions in XanoScript are stateless - each call is independent. I considered using a database table, but that would add complexity for a coding exercise.

**Solution I used:** Changed the design to pass the message history as an input parameter and return the updated history. This makes the function pure and testable while still demonstrating the rate limiting logic.

**Potential improvement:** The documentation could include a pattern guide for "stateful" functions that need to maintain data across calls, recommending either:
1. Pass state as input/output (pure function approach)
2. Use database tables for persistence
3. Use Redis or other caching mechanisms

---

## 2025-02-28 03:08 PST - Validation Success

**What I was trying to do:** Validate the XanoScript files

**What the issue was:** No issues! Both files passed validation on the first attempt.

**Why it was notable:** This was surprising given the complexity of the function (conditionals, object manipulation, null coalescing). The Xano MCP validation is working well.

**What worked well:**
- The `??` null coalescing operator worked as expected for optional input
- The `object|get:key:default` pattern worked correctly
- The `object|set:key:value` pattern worked correctly
- Conditional blocks with `if` statements validated properly

---

## General Observations

### XanoScript Syntax Clarity
The documentation for XanoScript is quite good. The essentials guide clearly explains:
- Variable access patterns (`$input.field` vs `$var.field`)
- Filter syntax with parentheses requirements
- Conditional structure (elseif as one word)

### MCP Tool Performance
The validation tool is fast and gives clear output. The structured JSON response makes it easy to parse results programmatically.

### Missing Pattern: Multiple Test Cases in Run Job
It would be helpful to have documentation on how to run multiple test cases in a single run job. Currently, the run.xs only tests one case. Options I considered:
1. Create multiple run jobs (would need multiple run.xs files - not possible)
2. Create a "test_runner" function that calls the main function multiple times
3. Keep it simple with one test case

I went with option 3 for simplicity, but option 2 would be better for comprehensive testing.
