# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 06:35 PST] - Initial MCP Tool Parameter Issue

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The mcporter CLI tool was failing to pass parameters correctly. I tried multiple approaches:
- `mcporter call xano validate_xanoscript '{"file_paths": [...]}'`
- `mcporter call xano validate_xanoscript --file_path=...`
- Various JSON quoting and escaping approaches

All resulted in: `Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

**Why it was an issue:** I couldn't validate my code and was stuck at the very first step

**Potential solution (if known):** Eventually found that the `key=value` syntax works: `mcporter call xano validate_xanoscript directory="/path"` - but this was trial and error. The documentation or examples could clarify the expected mcporter CLI syntax.

---

## [2025-02-28 06:37 PST] - String Filter Syntax Confusion

**What I was trying to do:** Extract a single character from a string at a specific index

**What the issue was:** I incorrectly used `slice:$i,1` (comma syntax from JavaScript/Python habits). The error message was:
```
[Line 28, Column 49] Expecting --> } <-- but found --> '1' <--
```

The error pointed to the comma being unexpected, but didn't clearly indicate what the correct syntax should be.

**Why it was an issue:** I had to look up the string filters documentation to learn that `substr` uses colons: `substr:$i:1` - but it wasn't immediately clear from the error message which filter to use or what the correct syntax was.

**Potential solution (if known):** The error message could be more helpful:
- Suggest using `substr` instead of `slice` if that's the intended filter
- Show the correct colon-based parameter syntax for filters that use it
- The suggestion shown was about using "text" instead of "string" which was unrelated to the actual issue

---

## [2025-02-28 06:38 PST] - Documentation Request: run.job vs function.run

**What I was trying to do:** Understand how run jobs call functions

**What the issue was:** Looking at existing examples, I see the pattern:
```xs
run.job "Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

But the task instructions mentioned using `function.run`. It's unclear if `main = { name: ... }` is shorthand for `function.run`, or if these are different constructs.

**Why it was an issue:** Creates uncertainty about whether I'm following the correct pattern

**Potential solution (if known):** Clarification in the run job documentation about how functions are invoked - whether `main = { name: ... }` is the preferred modern syntax or if `function.run` should be used explicitly.

