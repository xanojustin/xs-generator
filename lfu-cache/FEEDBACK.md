# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 03:38 PST] - var.update with index parameter not supported

**What I was trying to do:** Update a specific element in an array at a given index (e.g., `$frequencies[$index] = $new_value`)

**What the issue was:** I assumed I could use `var.update $array { index = $idx value = $new_value }` syntax, similar to array index assignment in other languages. The validator returned:
```
[Line 55, Column 19] The argument 'index' is not valid in this context
```

**Why it was an issue:** Array element updates are a common operation. Without index-based updates, I had to manually reconstruct the entire array using foreach loops, which is verbose and less efficient.

**Potential solution (if known):** 
- Document that `var.update` doesn't support index-based updates
- Consider adding a `var.update_at_index` operation or similar
- Or add a `set` filter that works on arrays: `$array|set:$index:$new_value`

---

## [2026-02-24 03:38 PST] - JSON array parameter format unclear

**What I was trying to do:** Call the validate_xanoscript tool with multiple file paths

**What the issue was:** The initial attempt `file_paths="[/Users/.../run.xs,/Users/.../lfu_cache.xs]"` caused the MCP to split the string character by character, resulting in 100 "files" being validated (each character was treated as a separate file path).

**Why it was an issue:** The error messages were confusing - it was looking for files named "U", "s", "e", "r", etc. It took multiple attempts to figure out the correct format.

**Potential solution (if known):**
- Document that JSON array parameters must be passed via `--args` flag with proper JSON
- Example: `mcporter call xano.validate_xanoscript --args '{"file_paths":["/path/1.xs","/path/2.xs"]}'`

---

## [2026-02-24 03:40 PST] - No array index assignment syntax documented

**What I was trying to do:** Find documentation on how to update an array element at a specific index

**What the issue was:** After searching through the xanoscript_docs topics (quickstart, functions, syntax), I couldn't find any clear documentation on how to perform indexed array updates.

**Why it was an issue:** I had to resort to array reconstruction patterns (creating a new array and copying elements one by one) which is inefficient and verbose.

**Potential solution (if known):**
- Add explicit documentation about array manipulation patterns
- Include examples of how to update, insert, or delete elements at specific indices
- Consider adding convenience filters like `$array|update_at:$index:$value`
