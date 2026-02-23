# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 13:05 PST - MCP Tool Invocation Syntax Issues

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool via mcporter CLI

**What the issue was:** The mcporter call command had difficulty parsing named arguments. Multiple attempts failed:
- `mcporter call xano validate_xanoscript '{"file_path": "..."}'` - Didn't work
- `mcporter call xano validate_xanoscript --file_path /path` - Tried to parse `--file_path` as XanoScript code
- `mcporter call xano validate_xanoscript file_path=/path` - Unrecognized format

**Why it was an issue:** It took multiple attempts to find the correct syntax (`--args '{"file_path":"..."}'`), which was not immediately obvious from the documentation. The error messages were confusing - sometimes saying parameters were missing, other times trying to parse the argument flags as XanoScript code.

**Potential solution (if known):** 
1. Improve documentation/examples for the mcporter call syntax
2. Better error messages that suggest using `--args` for JSON parameters
3. Support more standard CLI patterns like `key=value` or positional JSON arguments

---

## 2025-02-23 13:08 PST - XanoScript Documentation for 2D Array Access

**What I was trying to do:** Access and update elements in a 2D array (the DP table) using the syntax `$dp[i][j]`

**What the issue was:** I was uncertain about the correct syntax for:
1. Creating nested arrays (2D arrays)
2. Accessing elements: `$dp[$i][$j]` vs `$dp[$i][$j|to_text]`
3. Updating elements in nested arrays: `var.update $dp[$i]` with `set:$j:value`

**Why it was an issue:** The documentation mentions filters like `set` and `get` for object manipulation, but it's unclear how they apply to nested array structures commonly used in DP algorithms. I had to infer from existing examples like `number_of_islands`.

**Potential solution (if known):**
1. Add specific documentation section for multi-dimensional arrays
2. Include common DP patterns as examples in the documentation
3. Clarify when to use `var.update` vs direct assignment for nested structures

---

## 2025-02-23 13:10 PST - Boolean Literals in Conditions

**What I was trying to do:** Use boolean literals (`true`/`false`) in conditional statements

**What the issue was:** I wasn't certain if XanoScript uses `true`/`false` or other syntax like `yes`/`no` or `1`/`0` for boolean values. The documentation mentions `bool` type but doesn't clearly show boolean literal examples in conditions.

**Why it was an issue:** Had to assume standard JavaScript-style `true`/`false` literals would work based on other examples. Without validation, this would be a guess.

**Potential solution (if known):**
1. Add a "Literals" section to the syntax documentation showing examples of:
   - Boolean literals: `true`, `false`
   - Null/empty: `null`, `empty`
   - String literals and escaping rules
   - Number literals (integers, decimals, scientific notation)

---

## 2025-02-23 13:12 PST - String Indexing Syntax

**What I was trying to do:** Access individual characters from a string using array-like indexing: `$input.s1[$i - 1]`

**What the issue was:** The documentation doesn't clearly specify if strings can be accessed like arrays using bracket notation, or if a filter like `substr` or `char_at` is required.

**Why it was an issue:** Had to assume array-like indexing works on strings based on pattern matching with other languages, but this wasn't confirmed by documentation.

**Potential solution (if known):**
1. Document string operations more thoroughly, including:
   - Character access via indexing
   - Substring operations
   - String length via `strlen` filter (this is documented but could be more prominent)
   - String manipulation filters

---
