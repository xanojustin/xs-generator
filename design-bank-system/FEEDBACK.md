# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-28 05:38 PST - Object literal syntax confusion

**What I was trying to do:** Create a nested object literal to store account data with structure like `{ "1": { balance: 1000 }, ... }`

**What the issue was:** My first attempt used incorrect syntax:
```xs
var $accounts { 
  value = {
    1: { balance: 1000 },
    2: { balance: 500 }
  }
}
```

The validation error was:
```
[Line 17, Column 15] Expecting: Expected an expression but found: '{'
```

This was confusing because the error pointed to the `{` after `value =`, suggesting the entire object literal syntax was wrong, when actually the issue was likely the numeric keys or nested object structure.

**Why it was an issue:** The error message didn't clearly explain that:
1. Object keys should be quoted strings, not bare numbers
2. Or that the object syntax was actually valid but something else was wrong

I eventually found the correct pattern by looking at existing examples, but the error wasn't helpful.

**Potential solution:** Better error messages for object literal syntax that distinguish between:
- Invalid key types (numeric vs string)
- Invalid nested object syntax
- Missing/extra commas or braces

---

## 2025-02-28 05:42 PST - Object access patterns unclear

**What I was trying to do:** Access and modify nested object properties like `$accounts["1"].balance`

**What the issue was:** I initially tried using bracket notation and dot notation like JavaScript:
```xs
$accounts[$input.account_id|to_text].balance
```

But this syntax doesn't work in XanoScript. I had to discover that I needed to use `get` and `set` filters:
```xs
$accounts|get:$account_key|get:"balance"
$accounts|set:$account_key:$account_obj
```

**Why it was an issue:** The syntax documentation showed the existence of `get` and `set` filters but didn't clearly explain the use case for nested object manipulation. Coming from JavaScript/Python, bracket/dot notation is intuitive, but XanoScript requires a completely different approach.

**Potential solution:** 
1. Add a dedicated "Object Manipulation" section to the docs with examples of:
   - Creating nested objects
   - Reading nested properties
   - Updating nested properties
2. Include a comparison table showing "If you're used to JS/Python syntax X, use XanoScript syntax Y"

---

## 2025-02-28 05:45 PST - Chained set filter syntax discovery

**What I was trying to do:** Update two different keys in an object (transferring between accounts)

**What the issue was:** I needed to figure out the correct syntax for chaining `set` operations. After trial and error, I found this works:
```xs
$accounts|set:$account_key:$from_account_obj|set:$target_key:$to_account_obj
```

But it wasn't immediately clear if I needed intermediate variables or if chaining was supported.

**Why it was an issue:** The documentation mentions filter chaining but doesn't show complex examples with multiple `set` operations.

**Potential solution:** Add examples showing:
1. How to update multiple properties in an object
2. How to chain multiple `set` operations
3. When to use intermediate variables vs chaining
