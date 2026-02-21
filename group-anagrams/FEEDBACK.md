# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 20:06 PST] - MCP Tool Parameter Naming

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter

**What the issue was:** The mcporter CLI requires using `--args` with a JSON string, but the initial instinct was to try different parameter name formats like `file_paths`, `files`, `file_path`. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing because it seemed like the tool wasn't receiving the parameter at all.

**Why it was an issue:** It took multiple attempts to find the right syntax: `mcporter call xano.validate_xanoscript --args '{"file_paths": [...]}'`

**Potential solution:** The MCP server error could be clearer about HOW to pass the parameter, or the mcporter documentation could have more examples of the `--args` JSON format.

---

## [2026-02-20 20:15 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Check if an array is empty using `($input.strings|count) == 0`

**What the issue was:** Initially wrote `$input.strings|count == 0` without parentheses around the filter expression, which caused a parse error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message was helpful, but this syntax requirement isn't immediately obvious. In many languages, operator precedence would handle this naturally.

**Potential solution:** Documentation could emphasize this pattern more prominently in the quickstart or have a specific section on "filter expression wrapping".

---

## [2026-02-20 20:18 PST] - index_by Filter String Quoting

**What I was trying to do:** Use the `index_by` filter to group an array of objects by a property

**What the issue was:** Wrote `$tagged_words|index_by:signature` (bare identifier) but XanoScript requires `$tagged_words|index_by:"signature"` (quoted string)

**Why it was an issue:** The documentation shows `index_by:g` in the table, suggesting bare identifiers work, but that appears to be shorthand documentation. The actual syntax requires a quoted string for the property name.

**Potential solution:** The syntax documentation could clarify that filter parameters taking property names need to be quoted strings, or show both variations with a note about which is preferred.

---

## [2026-02-20 20:20 PST] - Split Filter Name (str_split vs split)

**What I was trying to do:** Split a string into characters using a filter

**What the issue was:** Guessed `str_split:""` but the correct filter is `split:""` (no `str_` prefix)

**Why it was an issue:** The naming convention is inconsistent with common programming patterns where string-specific functions often have a `str_` prefix. The validation error "Unknown filter function 'str_split'" was clear, but finding the right name required consulting the docs.

**Potential solution:** The MCP could suggest similar filter names when an unknown one is encountered ("Did you mean 'split'?").

---

## General Observation: Documentation Access

The `xanoscript_docs` tool works but returns the same general documentation regardless of the topic requested. It would be more helpful if topic-specific documentation was actually returned (e.g., `functions` topic returning just function-related docs, `syntax` returning syntax details, etc.). Currently all topics seem to return the same overview content.
