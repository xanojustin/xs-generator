# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-25 20:05 PST - MCP file_paths argument parsing issue

**What I was trying to do:** Validate multiple .xs files at once using the `file_paths` parameter

**What the issue was:** The `file_paths` parameter with comma-separated values was parsed incorrectly - each character was treated as a separate file path

**Why it was an issue:** This made batch validation fail completely:
```
File not found: U
File not found: s
File not found: e
...
```

**Potential solution:** The MCP should properly parse array inputs for `file_paths` parameter, or the CLI should use JSON format for complex arguments

**Workaround:** Use `--args '{"file_path":"/path/to/single/file.xs"}'` for single files or `directory` parameter for batch validation

---

## 2025-02-25 20:08 PST - run.job syntax confusion

**What I was trying to do:** Create a run.xs file following the general XanoScript function pattern

**What the issue was:** I initially wrote:
```xs
run.job {
  name = "..."
  stack { ... }
  response = ...
}
```

But the correct syntax is:
```xs
run.job "Name" {
  main = { name: "function-name", input: { ... } }
}
```

**Why it was an issue:** The error message `Expecting --> run <-- but found --> '\n' <--` was cryptic and didn't clearly indicate that run.job requires a quoted name string followed by `main = { ... }` block

**Potential solution:** 
1. Better error message indicating expected `run.job "name"` format
2. Documentation could show the run.job structure more prominently in the quickstart

---

## 2025-02-25 20:12 PST - range/each syntax limitation

**What I was trying to do:** Use `each (range 1 ($input.n + 1)) as $i { ... }` to iterate over a range

**What the issue was:** This syntax is invalid - `each` cannot directly iterate over a `range` expression inline

**Why it was an issue:** The error `Expecting --> } <-- but found --> 'each' <--` didn't explain that the syntax was wrong

**Potential solution:** 
1. Document that `each` requires a pre-computed array variable
2. Or support inline range iteration: `each (1..$n) as $i { ... }`
3. Better error message suggesting to use `while` loop for numeric iteration

**Workaround:** Use `while` loop with manual counter:
```xs
var $i { value = 0 }
while ($i < $input.n) {
  each {
    // ...
    var.update $i { value = $i + 1 }
  }
}
```

---

## 2025-02-25 20:15 PST - Comment blank line issue

**What I was trying to do:** Add a comment followed by a blank line before the run.job declaration

**What the issue was:** The validator failed with `Expecting --> run <-- but found --> '\n' <--`

**Why it was an issue:** A blank line between the comment and the run.job caused a parse error

**Potential solution:** The parser should be more tolerant of whitespace between comments and declarations

**Workaround:** Keep the comment on the line immediately before the code:
```xs
// Comment here
run.job "Name" { ... }
```
