# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 05:33 PST] - Object delete filter doesn't exist

**What I was trying to do:** Remove a key from an object to implement the "delete customer from check-ins after checkout" functionality

**What the issue was:** I initially tried to use `$check_ins|delete:$customer_key` which resulted in the error:
```
[Line 96, Column 30] Unknown filter function 'delete'
```

**Why it was an issue:** The XanoScript documentation in the essentials/quick reference shows object filters like `get`, `set`, and `has`, but doesn't mention a `delete` filter. I assumed it existed based on common patterns in other languages, but it doesn't.

**Potential solution (if known):** 
- Add a `delete` filter for objects to the language (returns new object without the key)
- Or document the recommended pattern for removing entries from objects (e.g., using `filter` on object keys or using array-based storage instead)

**Workaround used:** Switched from object-based storage to array-based storage, then used `filter` to exclude entries:
```xs
var $filtered_checkins {
  value = $check_ins|filter:$$.customer_id != $input.customer_id
}
```

---

## [2026-03-01 05:35 PST] - Documentation discovery for object filters

**What I was trying to do:** Find all available object filters to understand what's possible

**What the issue was:** The quick reference documentation shows `get`, `set`, and `has` for objects, but I wasn't sure if there were more. I had to guess based on common patterns.

**Why it was an issue:** Without knowing all available filters, I tried to use `delete` which doesn't exist. The error message was helpful (told me exactly what line/column), but I had to rewrite my approach.

**Potential solution (if known):** 
- Include a complete list of object-specific filters in the quick reference
- Or suggest a topic I can query to get the full list of object manipulation options

---

## [2026-03-01 05:30 PST] - MCP worked well overall

**Positive feedback:** The `validate_xanoscript` tool was very helpful and fast. The error messages include line and column numbers which made fixing issues easy. The `xanoscript_docs` tool provided good syntax guidance.