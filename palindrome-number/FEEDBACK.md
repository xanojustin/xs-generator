# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-22 09:35 PST] - Type declaration confusion

**What I was trying to do:** Declare an integer input parameter in a function

**What the issue was:** I used `integer num { ... }` but XanoScript expects `int num { ... }`

**Why it was an issue:** The error message "Expecting '}' but found 'integer'" was confusing. It didn't clearly indicate that the type name was wrong. The suggestion "Use 'int' instead of 'integer'" was helpful but came after the cryptic parse error.

**Potential solution:** Better parse error messages that suggest valid type names when an invalid one is encountered. Could also list valid types in the quick reference more prominently.

---

## [2025-02-22 09:35 PST] - Run job syntax mismatch

**What I was trying to do:** Create a run.job that calls a function

**What the issue was:** The quick_reference docs showed a minimal structure, but the actual syntax required `run.job "Name" { main = { name: "...", input: {...} } }`. I initially tried `run.job { name = "..." main { function.run ... } }` which is completely different.

**Why it was an issue:** The quick reference showed:
```
run.job {
  name = "..."
  description = "..."
  main { ... }
}
```

But the actual working syntax from examples is:
```
run.job "Name" {
  main = {
    name: "function-name"
    input: { ... }
  }
}
```

These are completely different structures.

**Potential solution:** The quick_reference for `run` topic should show the actual working syntax with the `main = { name: ..., input: ... }` structure. The current documentation is misleading.

---

## [2025-02-22 09:38 PST] - Missing documentation on conditional blocks

**What I was trying to do:** Use an `if` statement inside a function's stack block

**What the issue was:** Got error "Expecting '}' but found 'if'" - the parser didn't accept bare `if` statements in the stack block.

**Why it was an issue:** I had to look at existing code examples to discover that `if` statements must be wrapped in a `conditional` block. The syntax quick reference doesn't mention the `conditional` keyword at all.

**Potential solution:** Add `conditional` to the syntax quick reference with an explanation that it's required for if/elseif/else chains at the stack level.

---

## [2025-02-22 09:34 PST] - Shell escaping issues with mcporter

**What I was trying to do:** Validate multiple files using the file_paths array parameter

**What the issue was:** The command `mcporter call xano.validate_xanoscript file_paths: ["path1", "path2"]` failed with shell escaping errors - the array syntax wasn't being parsed correctly by zsh.

**Why it was an issue:** Had to switch to using `directory:` parameter instead, which is less precise (validates all files in a directory).

**Potential solution:** Document the proper shell escaping for array parameters, or provide an alternative way to pass multiple files (e.g., comma-separated string or multiple file_path arguments).
