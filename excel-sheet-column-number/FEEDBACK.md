# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 17:35 PST] - Input filter naming inconsistency

**What I was trying to do:** Apply `to_upper` filter to a text input to normalize the case of an Excel column title.

**What the issue was:** The validation error said "Filter 'to_upper' cannot be applied to input of type 'text'". However, according to the syntax docs, `to_upper` is a valid string filter.

**Why it was an issue:** There are TWO different filter naming conventions:
- In `stack` blocks (string filters): use `to_upper`, `to_lower`
- In `input` blocks (validation filters): use `upper`, `lower`

This is confusing because the documentation mentions both but doesn't clearly distinguish when to use which. I had to look at the "types" documentation specifically to find that input blocks use `upper`/`lower`.

**Potential solution:** 
1. Make the error message more helpful: "Use 'upper' instead of 'to_upper' in input blocks"
2. Or standardize on one naming convention
3. Or add a clear note in the syntax docs about input block filter names being different

---

## [2025-02-23 17:36 PST] - Missing 'ord' filter for character codes

**What I was trying to do:** Get the ASCII value of a character to convert 'A' to 1, 'B' to 2, etc. for the Excel column number problem.

**What the issue was:** There's no `ord` filter (like in Python or PHP) to get the ASCII/Unicode value of a character. The validation error said "Unknown filter function 'ord'".

**Why it was an issue:** Converting characters to their numeric values is a common operation in algorithms. Without `ord`, I had to create a lookup array of letters and use `findIndex` to get the position, which is less efficient and more verbose.

**Workaround used:**
```xs
var $letters { value = ["A", "B", "C", ... "Z"] }
var $char_index { value = ($letters|findIndex:$$ == $char) + 1 }
```

**Potential solution:** Add an `ord` filter (and corresponding `chr` filter) for character/ASCII conversions:
- `"A"|ord` → 65
- `65|chr` → "A"

---

## [2025-02-23 17:37 PST] - MCP parameter naming confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter CLI.

**What the issue was:** The mcporter CLI shows parameter names with hyphens (`file-path`) but the MCP server actually expects underscores (`file_path`).

```bash
# What the CLI schema shows:
mcporter call xano.validate_xanoscript file-path="..."

# What actually works:
mcporter call xano.validate_xanoscript file_path="..."
```

**Why it was an issue:** This caused validation to fail with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even though I was providing the file-path parameter.

**Potential solution:** 
1. Make mcporter automatically convert kebab-case to snake_case for MCP parameters
2. Or accept both formats on the MCP server side
3. Or at least document this clearly in the mcporter help output

---

## [2025-02-23 17:38 PST] - Good documentation overall

**Positive feedback:** Once I found the right documentation topics (`syntax`, `types`, `functions`, `quickstart`), the information was comprehensive and well-organized. The examples were helpful.

**What worked well:**
- The `xanoscript_docs` MCP tool is great for getting context-aware documentation
- The validation errors include line/column numbers which is very helpful
- The distinction between stack filters and input filters, once understood, makes sense (validation vs transformation)

---
