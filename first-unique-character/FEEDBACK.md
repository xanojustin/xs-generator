# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 00:32 PST] - Conditional Syntax Confusion with Backticks

**What I was trying to do:** Write a conditional block with if/else statements in XanoScript

**What the issue was:** Initially tried using backticks around filter expressions in conditionals:
```xs
if (`$char_counts|has:$char`) {
  ...
} else {
  ...
}
```
This produced the error: "Expecting --> } <-- but found --> 'else'"

**Why it was an issue:** The documentation showed backticks being used in the fizzbuzz example:
```xs
if (`$i % 15 == 0`) {
```

But the two-sum example didn't use backticks:
```xs
if ($seen|has:($complement|to_text)) {
```

There was no clear guidance on when backticks are required vs optional. It seems:
- Backticks are needed for arithmetic expressions with operators (`%`, `+`, `-`, etc.)
- Backticks are NOT needed for filter expressions (like `|has:`, `|get:`, etc.)

**Potential solution (if known):** 
- Update the cheatsheet/quickstart documentation to clearly explain when backticks are required
- Add examples showing both cases side-by-side
- Consider making the parser error message more helpful for this specific case

---

## [2026-02-24 00:32 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Compare the result of a filter operation in a precondition

**What the issue was:** Wrote:
```xs
precondition ($input.s|strlen > 0) {
```

Got error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The precedence of filters vs comparison operators isn't intuitive. The parser interpreted this differently than expected.

**Potential solution (if known):**
- The error message was actually very helpful and clear
- Maybe include this specific example in the documentation since string length checks are common

---

## [2026-02-24 00:30 PST] - MCP Tool Documentation Gap

**What I was trying to do:** Understand how to structure run.job files properly

**What the issue was:** The quick_reference for `run` topic was minimal. Had to fetch the full documentation to understand the proper syntax for `main = { name: ..., input: ... }`

**Why it was an issue:** The quick_reference showed the structure but didn't show an actual complete working example with the `main` property for run.job

**Potential solution (if known):**
- Include a complete minimal working example in the quick_reference
- The full docs were excellent once I fetched them
