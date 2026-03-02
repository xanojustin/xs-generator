# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-02 03:35 PST - run.job Syntax Discovery

**What I was trying to do:** Create a run.xs file that calls a function with test inputs

**What the issue was:** I initially wrote run.xs with a `stack` block and `description` field, similar to how `function` objects are structured:

```xs
run.job {
  description = "..."
  stack {
    // logic here
  }
}
```

This resulted in a parser error: `Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'`

**Why it was an issue:** The quick_reference documentation for `run` only showed the basic structure without full syntax details. I had to call `xanoscript_docs topic='run' mode='full'` to discover the correct syntax:

```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

**Potential solution:** 
- The quick_reference for `run` could include a minimal complete example showing the proper syntax
- The error message could be more helpful - perhaps suggesting that run.job requires a quoted name string

---

## 2025-03-02 03:36 PST - Lack of MCP Tool Documentation Clarity

**What I was trying to do:** Call the validate_xanoscript tool with multiple files

**What the issue was:** The tool help shows `file_paths?: string[]` but doesn't clearly show the proper CLI syntax. I tried:
- `mcporter call xano.validate_xanoscript file_paths:='["path1", "path2"]'` - didn't work
- Various other quoting patterns

Eventually using `directory` parameter worked, but it required trial and error.

**Why it was an issue:** Inefficient development loop when validation fails due to CLI syntax rather than code issues.

**Potential solution:** 
- Include a clear example in the tool description showing the exact mcporter CLI syntax for each parameter type
- Example: `mcporter call xano.validate_xanoscript directory='/path/to/dir'`

---

## 2025-03-02 03:37 PST - Path Resolution with ~

**What I was trying to do:** Validate files using `directory='~/xs/expressive-words'`

**What the issue was:** The MCP didn't expand the `~` home directory shorthand, resulting in "No .xs files found in directory"

**Why it was an issue:** Had to use full absolute path `/Users/justinalbrecht/xs/expressive-words` instead of the more convenient `~` shorthand.

**Potential solution:** 
- Support shell-style path expansion (~, ~user) in file_path and directory parameters
- Or document that absolute paths are required

---

## General Notes

**What worked well:**
- The validation tool provides clear line/column error locations
- Error messages show the actual code at the error line
- Full documentation mode is comprehensive and helpful
- Once syntax is correct, validation is fast and reliable

**Areas for improvement:**
- The quick_reference mode for `run` topic was too minimal - missing critical syntax details
- CLI parameter examples would help with mcporter invocation
- Path expansion would improve developer experience
