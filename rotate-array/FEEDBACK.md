# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 00:05 PST] - Early return pattern not supported

**What I was trying to do:** Implement early returns for edge cases (empty array, k=0) using `response = ...` and `return` inside conditional blocks, similar to patterns in other languages.

**What the issue was:** XanoScript doesn't allow using `response = ...` inside conditional blocks. The parser gives an error like:
```
Expecting --> } <-- but found --> 'response'
```

**Why it was an issue:** This pattern is common in many programming languages for guard clauses. I had to restructure my code to use nested conditionals with variable declarations in each branch instead, which is less intuitive.

**Potential solution:** 
1. Allow early returns with `response` and `return` in stack blocks
2. Or document this limitation more prominently with examples of how to structure code without early returns
3. Consider adding a `return` statement that can be used within conditionals

---

## [2025-02-19 00:08 PST] - MCP daemon not starting for stdio servers

**What I was trying to do:** Use `mcporter daemon start` to keep the MCP server running for faster validation calls.

**What the issue was:** The daemon wouldn't start with message: "No MCP servers are configured for keep-alive; daemon not started."

**Why it was an issue:** I had to use the `--stdio` flag with the full npx command for each validation call, which is slower.

**Potential solution:** 
1. Document how to configure stdio servers for keep-alive
2. Or clarify in the error message that stdio servers can't be daemonized and users should use `--stdio` flag

---

## [2025-02-19 00:10 PST] - Missing documentation on array manipulation filters

**What I was trying to do:** Find the correct filter for slicing arrays (to split an array into two parts).

**What the issue was:** The documentation mentions `slice` filter in the syntax docs, but doesn't provide clear examples of how to use it with the syntax `slice:start:end`.

**Why it was an issue:** I had to guess the syntax for the slice filter. It worked, but I wasn't sure if `slice:0:$split_point` was correct until I validated it.

**Potential solution:** 
1. Add more examples of array manipulation filters (slice, merge, push, etc.) to the quickstart or functions documentation
2. Include a brief example showing: `$array|slice:0:5` to get first 5 elements

---

## [2025-02-19 00:12 PST] - Variable scoping in nested conditionals

**What I was trying to do:** Declare `$result` variable in different branches of nested conditional blocks.

**What the issue was:** I wasn't sure if XanoScript would properly scope the `$result` variable declared in different branches, or if I needed to declare it beforehand.

**Why it was an issue:** The documentation doesn't clearly explain variable scoping rules, especially for variables declared inside conditional branches. I assumed it would work (and it did), but it required trial and error.

**Potential solution:** 
1. Document variable scoping rules more explicitly - are variables block-scoped or function-scoped?
2. Provide examples showing variable declarations inside conditionals

