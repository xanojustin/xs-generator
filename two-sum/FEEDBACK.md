# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 13:35 PST] - Issue: Foreach with index syntax unclear

**What I was trying to do:** Iterate through an array with both the element value and its index using `each as $num, $index`

**What the issue was:** The validator returned `Expecting --> } <-- but found --> ','` at the comma in `each as $num, $index`

**Why it was an issue:** The documentation shows the syntax `each as $item, $index` as valid, but the parser rejected it. I had to work around this by using a manual counter variable.

**Potential solution:** Either the documentation needs updating, or the parser needs to support the documented syntax. Clearer error messages would help too.

---

## [2025-02-19 13:38 PST] - Issue: Object key check filter naming inconsistent

**What I was trying to do:** Check if an object has a specific key using `$obj|has_key:"key"`

**What the issue was:** The filter `has_key` doesn't exist. The correct filter is `has`.

**Why it was an issue:** I guessed `has_key` based on common naming conventions in other languages, but XanoScript uses `has`. The error message "Unknown filter function 'has_key'" was helpful, but I had to search through the documentation to find the correct filter name.

**Potential solution:** Consider aliasing `has_key` to `has` for better discoverability, or improve the error message to suggest the correct filter name.

---

## [2025-02-19 13:38 PST] - Issue: Dynamic object key syntax confusing

**What I was trying to do:** Set a dynamic key in an object using the merge syntax: `$obj|merge:{($key): $value}`

**What the issue was:** The syntax `($num|to_text): $index` inside an object literal caused a parse error: `Expecting: one of these possible Token sequences... but found: '('`

**Why it was an issue:** I was trying to construct an object with a computed key name. This is a common pattern in JavaScript and other languages. I had to discover the `set` filter instead.

**Potential solution:** Document the `set` filter more prominently for dynamic key operations. The `set` filter works well (`$obj|set:$key:$value`), but it's not immediately obvious that's the right approach.

---

## [2025-02-19 13:30 PST] - MCP Tool Working Well

**Positive feedback:** The `validate_xanoscript` tool was very helpful and provided clear, actionable error messages with line numbers and code snippets. This made debugging much faster than trial-and-error deployments.

**Suggestion:** The `file_paths` parameter worked correctly once I used the right JSON array format. Consider documenting the expected format more clearly in the tool description.

