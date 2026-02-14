# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 19:20 PST] - Logical Operator Expression Syntax

**What I was trying to do:**
Create a precondition that validates at least one of two optional fields (text_body or html_body) was provided.

**What the issue was:**
I initially wrote the precondition with inline logical operators like this:
```xs
precondition (($input.text_body != null && $input.text_body != "") || ($input.html_body != null && $input.html_body != "")) {
```

This caused a parse error: "Expecting --> ) <-- but found --> '$input'"

**Why it was an issue:**
The documentation shows that logical operators (`&&`, `||`) exist and gives examples using backticks for expressions, but it wasn't clear when backticks are required vs optional. I tried using conditional blocks as expressions inside var assignments, which also failed.

**Potential solution:**
The documentation could be clearer about:
1. When backticks are required (seems like: any expression with operators beyond basic comparison)
2. That conditional blocks cannot be used as expressions inside var value assignments
3. Provide more examples of complex preconditions with multiple conditions

---

## [2025-02-13 19:22 PST] - Conditional as Expression Not Working in var Blocks

**What I was trying to do:**
Use the documented "Conditional as Expression" pattern to set a boolean variable:
```xs
var $has_text {
  value = conditional {
    if (`$input.text_body != null && $input.text_body != ""`) { true }
    else { false }
  }
}
```

**What the issue was:**
Got error: "Expected an expression but found: 'conditional'"

**Why it was an issue:**
The documentation shows this pattern should work, but it doesn't in this context. I had to find a workaround by checking the count of object properties instead.

**Potential solution:**
Either fix the parser to support conditional expressions in var value blocks, or update documentation to clarify where this pattern works vs doesn't work.

---

## [2025-02-13 19:18 PST] - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Call the validate_xanoscript MCP tool via mcporter CLI with inline code containing special characters.

**What the issue was:**
The `&&` operator in the XanoScript code was being interpreted by the shell as "run next command if previous succeeded", causing the command to fail or behave unexpectedly. I also had issues with `$` variables being expanded by the shell.

**Why it was an issue:**
Had to carefully escape the code or read from file instead. This makes quick validation via CLI cumbersome.

**Potential solution:**
1. The MCP could accept a file_path parameter instead of just code
2. Better escaping guidance in documentation
3. Or recommend reading from file for any non-trivial code

---

## [2025-02-13 19:15 PST] - Discovering api.request Documentation

**What I was trying to do:**
Find documentation on how to make HTTP requests to external APIs.

**What the issue was:**
I initially looked in the functions and APIs documentation but didn't find `api.request`. I eventually found it buried in the integrations topic, which makes sense but wasn't my first guess.

**Why it was an issue:**
Making HTTP requests is a fundamental operation. It would be helpful to have a more prominent mention or cross-reference in the functions documentation.

**Potential solution:**
Add a cross-reference in the functions documentation pointing to api.request in integrations. Or create a dedicated "External APIs" topic.

---

## General Observations

**What's Good:**
- The `validate_xanoscript` tool is extremely valuable - caught my syntax errors immediately
- The documentation is comprehensive when you find the right topic
- The quick_reference mode is great for getting the essentials

**What Could Be Improved:**
1. **Topic discovery**: The `xanoscript_docs` tool lists all topics in the schema but not in a very discoverable way in the CLI output
2. **Error messages**: Parse errors could be more descriptive about what syntax is expected
3. **More examples**: Each topic could benefit from 2-3 complete, real-world examples

---

Documentation version reviewed: 2.0.0
MCP Server: @xano/developer-mcp
