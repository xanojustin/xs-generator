# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 15:45 PST] - Number/Integer Input Types Not Supported

**What I was trying to do:**
Create input parameters for `temperature` and `max_tokens` as numeric types (number and integer) for the OpenAI API call.

**What the issue was:**
I initially wrote:
```xs
input {
  number temperature?=0.7
  integer max_tokens?=1000
}
```

The validator returned: `Expecting --> } <-- but found --> 'number' <--`

This indicates that `number` and `integer` are not valid input type declarations in XanoScript. Looking at all the existing examples, they only use `text` types for inputs.

**Why it was an issue:**
I had to convert these to text types with default string values and update the documentation accordingly. This isn't ideal since these values are conceptually numbers.

**Potential solution (if known):**
- Document the available input types clearly (seems like only `text` is supported?)
- If numeric types exist, provide examples showing the correct syntax
- If only `text` is supported, document how to handle numeric values properly

---

## [2026-02-13 15:47 PST] - Missing `to_number` Filter

**What I was trying to do:**
Convert the string input values for temperature and max_tokens to numbers before sending to the OpenAI API.

**What the issue was:**
I tried using `$input.temperature|to_number` based on the existence of `|to_text` filter, but got: `Unknown filter function 'to_number'`

**Why it was an issue:**
I had to remove the conversion entirely and just pass the string values directly. While JSON might handle this, it's semantically incorrect and could cause issues with APIs that are strict about types.

**Potential solution (if known):**
- Add a `to_number` filter if it doesn't exist
- Document all available filters with their use cases
- Provide type conversion guidance for API integrations

---

## [2026-02-13 15:48 PST] - MCP validate_xanoscript Tool Works Well

**What I was trying to do:**
Validate my XanoScript code using the MCP tool.

**What went well:**
The validation tool works great! It provides clear error messages with line and column numbers. Once I fixed the type issues, it reported "XanoScript is valid. No syntax errors found." which gave me confidence to proceed.

**Why this is helpful:**
The specific line/column error reporting makes debugging much faster than generic error messages.

---

## Summary

The main friction points in this session:

1. **Input type limitations** - Unclear what types are valid for input declarations
2. **Missing type conversion filters** - No `to_number` filter available
3. **Documentation gaps** - Need clearer reference for input types and available filters

Positive feedback:
- The validation tool is excellent with clear error messages
- The overall XanoScript structure is intuitive once you understand the patterns
- The pipe/filter syntax is clean and readable
