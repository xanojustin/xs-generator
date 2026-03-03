# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 19:35 PST] - MCP Tool Call Syntax Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files.

**What the issue was:** The mcporter CLI has multiple ways to pass arguments, and it was unclear which format to use. I tried:
- `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file"}'` - didn't work
- `mcporter call xano validate_xanoscript --file_path ~/path` - didn't work
- Various JSON quoting approaches all failed with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** Wasted significant time trying different syntaxes. The error message suggested the parameters were required but I was providing them.

**Potential solution:** The `--args` flag was the solution: `mcporter call xano validate_xanoscript --args '{"file_path":"/path"}'`. This should be more prominently documented or made the default behavior.

---

## [2026-03-02 19:40 PST] - Unknown XanoScript Syntax for Random Numbers

**What I was trying to do:** Generate a random number between 1 and N for the weighted pick algorithm.

**What the issue was:** I initially assumed there would be a `random` filter like `$value|random:min:max`, but this doesn't exist. The validation error was: "Unknown filter function 'random'".

**Why it was an issue:** Common programming languages typically have built-in random functions or filters. I had to search through documentation to find that random number generation is under `security.random_number { min = 1, max = N }`.

**Potential solution:** Consider adding a `random` filter for convenience, or document common operations like random number generation more prominently in the essentials/quick reference. The `security.*` prefix for random numbers is unintuitive (why is random under security?).

---

## [2026-03-02 19:42 PST] - Input Default Value Syntax Confusion

**What I was trying to do:** Set a default value for an optional input parameter `num_picks`.

**What the issue was:** I wrote `int num_picks { description = "...", default = 1 }` based on intuition from other languages. The validation error said "The argument 'default' is not valid in this context" and "Expected value of `default` to be `null'`.

**Why it was an issue:** The correct syntax `int num_picks?=1 { ... }` is quite different from most languages where defaults are specified inside the braces/definition block.

**Potential solution:** The documentation does show this in the types section, but a more helpful error message could suggest the `?=` syntax. Something like: "Use `int num_picks?=1` instead of `default = 1`".

---

## [2026-03-02 19:43 PST] - Array Length Filter Naming

**What I was trying to do:** Get the length of an array to set up binary search bounds.

**What the issue was:** I used `$array|length` which is common in many languages. The error was "Unknown filter function 'length'".

**Why it was an issue:** XanoScript uses `count` instead of `length` for arrays. This is mentioned in the documentation but easy to miss.

**Potential solution:** Consider aliasing `length` to `count` for array types since `length` is more common in other languages (JavaScript, Python, etc.). Or provide a helpful suggestion: "Did you mean `count`?".

---

## [2026-03-02 19:45 PST] - Comment Syntax in run.job main Block

**What I was trying to do:** Add a comment inside the `main = { ... }` block of a run.job.

**What the issue was:** I added `// We'll run multiple times to demonstrate the randomness` inside the main block. The validator said: "Expecting --> } <-- but found --> '// We'll...'".

**Why it was an issue:** The `main = { }` shorthand syntax in run.job doesn't support comments inside it. This is inconsistent since comments work elsewhere in XanoScript.

**Potential solution:** Either support comments in the shorthand syntax, or document this limitation clearly in the run job documentation. The error message could also be more helpful: "Comments are not supported inside the main = { } shorthand block".

---

## Summary

Overall the Xano MCP validation tool is very helpful - once I figured out the correct CLI syntax, it caught real errors and helped me fix them quickly. The main struggles were:

1. **CLI argument passing** - The `--args` flag approach isn't obvious
2. **Syntax differences from common languages** - random under security, count instead of length, `?=` for defaults
3. **Inconsistent comment support** - Comments work in most places but not in run.job main blocks

The documentation is comprehensive but sometimes hard to navigate when looking for specific solutions. More helpful error messages with "did you mean..." suggestions would significantly improve the developer experience.
