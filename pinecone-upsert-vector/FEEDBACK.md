# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 05:47 PST] - Issue: List type not valid for inputs

**What I was trying to do:**
Create a function input parameter that accepts an array of floats (vector embedding values).

**What the issue was:**
I initially used `list values { description = "..." }` which resulted in a validation error:
```
[Line 6, Column 5] Expecting --> } <-- but found --> 'list'
```

**Why it was an issue:**
The documentation mentions `list` as a type in some contexts but the validator rejected it for input parameters. I had to dig through other working examples to discover that `json` should be used instead for array inputs.

**Potential solution (if known):**
The types documentation could be clearer about which types are valid for input blocks vs other contexts. A comprehensive table showing "Input Block Types" vs "Stack Variable Types" would help.

---

## [2025-02-14 05:50 PST] - Issue: Input block formatting requirements unclear

**What I was trying to do:**
Define multiple input parameters for my function.

**What the issue was:**
I wrote inputs on single lines like:
```xs
input {
  text index_name filters=trim { description = "..." }
  text id filters=trim { description = "..." }
}
```

This resulted in the cryptic error:
```
[Line 8, Column 24] Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: 'description'
```

**Why it was an issue:**
The error message was very confusing - it mentioned "NewlineToken" but didn't clearly explain that the `{` brace needs to be on a new line when there are multiple inputs. I had to find a working example (firebase-send-push-notification) to understand the correct format:
```xs
input {
  text index_name filters=trim {
    description = "..."
  }
  text id filters=trim {
    description = "..."
  }
}
```

**Potential solution (if known):**
- Improve the error message to say something like "When defining multiple inputs, the opening brace '{' must be on a new line"
- Add a linting suggestion to the validator that detects this common pattern

---

## [2025-02-14 05:45 PST] - Issue: MCP validate tool requires code parameter, not file_path

**What I was trying to do:**
Validate a .xs file using the Xano MCP.

**What the issue was:**
I initially tried to pass `file_path` as a parameter thinking it would read the file, but got error:
```
Error: 'code' parameter is required
```

**Why it was an issue:**
The tool documentation says "@param code The XanoScript code to validate" but it wasn't immediately obvious that I needed to read the file content myself and pass it as the `code` parameter. I expected something like `file_path` to work.

**Potential solution (if known):**
Either add a `file_path` parameter as an alternative to `code`, or make the documentation clearer that `code` means the actual file content string, not a path.

---

## [2025-02-14 05:46 PST] - Issue: mcporter CLI escaping challenges

**What I was trying to do:**
Call the validate_xanoscript tool with multi-line XanoScript code via mcporter CLI.

**What the issue was:**
Passing multi-line code strings through shell commands with proper JSON escaping is extremely error-prone. I had to resort to:
```bash
CODE=$(cat ~/xs/pinecone-upsert-vector/run.xs) && mcporter call xano.validate_xanoscript code="$CODE"
```

**Why it was an issue:**
Shell escaping of quotes, newlines, and special characters makes this fragile. A simple validation task becomes complex.

**Potential solution (if known):**
Add a `--file` option to mcporter call or create a standalone `xano validate` CLI command that can accept file paths directly.

---

## General Observations

1. **Documentation Format**: The `xanoscript_docs` tool returns the same generic index page regardless of the topic requested. It would be more useful if it returned specific documentation for the requested topic.

2. **Error Line Numbers**: The validator gives accurate line/column numbers which is great! But the error messages could be more human-readable.

3. **Example Patterns**: Looking at existing working implementations in the ~/xs folder was more helpful than the documentation. Having a "cookbook" of common patterns would be valuable.

4. **Object vs json Types**: It's unclear when to use `object` vs `json` in input blocks. Both seem similar but may have different validation behaviors.

---
