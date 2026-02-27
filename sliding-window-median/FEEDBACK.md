# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 05:32 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs

**What the issue was:** I incorrectly assumed `run.job` worked like `function` with a `stack` block and `function.run` calls. The actual syntax is completely different:

My incorrect attempt:
```xs
run.job {
  description = "..."
  stack {
    function.run "name" { input = {...} } as $result
  }
}
```

Correct syntax:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

**Why it was an issue:** The error message "Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'" was not very helpful for understanding that run.job needs a name string, not braces.

**Potential solution:** The validator could suggest "run.job requires a name string: run.job \"Job Name\" {" when it sees `run.job {` without a name.

---

## [2025-02-27 05:33 PST] - Multiple if statements in conditional block

**What I was trying to do:** Handle multiple independent edge cases in a conditional block

**What the issue was:** I used multiple sequential `if` statements inside a single `conditional` block:
```xs
conditional {
  if (condition1) { ... }
  if (condition2) { ... }
  if (condition3) { ... }
}
```

This failed validation with "Expecting ... but found: 'if'" on the second if statement.

**Why it was an issue:** XanoScript requires `elseif` for multiple conditions in a single conditional block. Multiple independent `if` statements aren't allowed.

**Potential solution:** Better error message like "Use 'elseif' for additional conditions in a conditional block" instead of the generic token expectation error.

---

## [2025-02-27 05:34 PST] - sort filter parameter confusion

**What I was trying to do:** Sort an array in ascending order using `|sort:asc`

**What the issue was:** I assumed the sort filter took a parameter like `:asc` or `:desc` based on common patterns in other template languages.

**Why it was an issue:** The error "but found: 'asc'" was cryptic. I had to search existing code in the repo to find that `|sort` is used without parameters.

**Potential solution:** 
1. Documentation could explicitly state that `sort` doesn't take parameters
2. Error message could suggest "sort filter does not accept parameters, use |sort instead"

---

## [2025-02-27 05:35 PST] - Filter expression parentheses requirement

**What I was trying to do:** Compare the count of an array: `$input.nums|count == 0`

**What the issue was:** The validator/parser requires parentheses around filter expressions when used in comparisons: `($input.nums|count) == 0`

**Why it was an issue:** This syntax requirement isn't immediately obvious from the error messages, which just say they're expecting some token but found something else.

**Potential solution:** The validator could detect this pattern and suggest wrapping the filter expression in parentheses.

---

## [2025-02-27 05:35 PST] - run.job description property not allowed

**What I was trying to do:** Add a description to document what the run job does

**What the issue was:** The `description` property is valid for `function` but not for `run.job`

**Why it was an issue:** Inconsistent - some objects accept `description`, others don't. The error message was clear though: "The argument 'description' is not valid in this context"

**Potential solution:** Either allow `description` on run.job for documentation purposes, or make the error message suggest removing it since it's a common pattern from functions.

---

## General Feedback

### MCP Tool Experience
The `validate_xanoscript` tool works well and provides helpful line/column positions. The suggestions (like "Use 'int' instead of 'integer'") are useful.

### Documentation Gaps
1. The `run.job` syntax in the quick reference was too brief - I needed the full mode to understand the correct structure
2. The `sort` filter documentation wasn't clear about whether it takes parameters
3. The filter parentheses rule is buried in the syntax docs - it should be more prominent

### Error Message Improvements
Most validation errors would benefit from:
- More context about what the parser was expecting
- Common mistake suggestions (like "did you mean elseif?")
- Links to relevant documentation sections
