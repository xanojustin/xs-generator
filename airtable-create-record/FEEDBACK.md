# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 19:45 PST - Issue 1: object type not valid for input parameters

**What I was trying to do:**
Create a function that accepts an object type input parameter for the Airtable fields data.

**What the issue was:**
I wrote:
```xs
input {
  object fields { description = "Object containing field names and values" }
}
```

This caused a validation error at line 6, column 21: "expecting at least one iteration which starts with one of these possible Token sequences: <[NewlineToken]> but found: 'description'"

**Why it was an issue:**
The error message was cryptic and didn't clearly indicate that `object` is not a valid input type. I had to debug by copying a working file and modifying it line by line to discover this.

**Potential solution (if known):**
- The MCP validate tool should provide clearer error messages for invalid type names
- Documentation should explicitly list valid input types for function parameters
- I worked around this by using `text` type and using `json_decode` filter to parse the JSON string into an object

---

## 2026-02-13 19:45 PST - Issue 2: ?=null default value syntax not supported

**What I was trying to do:**
Create an optional input parameter with null as the default value:
```xs
text typecast?=null filters=trim { description = "Typecast option" }
```

**What the issue was:**
The validator gave this error: "Expecting: one of these possible Token sequences: ["..."], [floating point number], [integer], [true], [false], [now], [Identifier] but found: 'null'"

**Why it was an issue:**
`null` is a valid value in XanoScript (used in preconditions, conditionals, etc.) but apparently cannot be used as a default value for input parameters. The error message was somewhat helpful but still unclear about the actual restriction.

**Potential solution (if known):**
- Allow `null` as a valid default value for optional parameters
- Improve error message to specifically say "null is not a valid default value, use just '?' for optional parameters without a default"
- I worked around this by using just `text typecast?` without a default value

---

## 2026-02-13 19:45 PST - Issue 3: File writing encoding issues with validation

**What I was trying to do:**
Write XanoScript files using the write tool and then validate them with the MCP.

**What the issue was:**
Initially, files written with the write tool consistently failed validation with cryptic "expecting NewlineToken" errors. When I copied a validated file using `cp` and then used the edit tool to modify it, validation passed. This suggests there may be encoding, line ending, or whitespace differences between files created with write vs edit/cp.

**Why it was an issue:**
It was very confusing - same content, different validation results. I had to resort to copying a working file and editing it incrementally instead of writing fresh files.

**Potential solution (if known):**
- The MCP validator may be sensitive to exact byte sequences or line endings
- Could be an issue with how the write tool encodes files vs cp/edit
- Recommend standardizing on specific encoding (UTF-8 with LF line endings)

---

## 2026-02-13 19:45 PST - Issue 4: Lack of input type documentation

**What I was trying to do:**
Find documentation on valid input types for function parameters.

**What the issue was:**
The xanoscript_docs topic "types" was not retrieved in my documentation calls, so I didn't have a reference for what types are valid for input parameters. I assumed `object` would work based on general programming knowledge.

**Why it was an issue:**
Had to discover through trial and error that valid types seem to be: `text`, `int`, `float`, `boolean`, `timestamp`, `json` (possibly others I didn't test).

**Potential solution (if known):**
- The quickstart or types documentation should clearly list all valid input parameter types
- The validate tool could suggest valid types when an invalid type is encountered

---

## Summary

Overall, once I worked through these issues, the Xano MCP validation tool was helpful for catching syntax errors. The main friction points were:
1. Cryptic error messages that don't clearly explain the actual problem
2. Unclear which types are valid for input parameters  
3. Potential encoding/line ending sensitivities in the validator

The documentation I received (quickstart, run, integrations) was generally good for understanding patterns and available operations, but could be improved with more explicit type references and better error messages from the validation tool.
