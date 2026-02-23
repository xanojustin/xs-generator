# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 02:05 PST] - Filter expression parentheses requirement

**What I was trying to do:** Write a precondition to check if the tasks array is not empty.

**What the issue was:** The code `precondition ($input.tasks|count > 0)` fails validation with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The filter `|` binds greedily to the left, so `$input.tasks|count > 0` is parsed as `$input.tasks | (count > 0)` which treats `count > 0` as a filter argument. This is unexpected behavior coming from other languages.

**Potential solution (if known):** The documentation does explain this, but it's an easy mistake to make. The MCP validation error message is helpful. Perhaps the quickstart could highlight this as one of the top 3 common mistakes.

---

## [2026-02-23 02:15 PST] - Dynamic object key assignment not supported

**What I was trying to do:** Build a frequency map where task names are keys and counts are values: `var $frequency_map[$task] { value = 1 }`

**What the issue was:** XanoScript doesn't support dynamic object key assignment using bracket notation. The parser expects an identifier, not `[`.

**Why it was an issue:** This is a very common pattern in programming (building a map/dictionary with dynamic keys). I had to discover the `set` and `get` filters from the syntax documentation to work around this.

**Potential solution (if known):** The `set` and `get` filters work but are verbose. Consider:
1. Adding explicit documentation about this limitation in the functions or types topic
2. Supporting bracket notation for object property access/assignment would be more intuitive

---

## [2026-02-23 02:20 PST] - Dynamic array indexing not supported

**What I was trying to do:** Update an array element at a specific index: `var $task_counts[$found_index] { value = $task_counts[$found_index] + 1 }`

**What the issue was:** Similar to objects, dynamic array indexing in variable declarations is not supported.

**Why it was an issue:** I tried using parallel arrays as a workaround for the object key issue, but hit the same limitation with arrays. Had to completely rethink the approach.

**Potential solution (if known):** Document clearly what patterns ARE supported for dynamic access. The `set`/`get` filters work for objects but there's no equivalent for arrays. I had to switch back to objects.

---

## [2026-02-23 02:25 PST] - No object.keys() or similar iteration method

**What I was trying to do:** Iterate over the keys of the frequency_map object to find max frequency.

**What the issue was:** There's no `keys()` method or way to iterate over object properties directly.

**Why it was an issue:** Had to work around by iterating over the original tasks array and tracking which tasks I've already seen with a separate `$seen_tasks` array.

**Potential solution (if known):** Add an `object.keys()` filter or allow `foreach ($object)` to iterate over keys.

---

## [2026-02-23 02:30 PST] - MCP server installation/usage confusion

**What I was trying to do:** Call `xanoscript_docs` using `mcporter call @xano/developer-mcp xanoscript_docs`.

**What the issue was:** Got "Unknown MCP server '@xano/developer-mcp'" error. Had to use `mcporter config list` to discover it was already configured as "xano".

**Why it was an issue:** The cron prompt said to call `xanoscript_docs` on the Xano MCP but didn't specify the configured server name. Had to troubleshoot.

**Potential solution (if known):** The cron prompt could say "call xanoscript_docs using your configured Xano MCP server" or provide the exact mcporter command format.
