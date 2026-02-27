# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 09:05 PST] - get_keys filter doesn't exist

**What I was trying to do:** Get the keys from an object created by `index_by` to iterate over unique characters

**What the issue was:** I assumed there was a `get_keys` filter based on common programming patterns, but XanoScript only has `keys`

**Why it was an issue:** The validation error was clear but I had to search documentation to find the correct filter name. Common naming conventions vary between languages (Object.keys() in JS, .keys() in Python, etc.)

**Potential solution:** A more detailed "Common filter mappings" table in the docs showing what XanoScript filters correspond to in other languages (JS, Python, PHP)

---

## [2026-02-27 09:08 PST] - Sort filter field names must be quoted strings

**What I was trying to do:** Sort an array of objects by a field using `$array|sort:field:type:direction`

**What the issue was:** I wrote `sort:char:text:true` but XanoScript requires quoted field names: `sort:"char":"text":true`

**Why it was an issue:** The quick_reference documentation shows the example `[{n:"z"},{n:"a"}]|sort:n:text:false` which looks like unquoted field names. This is misleading because `n` there is the literal value being sorted, not a reference.

**Potential solution:** 
1. Update the quick_reference example to use quoted strings: `sort:"n":"text":false`
2. Add a note explaining that field names must be quoted strings, not bare identifiers

---

## [2026-02-27 09:10 PST] - run.job only supports 'main', not 'stack' blocks

**What I was trying to do:** Create a run.job that tests multiple test cases using `function.run` calls within a `stack` block

**What the issue was:** The cron instructions say "run.xs — A run.job that uses function.run to call the solution function" which implies using `function.run` syntax, but run.job only supports the `main = { name: "...", input: {...} }` syntax

**Why it was an issue:** There's a mismatch between the cron instructions and what XanoScript actually supports. I tried to use a `stack` block with multiple `function.run` calls but got the error: "The argument 'stack' is not valid in this context"

**Potential solution:**
1. Clarify the cron instructions to match the actual pattern used in the repo (single `main` test case)
2. OR consider adding support for `stack` blocks in run.job for more complex test scenarios

---

## [2026-02-27 09:12 PST] - No repeat/str_repeat filter for strings

**What I was trying to do:** Repeat a character N times to build the result string (e.g., 'a' repeated 3 times = 'aaa')

**What the issue was:** XanoScript has no `repeat` or `str_repeat` filter. I had to use a while loop with `array.push` to build an array of repeated characters, then `join:""` to combine them.

**Why it was an issue:** String repetition is a common operation. The workaround (while loop + array.push + join) is verbose and less readable.

**Potential solution:** Add a `repeat` filter for strings: `"a"|repeat:3` → `"aaa"`. Or for arrays: `["a"]|repeat:3` → `["a","a","a"]`

---

## [2026-02-27 09:15 PST] - Documentation discovery is time-consuming

**What I was trying to do:** Find the correct syntax for various operations (sort, object keys, array building)

**What the issue was:** I had to make multiple calls to `xanoscript_docs` with different topics to piece together the information needed. The quick_reference mode is helpful but sometimes lacks crucial details (like quoting requirements).

**Why it was an issue:** Each documentation call takes time and tokens. A single "XanoScript by Example" document with common patterns would be more efficient.

**Potential solution:** 
1. Create a comprehensive "XanoScript Cookbook" topic with common patterns for:
   - Counting frequencies
   - Sorting by multiple criteria
   - Building strings character by character
   - Transforming data structures

---

## [2026-02-27 09:18 PST] - Map filter syntax unclear for object creation

**What I was trying to do:** Initially tried to use `map` to transform keys into objects: `$keys|map:{ char: $$, count: ... }`

**What the issue was:** The map syntax in XanoScript wasn't clear from the documentation. The quick_reference shows basic examples like `map:$$.field` but not complex object creation within map.

**Why it was an issue:** I ended up using a `foreach` loop with `array.push` instead, which is more verbose but clearer.

**Potential solution:** Add examples showing complex map operations, or clarify when to use `foreach` vs `map`.
