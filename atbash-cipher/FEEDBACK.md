# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 21:35 PST] - Missing `ord` and `chr` filters

**What I was trying to do:** Implement the Atbash cipher using ASCII character code arithmetic (converting characters to their ASCII codes, performing math, then converting back)

**What the issue was:** XanoScript doesn't have `ord` (get character code) or `chr` (convert code to character) filters that are common in many programming languages

**Why it was an issue:** This made the straightforward algorithmic approach impossible. I had to pivot to a lookup table approach which is less elegant and more verbose

**Potential solution (if known):** 
- Add `ord` filter: `"a"|ord` → `97`
- Add `chr` filter: `97|chr` → `"a"`
- Or document alternative approaches for character manipulation in the essentials guide

---

## [2025-02-27 21:36 PST] - String indexing not available

**What I was trying to do:** Find the position of a character in a string (as an alternative to `ord`/`chr`)

**What the issue was:** No `index`, `strpos`, or similar filter exists to find the position of a substring/character within a string

**Why it was an issue:** Couldn't use a "find position in alphabet, then get character from reversed alphabet" approach

**Potential solution (if known):**
- Add `index` or `strpos` filter: `"hello"|index:"l"` → `2`
- Add `char_at` filter to get character at position: `"hello"|char_at:0` → `"h"`

---

## [2025-02-27 21:37 PST] - MCP validate_xanoscript tool works well

**What I was trying to do:** Validate XanoScript syntax

**What went well:** The validation tool provided clear, actionable error messages with line numbers and the problematic code

**Why it was helpful:** Immediately identified unknown filters and syntax issues, allowing quick iteration

**Suggestion:** The error messages are excellent - keep this format!
