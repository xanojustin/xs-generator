# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 15:05 PST] - file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The command `mcporter call xano.validate_xanoscript file_paths=~/xs/count-vowels/run.xs,~/xs/count-vowels/function/count-vowels.xs` parsed the comma-separated string character by character instead of as an array, resulting in 67 "files" being checked (each character was treated as a separate file path).

**Why it was an issue:** This made batch validation via `file_paths` unusable. I had to switch to using the `directory` parameter instead.

**Potential solution:** The MCP should either:
1. Properly parse comma-separated values into an array
2. Accept multiple `file_paths` arguments
3. Document that `directory` is the preferred approach for multiple files

---

## [2026-02-19 15:10 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs and logs multiple results

**What the issue was:** The documentation shows `run.job "Name" { main = { name: "func", input: {} } }` syntax which is very limited - it only calls a single function once. I initially tried to write a more complex run job with a `stack` block and `function.run` calls like you would in a task, but that's not valid syntax for run.job.

**Why it was an issue:** The architecture requirement says "a run job that calls a function which solves the exercise" but the run.job syntax is limited to a single function call. I had to simplify to just calling the function once instead of running multiple test cases.

**Potential solution:** 
1. Clarify in documentation that `run.job` is for single function execution
2. For test scenarios, suggest using a task or a "test runner" function pattern
3. Or allow `run.job` to have a `stack` block like tasks do

---

## [2026-02-19 15:12 PST] - Input block syntax learning curve

**What I was trying to do:** Define an input parameter with a description and filters

**What the issue was:** I tried multiple incorrect syntaxes:
```xs
// Wrong - description outside braces
input {
  text text filters=lower
  description = "..."
}

// Wrong - filters inside braces  
input {
  text text {
    description = "..."
    filters = lower
  }
}
```

**Why it was an issue:** The correct syntax wasn't immediately obvious from the quick reference. The filters go inline with the type/variable, and description goes in braces:
```xs
input {
  text text filters=lower {
    description = "..."
  }
}
```

**Potential solution:** Include a clearer example in the quickstart showing the full input syntax with both filters and description.

---

## [2026-02-19 15:15 PST] - Response block syntax confusion

**What I was trying to do:** Return an object with multiple values from a function

**What the issue was:** I used `response { key = value }` syntax (similar to other blocks) but the correct syntax is `response = { key: value }` with an equals sign and colons for object properties.

**Why it was an issue:** This is inconsistent with other blocks like `input { }` and `stack { }` which don't use `=` after the keyword. The response block uses assignment syntax instead of block syntax.

**Potential solution:** 
1. Emphasize this difference more prominently in the quick reference
2. The error message "Expecting = but found {" was actually helpful once I understood the pattern
