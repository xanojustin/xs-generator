# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 01:32 PST] - MCP Tool: file_paths Parameter Parsing Issue

**What I was trying to do:** Validate multiple XanoScript files using the `file_paths` parameter with comma-separated paths.

**What the issue was:** When passing multiple file paths as a comma-separated string to the `file_paths` parameter, the MCP tool appeared to split the string character-by-character instead of treating it as an array of paths. This resulted in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

The tool seemed to be iterating over each character in the path string rather than splitting by comma.

**Why it was an issue:** This prevented batch validation of multiple specific files. The workaround was to use the `directory` parameter instead, which worked correctly.

**Potential solution (if known):** The MCP tool should properly parse the `file_paths` parameter as an array of strings. The CLI help suggests the format should be `--file-paths:value1,value2` but this may not be correctly handled internally. Consider accepting JSON array format like `["path1", "path2"]` or fixing the comma-splitting logic.

---

## [2026-02-22 01:32 PST] - Documentation: Run Job Syntax Example

**What I was trying to do:** Understand the correct syntax for defining a `run.job` that calls a function.

**What the issue was:** The quick_reference documentation for the `run` topic was very minimal and didn't show a complete example of a run.job calling a function with inputs. I had to infer the syntax from the existing bubble-sort example in the `~/xs/` directory.

**Why it was an issue:** Without a clear example, I was unsure about:
- Whether to use `function.run` inside a `stack` block or the `main` shorthand
- The correct structure of the `main` object (is it `name` or `function_name`?)
- How to pass inputs (is it `input`, `inputs`, or `params`?)

**Potential solution (if known):** Add a complete example to the `run` topic documentation showing:
```xs
run.job "Example Job" {
  main = {
    name: "function_name"
    input: {
      param1: value1
      param2: value2
    }
  }
}
```

---

## [2026-02-22 01:32 PST] - Positive Feedback: First-Time Validation Success

**What I was trying to do:** Write valid XanoScript code for a function and run job.

**What went well:** Both files passed validation on the first attempt without any errors.

**Why this matters:** The documentation (quickstart, functions, and run topics) provided sufficient information to write correct code. The examples of:
- Variable declaration with `var $name { value = ... }`
- Conditional blocks with `if`, `elseif`, `else`
- While loops with proper `each` blocks inside
- Function input/output patterns
- Run job structure

were all clear enough to implement the insertion sort algorithm correctly.

---
