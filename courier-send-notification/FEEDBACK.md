# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 09:47 PST - JSON Type Default Value Syntax Issue

**What I was trying to do:**
Create a function with an optional JSON input parameter that defaults to an empty object `{}` when not provided.

**What the issue was:**
I initially wrote:
```xs
json data?={} {
  description = "Optional data object to pass to the template"
}
```

This caused a validation error: `[Line 13, Column 16] Expecting: one of these possible Token sequences... but found: '{'`

**Why it was an issue:**
The parser doesn't accept `{}` as a default value for JSON types. This is inconsistent with other types like `text` where you can do `text name?="default"`. I had to make the field nullable without a default (`json data?`) and then handle the null case in the stack logic:

```xs
// In stack block
var $template_data {
  value = ($input.data != null) ? $input.data : {}
}
```

**Potential solution:**
- Allow `{}` and `[]` as valid default values for JSON types in the parser
- Document this limitation clearly in the types documentation
- Provide examples of how to handle optional JSON parameters

---

## 2025-02-18 09:46 PST - Documentation Access Format Confusion

**What I was trying to do:**
Call the `xanoscript_docs` MCP tool to get documentation for run jobs and external APIs.

**What the issue was:**
Initially, I tried calling the tool with parameters in the wrong format:
```bash
mcporter call xano.xanoscript_docs --topic run --mode quick_reference
```

This returned syntax documentation instead of run documentation because the parameters weren't being parsed correctly.

**Why it was an issue:**
The correct format is `topic=value mode=value` without dashes. The error was silent - it just returned different documentation instead of failing with an error message.

**Potential solution:**
- Have the tool return an error when unknown parameters are provided
- Document the correct parameter format more prominently
- Consider supporting both `--topic` and `topic=` formats for better UX

---

## 2025-02-18 09:45 PST - Ternary Operator Documentation Gap

**What I was trying to do:**
Use a ternary/conditional operator to set a default value based on whether another value is empty.

**What the issue was:**
I couldn't find clear documentation on the ternary operator syntax (`? :`) in the quick reference. I had to infer it from examples and trial-and-error.

**Why it was an issue:**
Code like `($input.recipient_id != "") ? $input.recipient_id : $input.recipient_email` wasn't clearly documented. I wasn't sure if the parentheses were required or if the syntax was correct.

**Potential solution:**
- Add a "Conditional/Ternary Operators" section to the syntax quick reference
- Include examples of common patterns like null-coalescing and empty-string defaults

---

## 2025-02-18 09:44 PST - String Concatenation with Filters Confusion

**What I was trying to do:**
Concatenate strings that include filtered values, like converting a status code to text and appending it to an error message.

**What the issue was:**
The documentation mentions that filtered expressions need parentheses, but the reason why isn't immediately clear. The example:
```xs
// Correct
var $message { value = ($status|to_text) ~ ": " ~ ($data|json_encode) }
```

**Why it was an issue:**
Without understanding operator precedence, this seems arbitrary. It's not clear why `$status|to_text ~ ": "` would fail.

**Potential solution:**
- Explain that the `|` filter operator has higher precedence than `~` concatenation
- Add a troubleshooting section explaining common parse errors

---

## 2025-02-18 09:43 PST - MCP Tool Discovery

**What I was trying to do:**
Figure out how to list and call MCP tools through mcporter.

**What the issue was:**
The `mcporter list` command shows servers but not their tools. I had to use `mcporter describe xano` to see the available tools, which wasn't immediately obvious.

**Why it was an issue:**
The help output and documentation don't clearly indicate that `describe` is the command to list tools for a specific server.

**Potential solution:**
- Add a `mcporter tools <server>` command or alias
- Include tool listing in the `mcporter list` output

---

## Summary

Overall, the MCP validation tool worked well and caught my syntax error. The main friction points were:

1. **JSON defaults** - Couldn't use `{}` as default, had to handle in stack logic
2. **Parameter format** - Took trial and error to get the docs tool working
3. **Missing examples** - Some common patterns (ternary, complex concatenation) need more examples

The documentation is comprehensive but could benefit from more "common patterns" examples showing real-world usage of conditionals, string manipulation, and null handling.
