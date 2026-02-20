# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 15:35 PST] - Inline Comments Not Supported

**What I was trying to do:** Add explanatory comments to the code for readability

**What the issue was:** XanoScript parser doesn't support inline comments (e.g., `var $x { value = 1 } // explanation`). This causes cryptic parse errors like "expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: '/'"

**Why it was an issue:** Most programming languages support inline comments. Having to put every comment on its own line breaks the natural flow of documentation and makes the code longer. The error message is also not very helpful - it doesn't clearly say "inline comments not supported."

**Potential solution:** Either:
1. Add support for inline comments in the parser
2. Improve the error message to say something like "Inline comments not supported. Move comment to its own line."

---

## [2025-02-20 15:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Check if a stack (array) has elements: `if ($stack|count > 0)`

**What the issue was:** The parser requires parentheses around filtered expressions when combined with operators. The error message says "An expression should be wrapped in parentheses when combining filters and tests" but this rule isn't obvious from the syntax docs.

**Why it was an issue:** It's easy to forget this rule, and the error only shows up at validation time. The natural way to write it is without parentheses.

**Potential solution:** 
1. The quick_reference docs could include a note about this requirement
2. Or the parser could be more lenient and auto-wrap simple filter expressions

---

## [2025-02-20 15:35 PST] - MCP file_paths Parameter Parsing

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated values

**What the issue was:** The comma-separated value syntax `"path1,path2"` appears to be parsed character by character, resulting in errors like "File not found: U", "File not found: s", etc. (treating each character as a separate file path)

**Why it was an issue:** Had to validate files individually, which takes more time and API calls

**Potential solution:** 
1. Document the correct format for passing multiple file paths
2. Or support an array format in the JSON payload

**Workaround:** Call validate_xanoscript once per file using `file_path` instead of `file_paths`
