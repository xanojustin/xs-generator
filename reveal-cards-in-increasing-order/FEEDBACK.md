# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 18:35 PST] - Sort filter type syntax unclear

**What I was trying to do:** Sort an array of integers using the `|sort` filter

**What the issue was:** I wrote `$input.deck|sort:$$:int:true` following the documented pattern for sorting objects by property, but the parser rejected the bare `int` keyword.

**Why it was an issue:** The error message suggested using `"int"` instead of `integer`, but the documentation examples showed unquoted type names like `text` and `int`. It wasn't clear that type names in filter parameters need to be quoted strings.

**Potential solution:** The documentation for the `|sort` filter should clarify that the type parameter must be a quoted string (e.g., `"int"`, `"text"`) when sorting primitives, or the parser should accept bare type keywords for consistency with other parts of the syntax.

---

## [2026-02-27 18:37 PST] - "Expression should be wrapped in parentheses" error unclear

**What I was trying to do:** Write filter expressions that combine operations, like `$queue|slice:1:($queue|count - 1)` and `$queue|count > 0`

**What the issue was:** The parser rejected expressions that combined filters with arithmetic or comparison operators, even when parenthesized. The error message "An expression should be wrapped in parentheses when combining filters and tests" was repeated but didn't clearly explain what restructuring was needed.

**Why it was an issue:** I tried wrapping the expressions in parentheses as suggested (e.g., `($queue|count - 1)`), but this didn't resolve the error. It turned out that the solution was to completely restructure the code to use intermediate variables instead of inline expressions.

**Code that failed:**
```xs
value = $queue|slice:1:($queue|count - 1)
if ($queue|count > 0) {
value = $result|slice:($idx + 1):($result|count - $idx - 1)
```

**What actually worked:**
```xs
var $queue_count { value = $queue|count }
var $new_queue_count { value = $queue_count - 1 }
var $queue { value = $queue|slice:1:$new_queue_count }
```

**Potential solution:** 
1. The error message should suggest using intermediate variables rather than just "wrap in parentheses"
2. The documentation should clarify that filter parameters cannot contain expressions — only variables or literals
3. Consider allowing simple arithmetic in filter parameters for better ergonomics

---

## [2026-02-27 18:40 PST] - No array element assignment syntax

**What I was trying to do:** Update a specific index in an array (`$result[$idx] = $card`)

**What the issue was:** XanoScript doesn't appear to have direct array element assignment. I had to work around this by slicing the array into before/after parts and merging them with the new value.

**Why it was an issue:** This made the code much more verbose than necessary. A simple index assignment would have been cleaner.

**Workaround used:**
```xs
var $before { value = $result|slice:0:$idx }
var $after { value = $result|slice:($idx + 1):($result|count - $idx - 1) }
var $result { value = $before|merge:[$card]|merge:$after }
```

**Potential solution:** Add array element assignment syntax like `array.set $result { index = $idx value = $card }` or similar.

---

## [2026-02-27 18:42 PST] - MCP validate_xanoscript parameter naming

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple files

**What the issue was:** I initially used `files` as the parameter name, but the tool expects `file_paths`.

**Why it was an issue:** The error message only said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" — it didn't mention that `files` was incorrect. I had to look at the schema to find the right parameter name.

**Potential solution:** Either:
1. Accept `files` as an alias for `file_paths` for better usability
2. Update the error message to list invalid parameters that were provided

---

## General Feedback

The XanoScript documentation is comprehensive but could benefit from:
1. More examples of common patterns (sorting primitive arrays, array element updates)
2. Clearer error messages that suggest specific fixes
3. A "common pitfalls" or "migration from JavaScript" guide
