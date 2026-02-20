# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 16:05 PST] - MCP Tool Call Quoting Issue

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths using the `file_paths` parameter (array type)

**What the issue was:** The command `mcporter call xano.validate_xanoscript file_paths='["/path/to/file1.xs", "/path/to/file2.xs"]'` caused a shell parse error: `zsh:1: parse error near `}'`

**Why it was an issue:** Could not pass the JSON array parameter directly via CLI. Had to work around by using the `directory` parameter instead.

**Potential solution (if known):** Better documentation or examples for passing array parameters via CLI. Perhaps a `--args-file` option to read complex parameters from a JSON file.

---

## [2025-02-19 16:08 PST] - MCP Server Not Found in Daemon Mode

**What I was trying to do:** Call the xano MCP server after changing directories

**What the issue was:** Running `cd ~/xs/binary-search && mcporter call xano.validate_xanoscript directory=...` resulted in "Unknown MCP server 'xano'"

**Why it was an issue:** The mcporter daemon wasn't running, and direct stdio calls required the `--stdio` flag with the full command name.

**Potential solution (if known):** The error message could suggest starting the daemon or using `--stdio` mode. Also, `mcporter daemon start` returned "No MCP servers are configured for keep-alive" which was confusing since servers are configured.

---

## [2025-02-19 16:10 PST] - Syntax Uncertainty: Array Index Access

**What I was trying to do:** Access an array element by index in XanoScript

**What the issue was:** I wasn't certain if the syntax `$input.nums[$mid]` was valid for array indexing. Most languages use brackets, but I couldn't find explicit documentation on array access syntax in the quick reference.

**Why it was an issue:** Had to guess at the syntax. The code passed validation, so it worked, but I was uncertain during development.

**Potential solution (if known):** Add array indexing syntax to the cheatsheet or quickstart documentation. Example: `array[index]` for accessing elements by index.

---

## [2025-02-19 16:10 PST] - Documentation Gap: Logical NOT Operator

**What I was trying to do:** Use a logical NOT operator in a while loop condition: `while (($left <= $right) && !$found)`

**What the issue was:** The syntax docs show `!` as a logical operator, but I wasn't 100% sure if `!$found` was the correct syntax for negating a boolean variable (vs `! $found` with a space, or `not $found`).

**Why it was an issue:** Small uncertainty about operator syntax. The code passed validation, so `!$found` is correct, but explicit examples would help.

**Potential solution (if known):** Add a boolean negation example to the quickstart: `!$bool_var` or `!($condition)`.

---

## Summary

Overall, the Xano MCP worked well once I figured out the correct invocation pattern. The main pain points were:

1. **CLI argument passing** — Complex parameters (arrays/objects) are tricky to pass via command line
2. **Documentation gaps** — Some common patterns (array indexing, boolean negation) aren't explicitly shown in quick reference
3. **Daemon/stdio confusion** — It wasn't immediately clear when to use `--stdio` vs daemon mode

The validation tool itself is excellent — caught no errors because the documentation was sufficient to write correct code, but more examples would reduce uncertainty during development.
