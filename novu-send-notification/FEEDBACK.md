# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 04:20 PST] - Input Block Description Syntax

**What I was trying to do:**
Create a function with descriptive input fields using the syntax shown in the documentation.

**What the issue was:**
The documentation shows this syntax for input fields with descriptions:
```xs
input {
  text name filters=trim
  int age? filters=min:0
  email contact filters=lower { description = "..." }
}
```

But when I tried:
```xs
input {
  text subscriber_id { description = "Unique identifier for the subscriber" }
}
```

I got a parse error: `Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: 'description'`

**Why it was an issue:**
The documentation shows `{ description = "..." }` as valid syntax for input fields, but the validator rejected it. I had to remove the descriptions entirely to get the code to validate.

**Potential solution (if known):**
Either update the documentation to show the correct syntax for field descriptions, or fix the parser to accept the documented syntax. It would also be helpful to show valid input type modifiers (like optional `?`) in the examples.

---

## [2026-02-15 04:22 PST] - Optional Input Parameter Syntax

**What I was trying to do:**
Mark an input parameter as optional using the `?` modifier.

**What the issue was:**
When I tried:
```xs
input {
  object payload?
}
```

The validator gave an error at the `?` character: `Expecting --> { <-- but found --> '`

**Why it was an issue:**
The documentation mentions filters like `int age? filters=min:0` but it's unclear if the `?` is part of the filter or a separate optional marker. When I tried using it directly on an object type, it failed.

**Potential solution (if known):**
Clarify in the documentation how optional parameters work and which types support them. Show examples of optional object/json parameters.

---

## [2026-02-15 04:25 PST] - Throw Block Comma Separator

**What I was trying to do:**
Create a throw block with name and value properties separated by a comma.

**What the issue was:**
The documentation shows throw blocks with commas:
```xs
throw {
  name = "APIError",
  value = "Error message"
}
```

But when I validated code with commas, I got: `Expecting --> } <-- but found --> ','`

Removing the comma made it validate:
```xs
throw {
  name = "APIError"
  value = "Error message"
}
```

**Why it was an issue:**
The documentation shows commas in throw blocks (in the quickstart section under "JSON API Response"), but the validator requires newlines without commas.

**Potential solution (if known):**
Standardize the documentation to match the actual parser requirements. The throw block seems to require newline-separated properties without commas, unlike other object literals.

---

## [2026-02-15 04:27 PST] - Elseif Condition Syntax

**What I was trying to do:**
Use elseif with conditions to handle different HTTP status codes.

**What the issue was:**
When I tried:
```xs
elseif ($api_result.response.status == 401) {
```

And also tried with backticks:
```xs
elseif (`$api_result.response.status == 401`) {
```

Both caused parse errors. The error message was cryptic and didn't point to elseif as the issue.

**Why it was an issue:**
The documentation shows elseif in the quickstart guide using backticks around conditions:
```xs
elseif (`$status == "pending"`) { }
```

But this didn't work. I had to remove elseif entirely and use a simple if/else instead.

**Potential solution (if known):**
Either fix the parser to accept elseif properly, or update the documentation to show the correct elseif syntax. The current documentation seems inconsistent with the actual parser behavior.

---

## [2026-02-15 04:30 PST] - Validate Tool Requires Code Parameter

**What I was trying to do:**
Validate .xs files using the MCP validate_xanoscript tool by passing a file path.

**What the issue was:**
I initially tried:
```
mcporter call xano.validate_xanoscript file_path=/path/to/file.xs
```

But got: `Error: 'code' parameter is required`

I had to read the file and pass the content as the `code` parameter instead.

**Why it was an issue:**
It's inconvenient to have to read files manually and pass their contents. Most validation tools accept file paths.

**Potential solution (if known):**
Add support for a `file_path` parameter to the validate_xanoscript tool, or provide a helper that reads the file and validates it in one call.

---

## [2026-02-15 04:32 PST] - Error Line Numbers in Validation

**What I was trying to do:**
Debug validation errors using the line numbers provided in error messages.

**What the issue was:**
The error messages showed line numbers like `[Line 45, Column 39]` but when I counted lines in my code, that location didn't match the actual error. The line numbers seemed offset or incorrect.

**Why it was an issue:**
Incorrect line numbers make debugging difficult. I had to guess which part of the code was causing the error.

**Potential solution (if known):**
Verify that the line numbers in validation errors correspond correctly to the input code, especially when multi-line strings are involved.

---

## General Notes

**Documentation Quality:**
The documentation is comprehensive but has inconsistencies between what it shows and what the parser accepts. Key areas to improve:
1. Input block field syntax (descriptions, optional markers)
2. Throw block property separators (commas vs newlines)
3. Elseif condition syntax
4. More complete examples that actually validate

**MCP Server Stability:**
The xanoscript_docs tool worked reliably. The validate_xanoscript tool also worked once I understood the code parameter requirement.

**Suggested Improvements:**
1. Add a `file_path` parameter to validate_xanoscript
2. Provide a `validate_directory` tool to validate all .xs files in a folder
3. Add a `format_xanoscript` tool to auto-format code
4. Create a JSON schema for .xs files for IDE support
