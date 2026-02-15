# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-14 21:50 PST - Quote Encoding Issues with MCP Call

**What I was trying to do:**
Validate XanoScript files using the MCP `validate_xanoscript` tool via the mcporter CLI.

**What the issue was:**
When passing code to the validate tool using `mcporter call xano.validate_xanoscript code="$(cat file.xs)"`, the quotes in the file content were getting mangled/converted to fancy quotes, causing validation to fail with errors like:
```
Expecting --> run <-- but found --> '' <--
```

**Why it was an issue:**
This blocked validation completely. I had to resort to using Node.js to call the MCP server directly via stdio with proper JSON encoding to make it work.

**Potential solution:**
The mcporter CLI should handle proper escaping of shell arguments, or provide a `--file` parameter to read code directly from a file path instead of requiring it to be passed as a command-line argument.

---

## 2025-02-14 21:55 PST - Blank Line After Comments Parse Error

**What I was trying to do:**
Write a properly formatted XanoScript file with comments at the top followed by the construct definition.

**What the issue was:**
The parser failed when there was a blank line between the comment block and the construct definition. For example, this fails:
```xs
// My comment

function "my_func" {  // Error: Expecting 'function' but found newline
```

But this works:
```xs
// My comment
function "my_func" {  // OK
```

**Why it was an issue:**
This is unexpected behavior - most languages allow blank lines between comments and code. The error message was confusing because it pointed to the blank line as containing an unexpected character.

**Potential solution:**
Either fix the parser to allow blank lines after comments, or document this constraint clearly in the syntax documentation. The error message should also be clearer about blank lines not being allowed.

---

## 2025-02-14 22:00 PST - Boolean Type Name Confusion

**What I was trying to do:**
Define an optional boolean input parameter with a default value in a function input block.

**What the issue was:**
I used `boolean activate?=true` but the correct type name is `bool` not `boolean`. The error message was:
```
Expecting --> } <-- but found --> 'boolean' <--
```

**Why it was an issue:**
The error message doesn't indicate that `boolean` is an invalid type name - it just says it expected a closing brace. This is confusing because `boolean` seems like a reasonable type name (and is used in many other languages).

**Potential solution:**
The validator should provide a more helpful error like "Unknown type 'boolean'. Did you mean 'bool'?" Also, consider aliasing `boolean` to `bool` for better developer experience.

---

## 2025-02-14 22:05 PST - Throw Block Syntax Inconsistency

**What I was trying to do:**
Create a throw statement with multiple properties (name and value).

**What the issue was:**
I used comma separators between properties based on intuition from other languages and JSON:
```xs
throw {
  name = "ErrorName",
  value = "Error message"
}
```

But XanoScript doesn't use commas between properties in throw blocks. The correct syntax is:
```xs
throw {
  name = "ErrorName"
  value = "Error message"
}
```

**Why it was an issue:**
This is inconsistent with most other programming languages and even other parts of XanoScript (like object literals in variable declarations which DO use commas).

**Potential solution:**
Either: (1) Allow commas in throw blocks for consistency, (2) Provide a clear error message saying "Unexpected comma - throw blocks don't use commas between properties", or (3) Document this clearly in the syntax reference with examples showing multi-line throw statements without commas.

---

## General Feedback

**Documentation Gaps:**
1. The quickstart guide mentions common mistakes but doesn't cover the comment blank line issue
2. The throw statement syntax isn't clearly documented with multi-line examples
3. The type names (bool vs boolean) could be more prominent in the types documentation

**MCP Server Suggestions:**
1. Add a `file_path` parameter to `validate_xanoscript` so files can be validated directly without reading them into command arguments
2. Consider adding a `format_xanoscript` tool to auto-format code and fix common issues
3. The error messages could be more contextual with suggestions ("Did you mean...?")

**Overall Experience:**
Once I understood the quirks, XanoScript is quite readable and intuitive. The main friction points were around validation tooling and some syntax inconsistencies. The MCP server works well but could benefit from file-based validation for better DX.
