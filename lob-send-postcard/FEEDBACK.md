# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-15 05:22 PST - Boolean Type Naming

**What I was trying to do:**
Define an optional boolean input parameter with a default value in a function.

**What the issue was:**
I used `boolean? use_test_mode?=true` but XanoScript expects `bool` not `boolean`.

**Why it was an issue:**
Many programming languages use `boolean` as the type name (JavaScript, Java, etc.), so this is an easy mistake to make. The validation error just said "Expecting `}` but found `boolean`" which wasn't very clear about what the actual problem was.

**Potential solution:**
- Accept both `bool` and `boolean` as aliases for the same type
- Or provide a clearer error message like "Unknown type 'boolean'. Did you mean 'bool'?"

---

## 2025-02-15 05:24 PST - `in` Operator Not Working in Preconditions

**What I was trying to do:**
Validate that a string input was one of several allowed values using the `in` operator inside a precondition:
```xs
precondition ($input.size in $valid_sizes) {
  error_type = "inputerror"
  error = "Invalid postcard size. Must be one of: 4x6, 6x9, 6x11"
}
```

**What the issue was:**
The parser gave a confusing error: "Expecting: one of these possible Token sequences... [in]... but found: 'in'". This suggests the `in` operator is recognized but not in this context, or the syntax is different than documented.

**Why it was an issue:**
The documentation lists `in` as a valid operator, but it doesn't work inside preconditions for array membership checking. I had to rewrite using a switch statement instead.

**Potential solution:**
- Clarify in the documentation where `in` can and cannot be used
- Provide a working example of array membership validation
- Consider adding an `includes` or `contains` filter for arrays that checks membership

---

## 2025-02-15 05:27 PST - `includes` Filter Doesn't Exist

**What I was trying to do:**
As an alternative to the `in` operator, I tried using `$valid_sizes|includes:$input.size` based on the filter naming patterns.

**What the issue was:**
The `includes` filter doesn't exist. The error was "Unknown filter function 'includes'".

**Why it was an issue:**
There's no straightforward way to check if a value exists in an array. The documentation shows `contains` for strings and `includes` for arrays in the operator table, but `includes` isn't available as a filter.

**Potential solution:**
- Add an `includes` filter for array membership: `$array|includes:$value`
- Or document the recommended pattern for array membership validation

---

## 2025-02-15 05:29 PST - Switch Case Syntax Requires Non-Empty Blocks

**What I was trying to do:**
Use a switch statement to validate the size parameter with empty case blocks for valid values:
```xs
switch ($input.size) {
  case ("4x6") { }
  case ("6x9") { }
  case ("6x11") { }
  default { ... }
}
```

**What the issue was:**
Empty case blocks `{ }` caused a parse error: "Expecting: expecting at least one iteration... but found: '}'"

**Why it was an issue:**
I had to add comments inside each empty case block to satisfy the parser. This is unintuitive since empty blocks should be valid for cases where you just want to fall through.

**Potential solution:**
- Allow empty case blocks
- Or document that each case must contain at least one statement

---

## 2025-02-15 05:20 PST - Documentation Discovery

**What I was trying to do:**
Find the correct syntax for various XanoScript constructs.

**What the issue was:**
The MCP provides good documentation through `xanoscript_docs`, but I had to call it multiple times with different topics (`run`, `types`, `syntax`, `functions`, `integrations`) to piece together the information needed.

**Why it was an issue:**
It took several iterations to find all the relevant documentation. Having a single comprehensive reference or better cross-linking between topics would help.

**Potential solution:**
- Consider adding a `topic=all` option that returns essential docs from all topics
- Or provide a "cheat sheet" topic with the most commonly needed syntax patterns

---

## General Observations

### Positive:
- The validation tool is very helpful and provides accurate line/column information
- The documentation is comprehensive when you find the right topic
- The MCP is responsive and well-structured

### Areas for Improvement:
1. **Error Messages**: Many errors could be more actionable (suggesting fixes rather than just stating what was expected)
2. **Type Aliases**: Accepting common type name variants (`boolean`/`bool`, `integer`/`int`) would reduce friction
3. **Array Membership**: A standard pattern for "value in array" validation is needed
4. **Quick Reference**: A single-page quick reference would be valuable for AI assistants working with XanoScript
