# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 04:05 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a while loop condition that checks if a stack array is not empty using the `count` filter

**What the issue was:** The code `$stack|count > 0` failed validation with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message was clear about the solution (wrap in parentheses), but this syntax requirement is easy to forget. The pattern `($var|filter > value)` is common but the documentation didn't emphasize this enough in the examples I saw.

**Potential solution:** Add a more prominent example in the quickstart documentation showing filter expressions combined with comparison operators, since this is a very common pattern.

---

## [2026-02-21 04:05 PST] - File Path Resolution in MCP

**What I was trying to do:** Validate files using the `validate_xanoscript` tool with `~/xs/` paths

**What the issue was:** The MCP tool didn't recognize tilde (`~`) as the home directory, requiring absolute paths like `/Users/justinalbrecht/xs/`

**Why it was an issue:** Most CLI tools and shells expand `~` automatically. Having to convert to absolute paths is an extra step that could be handled by the MCP.

**Potential solution:** Add path expansion to handle `~` and environment variables like `$HOME` in the MCP tool.

---

## [2026-02-21 04:05 PST] - No Issues Overall

**What I was trying to do:** Build a complete XanoScript coding exercise

**What the issue was:** Actually, everything worked quite well! The `xanoscript_docs` tool provided comprehensive documentation, the validation tool caught my syntax error with a clear message, and the overall workflow was smooth.

**Why it was an issue:** N/A - no issue

**Potential solution:** The MCP and documentation are working well. The validation error was user error on my part (forgot the parentheses rule from the quickstart guide).
