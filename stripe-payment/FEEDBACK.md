# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 08:20 PST] - Comment Syntax at File Start

**What I was trying to do:**
Create a XanoScript run job with comments at the top of the file explaining what it does.

**What the issue was:**
The validator rejected files that started with comments (`//`). The error was:
```
[Line 3, Column 1] Expecting --> function <-- but found --> '
' <--
```

**Why it was an issue:**
This was confusing because most programming languages allow comments at the start of files. I had to remove all the helpful header comments from my `.xs` files to make them validate.

**Potential solution (if known):**
Either allow comments at the start of files, or document this restriction clearly in the quickstart guide. The error message could also be more helpful - saying "Comments are not allowed before the construct declaration" would be clearer.

---

## [2026-02-16 08:22 PST] - function.run Syntax Confusion

**What I was trying to do:**
Call one function from another function using `function.run`.

**What the issue was:**
I initially wrote:
```xs
function.run {
  name = "create_stripe_customer"
  input = { ... }
}
```

But the correct syntax is:
```xs
function.run "create_stripe_customer" {
  input = { ... }
}
```

**Why it was an issue:**
The documentation shows the correct syntax, but it's easy to miss. The error message was:
```
Expecting: one of these possible Token sequences:
  1. [Identifier]
  2. ["..."]
but found: '{'
```

This wasn't very clear about what I was doing wrong.

**Potential solution (if known):**
Add a specific error message for when `function.run` is used without a quoted name, like: "function.run requires a function name in quotes immediately after the keyword, e.g., function.run 'my_function' { ... }"

---

## [2026-02-16 08:25 PST] - db.add Requires Inline Object

**What I was trying to do:**
Store data to a table using a variable that was built up earlier in the stack.

**What the issue was:**
I tried to use a variable in `db.add`:
```xs
var $charge_record { value = { ... } }
db.add "payment" {
  data = $charge_record
}
```

But `db.add` only accepts inline objects for `data`. The error was:
```
Expecting: Expected an object {}
but found: '$charge_record'
```

**Why it was an issue:**
The error message says it expected an object but found a variable. It wasn't clear that `db.add` specifically requires inline syntax while `db.patch` accepts variables. I had to refactor to put the object literal directly in the `db.add` call.

**Potential solution (if known):**
1. Improve the error message to say something like: "db.add requires an inline object for 'data'. Use db.patch if you need to pass a variable."
2. Or consider allowing variables in db.add for consistency with db.patch.

---

## [2026-02-16 08:27 PST] - Documentation Discovery

**What I was trying to do:**
Find the correct syntax for various operations.

**What the issue was:**
The `xanoscript_docs` tool is great but has a lot of topics. It took several calls to find the right documentation for specific issues (functions vs database vs quickstart).

**Why it was an issue:**
While the docs are comprehensive, finding the exact piece of information needed required multiple calls. For example, I needed to check:
1. `quickstart` for common patterns
2. `functions` for function.run syntax  
3. `database` for db.add vs db.patch difference

**Potential solution (if known):**
Consider adding a search capability to xanoscript_docs or a "common errors" topic that lists frequent mistakes and their solutions. This would help developers quickly find fixes without reading entire doc sections.

---

## [2026-02-16 08:28 PST] - GitHub Push Race Condition

**What I was trying to do:**
Push the new run job to GitHub.

**What the issue was:**
There was a commit on the remote that I didn't have locally (likely from a previous cron job or concurrent work).

**Why it was an issue:**
Had to pull and rebase before pushing. This could be problematic if there are merge conflicts in XanoScript files.

**Potential solution (if known):**
Not really an MCP/XanoScript issue, but for automated job generation, it might be worth documenting the workflow. Or the system could auto-pull before committing to avoid this.

---

## Summary

Overall, the Xano MCP validation tool is very helpful and caught several issues before they would have caused runtime errors. The main friction points were:

1. **Error messages** - Could be more specific about what's wrong and how to fix it
2. **File comment restrictions** - Not obvious that comments can't precede the construct
3. **Inconsistent data parameter handling** - db.add vs db.patch behavior differs

The documentation is comprehensive but could benefit from a "Common Gotchas" section that lists these specific pitfalls.
