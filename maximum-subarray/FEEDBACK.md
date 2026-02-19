# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 06:32 PST] - Initial misunderstanding of run.job structure

**What I was trying to do:** Create a run job with inline logic for the maximum subarray algorithm

**What the issue was:** I initially wrote the code directly in `run.xs` thinking `run.job` could contain the full implementation:
```xs
run.job {
  description = "..."
  input { ... }
  stack { ... }
}
```

**Why it was an issue:** The validation failed with `Expecting: one of these possible Token sequences: ["..."], [Identifier] but found: '{'`. I didn't understand that `run.job` requires a name and uses `main = { name: "function_name", ... }` to reference an external function.

**Potential solution:** The quick_reference for `run` topic was very minimal. It would help to have a more prominent example showing that run jobs call functions, not contain logic inline. The full documentation made this clear, but I had to specifically request it.

---

## [2026-02-19 06:35 PST] - Precondition expression syntax confusion

**What I was trying to do:** Add input validation using `precondition` to check if the input array is not empty

**What the issue was:** I wrote:
```xs
precondition ($input.nums|count > 0) {
```

This failed validation with: `An expression should be wrapped in parentheses when combining filters and tests`

**Why it was an issue:** The error message mentions "wrapped in parentheses" but the solution is to use **backticks** (`` ` ``), not regular parentheses. The correct syntax is:
```xs
precondition (`$input.nums|count > 0`) {
```

This was confusing because:
1. The error says "parentheses" but means "backticks"
2. The distinction between when to use regular parentheses `()` vs backticks `` ` `` isn't immediately clear

**Potential solution:** 
1. Update the error message to say "wrapped in backticks" instead of "parentheses"
2. Add a clear note in the quickstart/quick_reference about: expressions with operators (like `>`, `<`, `==`, `+`, etc.) must be wrapped in backticks

---

## [2026-02-19 06:36 PST] - While loop comparison syntax worked without backticks

**What I was trying to do:** Write a while loop with a comparison

**What happened:** Interestingly, this syntax validated without errors:
```xs
while ($index < ($input.nums|count)) {
```

**Why this is noteworthy:** It seems inconsistent that `precondition` requires backticks for expressions with operators, but `while` doesn't. Or perhaps the while loop is also incorrect and would fail at runtime?

**Potential solution:** Clarify in documentation which contexts require backticks and which don't. The current behavior seems inconsistent.

---
