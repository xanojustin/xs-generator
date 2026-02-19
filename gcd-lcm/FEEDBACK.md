# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 23:35 PST] - Object literal syntax unclear

**What I was trying to do:** Create an object literal to return both GCD and LCM values from the function

**What the issue was:** I initially wrote `{gcd = 0, lcm = 0}` using `=` for property assignment, but XanoScript requires `:` for object property assignment like `{gcd: 0, lcm: 0}`

**Why it was an issue:** The documentation doesn't clearly show examples of object literal syntax. The error message was helpful ("Expecting --> : <-- but found --> = <--") but I had to guess that object literals were even supported.

**Potential solution:** Add a clear example of object literal syntax in the quickstart or types documentation. Something like:
```xs
var $obj {
  value = {
    key1: "value1"
    key2: 123
  }
}
```

---

## [2026-02-18 23:38 PST] - Ternary operator not supported

**What I was trying to do:** Calculate absolute value using a ternary operator: `($input.a < 0) ? (-$input.a) : $input.a`

**What the issue was:** XanoScript doesn't support the ternary operator (`?:`) syntax that's common in many languages

**Why it was an issue:** Ternary operators are a standard way to write concise conditional expressions. I had to rewrite using verbose `conditional { if ... else ... }` blocks which made the code longer and more nested.

**Potential solution:** 
1. Add ternary operator support to XanoScript: `$var = ($condition) ? $if_true : $if_false`
2. OR add a dedicated `abs` filter: `$input.a|abs`
3. OR clearly document that ternary is not supported in the "Common Mistakes" section

---

## [2026-02-18 23:40 PST] - Unary negation not supported

**What I was trying to do:** Negate a variable using unary minus: `-$input.a`

**What the issue was:** XanoScript doesn't support unary negation syntax. Writing `-5` works (literal), but `-$var` doesn't.

**Why it was an issue:** This is standard syntax in virtually every programming language. I had to use the workaround `0 - $input.a` which is unintuitive.

**Potential solution:**
1. Add unary negation support to XanoScript
2. OR add an `abs` filter for absolute value which is a very common operation
3. OR document the `0 - $var` workaround in the syntax documentation

---

## [2026-02-18 23:42 PST] - MCP tool parameter format confusing

**What I was trying to do:** Call the `validate_xanoscript` tool with JSON parameters

**What the issue was:** The tool description shows JSON format like `{"file_path": "/path/to/file"}` but mcporter requires `key=value` format like `file_path="/path/to/file"`

**Why it was an issue:** I wasted several attempts trying different JSON formats before realizing the mcporter CLI uses a different parameter syntax than the documented TypeScript/JavaScript API.

**Potential solution:** 
1. Update the tool description to show mcporter CLI examples alongside the TypeScript examples
2. OR accept JSON format via mcporter as well

Example for the docs:
```
# TypeScript/JS API:
validate_xanoscript({ file_path: "/path/to/file.xs" })

# mcporter CLI:
mcporter call xano validate_xanoscript file_path="/path/to/file.xs"

# Or for directory:
mcporter call xano validate_xanoscript directory="/path/to/dir"
```

---

## General Observation: Lack of Comprehensive Syntax Examples

The XanoScript documentation provides good high-level concepts but lacks comprehensive syntax examples for:
- Object literals (how to create them, property syntax)
- All supported operators (arithmetic, comparison, logical)
- What's NOT supported (ternary, unary operators, etc.)
- Expression syntax limitations

A "Complete Syntax Reference" or "Language Grammar" document would be incredibly helpful for developers writing XanoScript code.
