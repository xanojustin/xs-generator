# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 03:03 PST] - Multi-line Comment Parsing Issue

**What I was trying to do:** Create a XanoScript function with a header comment block explaining the problem.

**What the issue was:** The validator gave an error: `[Line 7, Column 1] Expecting --> function <-- but found --> '
' <--`. This indicated that having a blank line between the comment block and the `function` declaration caused a parsing error.

**Why it was an issue:** The error message was confusing because it looked like the parser expected `function` but found a newline. The actual issue was that XanoScript doesn't allow blank lines between comments and the function declaration. Looking at working examples, comments must be immediately followed by the function keyword with no intervening blank lines.

**Potential solution (if known):** 
- The MCP documentation or validation error could be clearer about this requirement
- The error message could say something like "Blank lines not allowed between comments and function declaration" instead of the cryptic "Expecting function but found newline"

## [2026-02-24 03:05 PST] - Validate Tool Parameter Format

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths.

**What the issue was:** Initially tried using JSON parameter format like `'{"file_paths": [...]}'` but the tool didn't recognize the parameters. Had to use the flag-style syntax `directory:/path/to/dir` instead.

**Why it was an issue:** The mcporter help shows multiple ways to pass arguments (key=value, key:value, --args JSON, positional), but the Xano MCP tool specifically seems to require the flag-style format. This wasn't immediately clear from the documentation.

**Potential solution (if known):**
- The Xano MCP docs could include example calls showing the correct parameter format
- The tool could accept JSON format via --args as well as flag-style

## [2026-02-24 03:06 PST] - Early Return Pattern Discovery

**What I was trying to do:** Handle the empty tree edge case by setting a variable inside a conditional block.

**What the issue was:** Initially wrote:
```xs
conditional {
  if ($input.root == null) {
    var $min_depth { value = 0 }
  }
  else {
    // rest of logic
  }
}
```

But looking at working examples, the correct pattern for early returns is:
```xs
conditional {
  if ($input.root == null) {
    return { value = 0 }
  }
}
// rest of logic continues without else block
```

**Why it was an issue:** The `return` statement wasn't mentioned in the basic documentation I retrieved. I had to discover this by examining existing working code.

**Potential solution (if known):**
- The `xanoscript_docs` for functions topic could include a section on early return patterns
- More code examples showing common patterns like early returns would be helpful

## General Observations

1. **Documentation Depth:** The documentation retrieved from `xanoscript_docs` was mostly high-level overviews. Getting more detailed syntax examples required looking at existing code in the `~/xs/` directory.

2. **Error Messages:** Validation error messages could be more specific about what syntax is expected vs. what was found, with suggestions for fixes.

3. **Learning by Example:** The existing exercises in `~/xs/` were invaluable for understanding correct patterns. Without them, it would have been much harder to write valid XanoScript.
