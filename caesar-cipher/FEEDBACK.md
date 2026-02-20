# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 01:35 PST] - File path array parsing issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths.

**What the issue was:** The MCP tool parsed the comma-separated string character-by-character instead of as an array of strings. Passing `file_paths=/Users/justinalbrecht/xs/caesar-cipher/run.xs,/Users/justinalbrecht/xs/caesar-cipher/function/caesar-cipher.xs` resulted in 110 "files" being validated, each being a single character from the paths.

**Why it was an issue:** This made the `file_paths` parameter unusable. Had to switch to using the `directory` parameter instead, which worked fine.

**Potential solution:** The MCP should accept proper JSON arrays or properly parse comma-separated values. Alternatively, document that `directory` is the preferred approach for multiple files.

---

## [2026-02-20 01:40 PST] - Missing char code filters

**What I was trying to do:** Implement Caesar cipher by converting characters to ASCII codes, shifting, and converting back.

**What the issue was:** I assumed filters like `to_char_code` and `from_char_code` existed (common in many languages), but they don't exist in XanoScript.

**Why it was an issue:** Had to rewrite the algorithm to use alphabet array mapping instead, which is less efficient but works. The documentation doesn't clearly list what filters DON'T exist.

**Potential solution:** 
1. Add `to_char_code` / `from_char_code` filters (or `ord` / `chr`) - these are very useful for string manipulation
2. Or provide a clear "common filters from other languages that DON'T exist" section in docs
3. The quick_reference mode showed syntax but not available filters - a filter reference would help

---

## [2026-02-20 01:42 PST] - Finding similar implementations required manual exploration

**What I was trying to do:** Find the correct pattern for iterating over string characters.

**What the issue was:** Had to manually read existing exercise files (`count-vowels`) to understand the pattern of using `substr` with a loop index.

**Why it was an issue:** No obvious "string manipulation" or "character operations" section in the quick reference.

**Potential solution:** 
1. Add common patterns section: "Iterating over strings", "Array lookup", etc.
2. The `file_path` parameter in `xanoscript_docs` is supposed to return context-aware docs, but I didn't discover this until later

---

## General Observations

1. **Validation is excellent** - The validator caught issues immediately with clear line/column numbers
2. **Directory-based validation works well** - Using `directory` parameter was smooth
3. **MCP tools are discoverable** - `mcporter list xano --schema` gave clear tool definitions
