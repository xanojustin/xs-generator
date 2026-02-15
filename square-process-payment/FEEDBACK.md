# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-15 03:47 PST - Conditional Inside Value Assignment Not Allowed

**What I was trying to do:**
Create a conditional expression inside a variable value assignment to generate different values based on a condition. I wanted to use the `conditional` block as an expression to return values inline.

**What the issue was:**
I initially wrote code like:
```xs
var $idempotency {
  value = conditional {
    if ($input.idempotency_key != "") { $input.idempotency_key }
    else { "xano-" ~ (|uuid) }
  }
}
```

The validator returned:
```
[Line 13, Column 15] Expecting: Expected an expression but found: 'conditional'
```

**Why it was an issue:**
This blocked me because the documentation shows `conditional` being used as an expression that returns values:
```xs
var $tier_limit {
  value = conditional {
    if ($auth.tier == "premium") { 1000 }
    elseif ($auth.tier == "pro") { 500 }
    else { 100 }
  }
}
```

I expected this pattern to work for my use case, but it seems `conditional` as an expression may only work in certain contexts or the documentation example may not be fully accurate.

**Potential solution (if known):**
The workaround was to use `var` with a default value, then use a separate `conditional` block with `var.update` to change the value conditionally:

```xs
var $idempotency { value = $input.idempotency_key }
conditional {
  if ($input.idempotency_key == "") {
    var.update $idempotency { value = "xano-" ~ (|uuid) }
  }
}
```

The documentation could clarify:
1. Whether `conditional` as an expression is supported in all contexts
2. The recommended pattern for conditional variable initialization

---

## 2025-02-15 03:50 PST - Documentation Unclear on Conditional Expression Usage

**What I was trying to do:**
Understand the exact syntax rules for using `conditional` blocks as expressions versus statements.

**What the issue was:**
The syntax documentation shows two patterns:
1. `conditional` as a statement block for if/elseif/else logic
2. `conditional` as an expression that returns values

But it's unclear when each pattern is valid. The expression pattern appears in the documentation but didn't work in my variable value assignment.

**Why it was an issue:**
I had to rewrite working code multiple times to find a pattern that validated successfully. This slowed down development and created uncertainty about whether I was writing "correct" XanoScript.

**Potential solution (if known):**
The syntax documentation could include:
1. Clear rules about where expression-pattern `conditional` blocks are valid
2. More examples showing both statement and expression patterns side by side
3. A note explaining if expression patterns require specific XanoScript versions

---

## 2025-02-15 03:52 PST - Environment Variable Syntax in $env

**What I was trying to do:**
Access environment variables using the `$env` syntax for conditional logic.

**What the issue was:**
Initially unclear if I should use `$env.SQUARE_ENVIRONMENT` or `$env["SQUARE_ENVIRONMENT"]` or some other syntax.

**Why it was an issue:**
Had to infer from documentation examples that dot notation (`$env.VAR_NAME`) is the correct approach.

**Potential solution (if known):**
Add a small section to the syntax or types documentation explicitly showing environment variable access patterns with examples like:
```xs
var $api_key { value = $env.API_KEY }
conditional {
  if ($env.ENVIRONMENT == "production") { ... }
}
```

---

## General Feedback

### Positive
- The `validate_xanoscript` tool is very helpful for catching syntax errors quickly
- Documentation is comprehensive and well-organized by topic
- Error messages include line and column numbers which is excellent

### Suggestions
1. **More inline code examples** - Some concepts (like conditional expressions) could use more real-world examples
2. **Common patterns section** - A "cookbook" of common patterns (conditional initialization, error handling, etc.) would be valuable
3. **Version notes** - If expression-pattern conditionals require a specific version, document that