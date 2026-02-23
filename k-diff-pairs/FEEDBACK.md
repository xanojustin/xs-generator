# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 12:35 PST] - Issue 1: Tilde (~) Path Expansion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool with paths like `~/xs/k-diff-pairs/run.xs`.

**What the issue was:** The MCP tool doesn't expand the tilde (`~`) to the home directory, resulting in "File not found" errors.

**Why it was an issue:** Had to manually convert all paths to absolute paths (`/Users/justinalbrecht/xs/...`). This is unintuitive since most CLI tools and scripts handle `~` expansion.

**Potential solution:** The MCP should either:
1. Expand `~` to `$HOME` before accessing files
2. Document clearly that only absolute paths are accepted
3. Support both relative paths (from cwd) and absolute paths

---

## [2025-02-23 12:36 PST] - Issue 2: Conditional Syntax Confusion

**What I was trying to do:** Write an `if` statement inside a function's `stack` block to handle edge cases.

**What the issue was:** I wrote bare `if` statements like:
```xs
stack {
  if ($input.k < 0) {
    var $result { value = 0 }
  }
}
```

This caused a parse error: "Expecting } but found 'if'".

**Why it was an issue:** The error message was confusing - it made it seem like there was a missing closing brace, when actually the issue was that `if` statements must be wrapped in a `conditional { }` block.

**Potential solution:** 
1. Improve the error message to say something like "Conditionals must be wrapped in a 'conditional' block" 
2. The quickstart documentation is clear about this, but I missed it initially - perhaps emphasize this more prominently

---

## [2025-02-23 12:37 PST] - Issue 3: Non-existent `default` Filter

**What I was trying to do:** Provide a default value when getting a key from an object that might not exist: `$obj|get:"key"|default:0`.

**What the issue was:** The `default` filter doesn't exist in XanoScript. The error message helpfully suggested using `first_notnull` or `??` operator instead.

**Why it was an issue:** Many languages/frameworks have a `default` filter (Liquid, Twig, etc.), so it's a natural assumption. The correct solution was to use the 3-parameter form of `get`: `$obj|get:"key":0`.

**Potential solution:**
1. Consider adding a `default` alias for `first_notnull` for users coming from other template languages
2. The error message was actually very helpful here - kept the suggestion

---

## [2025-02-23 12:38 PST] - Issue 4: Backtick Requirements in Conditionals

**What I was trying to do:** Write a conditional expression.

**What the issue was:** Discovered that conditions inside `if` statements need to be wrapped in backticks (`` `condition` ``) rather than parentheses.

**Why it was an issue:** Most C-style languages use parentheses for conditions. XanoScript uses backticks, which is unusual and easy to forget.

**Potential solution:**
1. The quickstart docs clearly show this pattern - good documentation
2. Error messages could be more specific when detecting parenthesized conditions

---

## [2025-02-23 12:39 PST] - Positive Feedback

**What worked well:**

1. **Helpful error messages** - The suggestion about `default` filter was spot-on
2. **Quick reference documentation** - The `quick_reference` mode was useful for getting syntax patterns quickly
3. **Clear file structure** - The docs explaining `run.xs` + `function/` structure were helpful
4. **Validation tool** - Being able to validate before pushing to Xano saved time

---

## General Observations

1. **Learning curve:** XanoScript has some unique syntax patterns (conditionals, backticks, type names) that differ from common languages. The documentation is good, but it takes some adjustment.

2. **File-based validation:** The ability to validate files before deployment is excellent. Would be even better if the VS Code extension or CLI could do this locally without MCP calls.

3. **Type system:** The strict type system (`text` not `string`, `int` not `integer`) is clear once you know it, but easy to get wrong initially.
