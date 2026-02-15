# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 09:50 PST] - MCP Validation Tool Difficult to Invoke

**What I was trying to do:**
Validate the XanoScript files using the `validate_xanoscript` MCP tool before committing.

**What the issue was:**
The `validate_xanoscript` tool requires a `code` parameter containing the full source code, but passing multi-line XanoScript code through mcporter's CLI is extremely difficult due to shell escaping issues.

**Why it was an issue:**
I tried multiple approaches:
1. Passing file path directly - tool requires `code` parameter, not file path
2. Using `--args '{"code": "..."}'` - JSON escaping breaks on newlines and special characters
3. Using function syntax `mcporter call "xano.validate_xanoscript(code: ...)"` - shell escaping still problematic
4. Using `jq` to create JSON payload and pipe to mcporter - mcporter doesn't accept stdin
5. Using `@/path/to/file` syntax - not supported by mcporter
6. Creating Node.js and Python scripts to call MCP directly - MCP returns no valid response or hangs

**Potential solution (if known):**
- Add a `file_path` parameter to `validate_xanoscript` so it can read files directly
- OR add stdin support to mcporter for passing JSON payloads
- OR provide a simpler CLI command like `mcporter validate /path/to/file.xs`

---

## [2026-02-15 09:55 PST] - Unclear How to Properly Structure run.job Input Blocks

**What I was trying to do:**
Understand the correct syntax for default values in run.job input blocks.

**What the issue was:**
The documentation shows that `$env` cannot be used in run.job input blocks (must use in stack), but it's unclear if other dynamic values are allowed or if only literals are permitted.

**Why it was an issue:**
The quickstart docs say "Input values must be constants" but don't clarify what constitutes a constant. Can I use:
- String literals? ✓ (obviously)
- Numbers? ✓ (probably)
- Booleans? ? (unclear)
- Arrays/objects? ? (unclear)

**Potential solution (if known):**
Add a definitive list of what value types are valid in run.job input blocks with examples.

---

## [2026-02-15 10:00 PST] - Boolean Type Syntax Unclear

**What I was trying to do:**
Use boolean types in input blocks with default values.

**What the issue was:**
The documentation mentions `boolean` as a type but doesn't show clear examples of boolean default value syntax in input blocks.

**Why it was an issue:**
Tried `boolean include_citations?= true` - unclear if this is valid syntax. Other examples show `text field?="default"` for strings, but boolean examples are sparse.

**Potential solution (if known):**
Add specific examples for each data type with default values in the input block section.

---

## [2026-02-15 10:05 PST] - var.update Syntax Ambiguity

**What I was trying to do:**
Update an object to add a new key conditionally (for the citations parameter).

**What the issue was:**
The documentation shows `var.update $variable { value = ... }` but also shows `$object|set:"key":value` filter syntax. It's unclear when to use which approach.

**Why it was an issue:**
I used:
```xs
var.update $payload {
  value = $payload|set:"return_citations":true
}
```

But the existing OpenAI example uses a different pattern for building objects incrementally. Unclear if my approach is idiomatic or if there's a better pattern.

**Potential solution (if known):**
Add a "Building Objects Conditionally" section to the quickstart with patterns for:
- Adding keys conditionally to objects
- Pushing to arrays conditionally  
- Building complex nested objects step by step

---

## Summary

The XanoScript language itself seems well-documented and consistent. The main friction points were:

1. **Tool invocation** - The MCP validation tool is hard to use from CLI for multi-line code
2. **Lack of concrete examples** for some patterns (booleans, conditional object building)
3. **No file-based validation** - would be much easier than passing code strings

The run.xs file validated successfully using simple inline JSON, so the simpler validation approach works for small files. The function file is likely correct (follows documented patterns) but couldn't be validated due to the CLI limitations.

---
Documentation version: 2.0.0
