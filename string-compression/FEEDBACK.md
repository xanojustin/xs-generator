# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 20:05 PST] - Successful Implementation, Minor Documentation Gap

**What I was trying to do:** Create a string compression function that iterates through a string and builds a compressed representation with character counts.

**What the issue was:** No technical issues encountered! The code passed validation on the first attempt. However, I noticed the documentation for string manipulation could be clearer about:
1. How to extract single characters from strings (the `substr:position:length` pattern)
2. Best practices for building strings in a loop (concatenation with `~`)

**Why it was an issue:** Not a blocking issue, but having more examples of string iteration patterns in the quickstart would have sped up development.

**Potential solution:** Add a "String Iteration" example to the quickstart documentation showing how to loop through characters using `substr` with a counter.

---

## [2026-02-19 20:06 PST] - Path Resolution with ~

**What I was trying to do:** Validate files using `~/xs/` path shorthand in the validate_xanoscript tool.

**What the issue was:** The MCP tool doesn't expand the `~` (tilde) home directory shorthand, resulting in "File not found" errors.

**Why it was an issue:** Had to use full absolute paths (`/Users/justinalbrecht/xs/...`) instead of the more convenient `~` shorthand.

**Potential solution:** The MCP tool could automatically expand `~` to the user's home directory before processing file paths, making it consistent with shell behavior.
