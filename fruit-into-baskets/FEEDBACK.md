# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 11:35 PST] - Unknown filter function 'delete'

**What I was trying to do:** Implement the "Fruit Into Baskets" sliding window algorithm, which requires tracking fruit counts in a hash map and removing fruit types when their count reaches zero.

**What the issue was:** I attempted to use `$basket|delete:$left_key` to remove a key from an object/map when the count reached zero, but this filter doesn't exist in XanoScript.

**Error message:**
```
[Line 64, Column 47] Unknown filter function 'delete'
Code at line 64:
  var $basket { value = $basket|delete:$left_key }
```

**Why it was an issue:** In many programming languages, you can remove keys from objects/maps (JavaScript's `delete obj.key`, Python's `del dict[key]`, etc.). I assumed XanoScript would have similar functionality. Without a delete filter, I had to restructure my logic to:
1. Leave the key in the object with a count of 0
2. Track the number of active types separately with a counter
3. Check if count > 0 when determining if a type is "active"

This works but is less elegant than simply removing the key.

**Potential solution (if known):** 
- Add a `delete` or `remove` filter for objects: `$obj|delete:"key"` or `$obj|remove:"key"`
- Or document available object manipulation filters more clearly (the syntax quick reference only shows `get` and `set`)
- Consider adding `unset` as an alternative name since that's what PHP uses

---

## [2025-02-25 11:30 PST] - Documentation request

**What I was trying to do:** Understand how to structure a run job that calls a function.

**What the issue was:** The documentation from `xanoscript_docs` is very generic and didn't clearly show the pattern for:
1. How to write a run.job that calls a function
2. How to pass inputs to the function
3. The exact syntax for `function.run` or equivalent

**Why it was an issue:** I had to look at existing examples in the `~/xs/` directory to understand the pattern. The `run.xs` file syntax wasn't documented in the topics I checked (`quickstart`, `syntax`, `functions`, `run`).

**Potential solution (if known):** 
- Add a specific documentation topic or example for "Run Jobs calling Functions"
- Include the pattern: `run.job { main = { name: "function_name", input: { ... } } }`
- The existing examples in the exercise repo are helpful - maybe reference them in docs
