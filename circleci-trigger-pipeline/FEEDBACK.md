# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 21:15 PST] - Input Field Syntax Confusion

**What I was trying to do:**
Create a function with optional input parameters that have default values, like `branch?="main"`.

**What the issue was:**
The validation kept failing with cryptic errors like:
- "Expecting --> { <-- but found --> '\n' <--"
- "Expecting: expecting at least one iteration which starts with one of these possible Token sequences"

The documentation showed syntax like:
```xs
input {
  text role?="user" {
    description = "Role, defaults to 'user'"
  }
}
```

But this didn't work. The issue was that input fields MUST have the braces `{}` with content inside them (like `description = "..."`), not just empty braces. Also, the default value syntax `?="main"` outside the braces combined with braces containing properties was causing parse errors.

**Why it was an issue:**
The documentation examples show the braces containing properties like `description`, but it wasn't clear that empty braces `{}` would cause a parse error. The error messages were cryptic and didn't point to the actual problem.

**Potential solution (if known):**
- The validation error messages should be more specific about what token was expected
- Documentation should clarify that `{}` must contain at least one property
- Consider allowing empty `{}` as a valid no-op

---

## [2026-02-15 21:20 PST] - Using Variables in Object Literals

**What I was trying to do:**
Create an object literal that includes a variable value:
```xs
var $payload {
  value = { branch: $branch }
}
```

**What the issue was:**
The parser doesn't allow variables directly inside object literal syntax. It expects literal values only.

**Why it was an issue:**
This is a common pattern in most languages - being able to interpolate variables into object literals. The error "Expected an expression but found '$branch'" was confusing because `$branch` IS an expression.

**Potential solution (if known):**
- Allow variables in object literal syntax (standard in most languages)
- OR provide clearer documentation that object literals can only contain literal values
- The workaround using `set` filter works but is less intuitive: `value = {}|set:"branch":$branch`

---

## [2026-02-15 21:25 PST] - Reserved Variable Name '$response'

**What I was trying to do:**
Create a variable named `$response` to hold the response data before returning it.

**What the issue was:**
Got error: "'$response' is a reserved variable name and should not be used as a variable."

**Why it was an issue:**
The quickstart documentation mentions "$response is a reserved word and cannot be used as a variable name" but it's easy to miss. When building a response object incrementally, it's natural to want to name it `$response`.

**Potential solution (if known):**
- Consider allowing `$response` as a local variable since it's scoped to the function
- OR provide a linter warning rather than a hard error
- The workaround is to use `$result_data` or similar instead

---

## [2026-02-15 21:30 PST] - Filter Parameter Syntax with Variables

**What I was trying to do:**
Use a variable as a parameter to the `set` filter:
```xs
value = {}|set:"branch":$branch
```

**What the issue was:**
The parser expected specific token types but found `$branch`. It seems filter parameters might need to be literals or expressions in backticks.

**Why it was an issue:**
The documentation shows: `{a:1}|set:"b":2` but doesn't clearly show using variables as the value parameter.

**Potential solution (if known):**
- Allow variables directly in filter parameters (more intuitive)
- Document that filter parameters that are variables need to be wrapped in backticks as expressions
- The workaround is: `value = {}|set:"branch": `$branch``

---

## General Observations

1. **Error messages could be more helpful** - Many errors say "Expecting: expecting at least one iteration which starts with one of these possible Token sequences" which is hard to parse.

2. **Documentation examples vs reality** - The documentation shows many shorthand syntaxes that don't actually work in practice, or have subtle requirements (like needing content in braces).

3. **The validate_xanoscript tool is invaluable** - Without being able to validate incrementally, this would have been nearly impossible. The quick feedback loop is great.

4. **The MCP documentation lookup is helpful** - Being able to query specific topics like `xanoscript_docs(topic="types")` was essential.
