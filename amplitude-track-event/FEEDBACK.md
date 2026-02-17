# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-17 15:48 PST - Comment Validation Issue

**What I was trying to do:**
Create XanoScript files with comments at the top to document what the file does.

**What the issue was:**
When I added comments at the beginning of the .xs files, the Xano MCP validator failed with errors like:
- `[Line 3, Column 1] Expecting --> run <-- but found --> '
' <--`
- `[Line 4, Column 1] Expecting --> function <-- but found --> '
' <--`

The files looked like this:
```xs
// Amplitude Track Event - Run Job Configuration
// Tracks a product analytics event to Amplitude

run.job "Amplitude Track Event" {
  ...
}
```

**Why it was an issue:**
The validator was parsing the file but seemed to have trouble with comments before the main construct. This is confusing because the documentation explicitly states that `//` comments are supported. Removing the comments made the files validate successfully.

**Potential solution:**
Either:
1. The validator should properly handle comments at the beginning of files
2. The documentation should clearly state if comments can't appear before the main construct
3. The error message should be more helpful - indicating it's a comment issue rather than a confusing newline expectation

---

## 2025-02-17 15:46 PST - JSON Escape Character Confusion

**What I was trying to do:**
Write boolean conditions in XanoScript using `&&` (logical AND operator).

**What the issue was:**
Initially I tried writing conditions like:
```xs
precondition ($input.user_id != null && $input.user_id != "")
```

But I was unsure if this was valid XanoScript syntax because the documentation shows conditions using backticks for expressions but doesn't clearly document the `&&` and `||` operators for use in non-backtick contexts.

**Why it was an issue:**
The documentation mentions operators briefly but doesn't have a clear reference for boolean logic operators. I ended up using the `&&` syntax which worked, but I was guessing based on common programming patterns rather than documented XanoScript syntax.

**Potential solution:**
Add a clear operator reference table to the `syntax` documentation showing:
- Logical operators (`&&`, `||`, `!`)
- Comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`)
- When backticks are required vs optional

---

## 2025-02-17 15:47 PST - No "default" Filter Confusion

**What I was trying to do:**
Set default values for optional input parameters using a filter like `$input.optional|default:"fallback"`.

**What the issue was:**
I initially tried using a `default` filter which doesn't exist in XanoScript. The quickstart documentation does document this under "Common Mistakes" but it's easy to miss.

**Why it was an issue:**
Coming from other languages/frameworks where `default` or `defaultValue` filters are common, I expected it to exist. The correct alternatives (`first_notnull` or `??` operator) aren't as intuitive.

**Potential solution:**
The documentation is actually pretty good here - the "Common Mistakes" section catches this. However, it might be worth adding a note in the `syntax` docs about null handling patterns, since this is such a common operation.

---

## 2025-02-17 15:50 PST - Input Block Environment Variable Restriction

**What I was trying to do:**
Initially considered setting default values from environment variables in the input block:
```xs
input {
  text api_key = $env.API_KEY
}
```

**What the issue was:**
The quickstart documentation mentions this is not allowed - `$env` cannot be used in input blocks.

**Why it was an issue:**
This is a reasonable restriction, but the error message when you try to do this could be more helpful. The documentation catches it in the "Common Mistakes" section which is good.

**Potential solution:**
The current documentation is adequate, but perhaps the input block section in the `types` documentation could explicitly mention this restriction.

---

## Overall MCP Experience

**What worked well:**
- The `xanoscript_docs` tool is excellent - comprehensive documentation with examples
- The `validate_xanoscript` tool provides specific line/column error locations
- The quickstart documentation is very helpful with common patterns and mistakes

**Areas for improvement:**
1. Comment handling at file start (as noted above)
2. A more complete operator/syntax reference
3. Perhaps a "strict" vs "permissive" validation mode that warns about potential issues vs hard errors

**MCP Tool Availability:**
All tools were available and working. The Xano MCP was already configured in mcporter.
