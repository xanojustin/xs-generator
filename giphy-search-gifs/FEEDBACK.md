# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-15 10:47 PST - MCP Tool Call Syntax with Multi-line Code

**What I was trying to do:**
Validate XanoScript code using the `validate_xanoscript` MCP tool. The code contained newlines and quotes that needed proper escaping.

**What the issue was:**
The `mcporter call` command with direct arguments failed when passing multi-line code through shell expansion. My initial attempts like:
```bash
cat file.xs | mcporter call xano.validate_xanoscript --args '{"code":"'"..."'"}'
```
Resulted in parse errors because newlines were stripped and quotes weren't escaped properly.

**Why it was an issue:**
The validation tool kept returning "Expected a comma, a new line or closing bracket" errors because the code was being mangled in the shell command. This made it very difficult to debug whether the issue was my XanoScript syntax or the command invocation.

**Potential solution (if known):**
- The MCP server could accept a file path parameter instead of requiring inline code
- Better documentation on the proper way to pass multi-line strings via mcporter
- A stdin option for the validate tool would be helpful: `cat file.xs | mcporter call xano.validate_xanoscript code=-`

**Workaround that eventually worked:**
```bash
CODE=$(cat file.xs) && mcporter call xano.validate_xanoscript --args "$(jq -n --arg code "$CODE" '{code: $code}')"
```

---

## 2026-02-15 10:49 PST - Array Membership Checking Syntax

**What I was trying to do:**
Check if a value exists in an array of valid options (validating the `rating` input against `["g", "pg", "pg-13", "r"]`).

**What the issue was:**
I initially tried `$valid_ratings contains $input.rating` which is intuitive but invalid. The validator returned: "Expecting: one of these possible Token sequences... but found: 'contains'"

**Why it was an issue:**
The syntax documentation shows `contains` as a filter for arrays (`$db.tags|contains:"featured"`), but I incorrectly assumed it could also be used as an infix operator like in other languages. The distinction between filter syntax (`|contains:value`) and expression operators wasn't immediately clear.

**Potential solution (if known):**
- A quick reference section specifically for "checking if value is in array" would help
- More examples showing common validation patterns
- Perhaps support for `$value in $array` syntax for better readability

**Workaround that worked:**
Used a `conditional` block with explicit equality checks:
```xs
conditional {
  if ($input.rating == "g") { var $rating { value = "g" } }
  elseif ($input.rating == "pg") { var $rating { value = "pg" } }
  // ... etc
}
```

---

## 2026-02-15 10:51 PST - Inline Conditional Expression Syntax

**What I was trying to do:**
Use a conditional block inline to assign a value based on conditions, similar to Python's conditional expressions or JavaScript's ternary operator.

**What the issue was:**
I tried:
```xs
var $rating {
  value = conditional {
    if ($input.rating == "g") { "g" }
    elseif (...) { ... }
  }
}
```

This gave: "Expected an expression but found: 'conditional'"

**Why it was an issue:**
The documentation shows conditional blocks can return values when used as expressions, but the syntax wasn't clear about whether they need backticks, different wrapping, or if the return values in braces need `return` statements.

**Potential solution (if known):**
- Clearer documentation on when conditional blocks can be used as expressions vs statements
- Examples showing both patterns: conditional as statement block vs conditional as value expression
- Clarification on whether `return { value = ... }` is needed inside conditional branches when used as expression

**Workaround that worked:**
Used a statement-level `conditional` block with explicit `var $rating { value = ... }` assignments inside each branch.

---

## General Observations

1. **Documentation organization**: The quick reference mode is helpful, but some common patterns (array membership, validation) are scattered across different topic sections.

2. **Error messages**: The validation error messages are generally helpful with line/column numbers, but sometimes the "Expecting one of these tokens" lists are very long and don't highlight the most likely intended syntax.

3. **Filter vs Operator confusion**: There's a learning curve around when to use `|` filters vs inline operators. More side-by-side comparisons would help.

4. **Validation workflow**: Having to escape and pass code through jq for multi-line validation is clunky. A file-based validation option would be much smoother for development workflows.
