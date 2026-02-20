# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 13:35 PST] - Missing Common Array Filters

**What I was trying to do:** Check if a word exists in a word list (array membership test)

**What the issue was:** Common array filters like `array_flip`, `array_search`, `in_array` don't exist in XanoScript. I had to resort to manual foreach loops to check if an element exists in an array.

**Why it was an issue:** This makes the code much more verbose and less efficient. A simple membership test requires 5+ lines of code instead of one filter.

**Potential solution (if known):** 
- Add `array_search` or `in_array` filter that returns boolean or index
- Add `array_flip` to convert array to object for O(1) lookups
- Document the recommended pattern for array membership testing

---

## [2025-02-20 13:37 PST] - Comment Parsing Issues

**What I was trying to do:** Add inline comments to explain code (e.g., `var $char_code { value = 97 }  // 'a'`)

**What the issue was:** Comments at the end of a line inside expression blocks cause parse errors. The error message was confusing - it said "expecting at least one iteration" and pointed to the `/` character in the comment.

**Why it was an issue:** This is unexpected behavior since most languages allow end-of-line comments. The error message doesn't clearly indicate that comments are the problem.

**Potential solution (if known):**
- Either support end-of-line comments within expression blocks
- Or improve the error message to say "Comments not allowed in expression context"
- Document this limitation clearly in the syntax docs

---

## [2025-02-20 13:38 PST] - Unknown Filters for Character Operations

**What I was trying to do:** Convert ASCII code (int) to character (text) using a `chr` filter

**What the issue was:** No `chr` filter exists. Common text filters like `chr`, `ord`, `sprintf` are missing.

**Why it was an issue:** Had to hardcode the entire alphabet as an array `["a", "b", "c", ...]` and iterate over it instead of generating characters from ASCII codes.

**Potential solution (if known):**
- Add `chr` filter to convert int to character
- Add `ord` filter to convert character to int (ASCII code)
- Add `sprintf` or `format_text` with %c support for character formatting

---

## [2025-02-20 13:40 PST] - Dynamic Object Key Syntax Unclear

**What I was trying to do:** Create an object with a dynamic key: `{ ($variable): value }`

**What the issue was:** This syntax caused a parse error. It's unclear what the correct syntax is for setting object keys dynamically.

**Why it was an issue:** Had to use the `set` filter instead, which is less intuitive: `$obj|set:$variable:value`

**Potential solution (if known):**
- Document the `set` filter pattern clearly for dynamic keys
- Or support JavaScript-style computed property syntax if that's the intended direction

---

## [2025-02-20 13:42 PST] - Filter Discovery Difficult

**What I was trying to do:** Find out what filters exist in XanoScript

**What the issue was:** No easy way to discover available filters. Had to guess and check via validation errors.

**Why it was an issue:** Trial-and-error validation is slow and frustrating. Common filters from PHP/other languages don't exist, and there's no comprehensive list to reference.

**Potential solution (if known):**
- Add an MCP tool to list all available filters with descriptions
- Or add a `xanoscript_docs` topic specifically for filters
- Include a filter reference in the syntax documentation
