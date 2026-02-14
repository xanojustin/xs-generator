# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-14 12:55 PST - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Validate XanoScript files (.xs) using the Xano MCP `validate_xanoscript` tool before committing.

**What the issue was:**
The `validate_xanoscript` tool requires passing the code as a `code` parameter. When passing multi-line XanoScript code through shell commands, the newlines were being stripped or interpreted incorrectly, causing validation errors like:
- `function is missing an input clause`
- `Expecting --> { <-- but found --> '`
- Line numbers reported were always line 1 because newlines were lost

**Why it was an issue:**
This made it extremely difficult to validate files from the command line. I had to try many approaches:
- Direct variable expansion (`$()`)
- Heredocs
- Python subprocess with various methods
- Node.js scripts

Only when I used a heredoc with proper quoting did the newlines get preserved correctly.

**Potential solution (if known):**
- The MCP tool could accept a `file_path` parameter to read the file directly
- Or accept JSON input via stdin instead of command-line arguments
- Documentation could include examples of how to properly escape code for validation

---

## 2025-02-14 12:58 PST - Filter Expression Parentheses Requirement

**What I was trying to do:**
Use the `count` filter in a precondition to validate array length: `($dsn_parts|count == 2)`

**What the issue was:**
The validator reported: `An expression should be wrapped in parentheses when combining filters and tests`

The error message was clear, but this syntax requirement wasn't obvious from the documentation examples. I had to change:
- ❌ `($dsn_parts|count == 2)` 
- ✅ `(($dsn_parts|count) == 2)`

**Why it was an issue:**
This extra layer of parentheses isn't intuitive and isn't highlighted in the quickstart examples. It took multiple validation attempts to discover the correct syntax.

**Potential solution (if known):**
- Add this specific pattern to the "Common Mistakes" section of the quickstart documentation
- Include an example like: `precondition (($items|count) > 0)`

---

## 2025-02-14 12:48 PST - Unknown Filter Functions

**What I was trying to do:**
Parse a string using common string manipulation functions like `strpos`, `substr`, `explode`, `slice`.

**What the issue was:**
Several filters I tried to use don't exist in XanoScript:
- `strpos` - Not available (got "Unknown filter function 'strpos'")
- `explode` - Not available
- `slice` on strings - Only works on arrays according to docs

I had to discover through trial-and-error that `split` was the correct filter to use.

**Why it was an issue:**
The syntax documentation lists some filters but isn't comprehensive. I had to test each filter individually to find what works.

**Potential solution (if known):**
- Include a comprehensive filter reference in the syntax documentation
- Or provide a `list_filters` tool in the MCP to query available filters

---

## 2025-02-14 12:45 PST - Missing split Filter in Quick Reference

**What I was trying to do:**
Find the correct syntax for splitting strings in the quick reference documentation.

**What the issue was:**
The `split` filter is shown in the full syntax documentation but NOT in the quick_reference mode. I almost missed it because I was using `mode="quick_reference"` to save tokens.

**Why it was an issue:**
`split` is a very common operation (I needed it to parse the Sentry DSN), but it's omitted from the quick reference. The quick reference only shows: trim, to_lower/to_upper, first/last, count, get, set, json_encode/json_decode, to_text/to_int.

**Potential solution (if known):**
- Add `split`, `substr`, and `replace` to the quick reference - they're essential for string manipulation

---

## General Notes

### Documentation Quality
The documentation is generally good, especially the quickstart patterns. However, finding the right filter for string parsing was harder than it should be.

### Validation Tool
The validation tool works well once you can get the code to it properly. The main pain point is the command-line interface requiring complex escaping. A file-based validation option would be much easier to use.

### Positive Feedback
- The error messages from validate_xanoscript are helpful and specific (line/column numbers, clear descriptions)
- The `xanoscript_docs` tool is comprehensive with good examples
- The pattern documentation in quickstart is excellent for common operations

