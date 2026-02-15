# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 11:50 PST] - MCP Tool Invocation Syntax Confusion

**What I was trying to do:**
Call the `validate_xanoscript` tool on the Xano MCP to validate my XanoScript code.

**What the issue was:**
The mcporter CLI syntax for calling tools with complex parameters is not well documented. Initially I tried:
```
mcporter call xano validate_xanoscript '{"code": "..."}'
```

This failed with "'code' parameter is required". After multiple attempts, I discovered the correct syntax requires the `code=` prefix without JSON wrapping:
```
mcporter call xano validate_xanoscript 'code=run.job "Test" { ... }'
```

**Why it was an issue:**
It took significant trial and error to figure out the correct parameter format. The error message wasn't helpful in guiding toward the correct syntax.

**Potential solution:**
Provide clearer documentation or examples in the MCP description showing how to pass string parameters, especially multi-line code blocks.

---

## [2025-02-15 11:52 PST] - Object and Boolean Input Syntax Differences

**What I was trying to do:**
Define function inputs with `object` and `boolean` types, following the same pattern as `text` inputs.

**What the issue was:**
I initially wrote:
```xs
input {
  text name filters=trim { description = "Name" }
  object fields { description = "Fields object" }
  boolean publish?=true { description = "Publish flag" }
}
```

This failed validation. Through trial and error and examining existing code (cloudflare-purge-cache), I discovered:
1. `object` types use `{ description = "..." }` but the description is on its own line, not inline like text
2. `boolean` is actually `bool` in XanoScript
3. The `{ description = ... }` block is required for object types but optional for text

The correct syntax is:
```xs
input {
  text name filters=trim { description = "Name" }
  object fields {
    description = "Fields object"
  }
  bool publish?=true {
    description = "Publish flag"
  }
}
```

**Why it was an issue:**
The inconsistent syntax between input types is confusing. Text types use inline `{ description = ... }` while object and bool types use multi-line blocks.

**Potential solution:**
Add clear documentation in the `types` or `functions` topic explaining the different syntax patterns for each input type, or unify the syntax to be consistent.

---

## [2025-02-15 11:55 PST] - Empty Stack Block Validation Error

**What I was trying to do:**
Create a minimal test function with an empty stack block:
```xs
function "test" {
  input { text name }
  stack { }
  response = $input.name
}
```

**What the issue was:**
The validator reported an error expecting content in the stack block. An empty `stack { }` is not valid - it must contain at least one statement.

**Why it was an issue:**
When prototyping or testing syntax, having to add dummy statements to an empty stack is inconvenient. The error message was also cryptic:
"Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: '}'"

**Potential solution:**
Allow empty stack blocks for prototyping, or provide a clearer error message like "Stack block cannot be empty - add at least one statement".

---

## [2025-02-15 11:58 PST] - Run Job vs Function Terminology

**What I was trying to do:**
Understand the relationship between "run jobs" and XanoScript tasks/functions.

**What the issue was:**
The task instructions mentioned "run job" and the folder structure shows `run.xs`, but the XanoScript documentation talks about `task` constructs in `task/{name}.xs` files. I initially thought I needed to create a `task` file, but looking at existing examples, they use a `run.xs` file with a `run.job` construct.

**Why it was an issue:**
The terminology is inconsistent. The folder is `~/xs/` (not `~/xano/` or `~/xanoscript/`), the file is `run.xs` (not `task.xs`), and the construct is `run.job` (not `task`).

**Potential solution:**
Clarify in documentation that `run.job` is a specific construct for the Xano Job Runner, distinct from scheduled `task` constructs. Explain when to use each.

---

## Summary

The Xano MCP validation tool works well once you understand the syntax patterns. The main friction points were:
1. Figuring out the correct mcporter CLI invocation format
2. Understanding the subtle syntax differences between input types
3. Interpreting cryptic validation error messages

Overall, being able to validate XanoScript before pushing to Xano is very valuable and saved time compared to the edit-upload-test cycle.
