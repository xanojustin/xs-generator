# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-17 04:48 PST - Input Block Default/Optional Syntax Confusion

**What I was trying to do:**
Create a function with optional input parameters that have default values.

**What the issue was:**
I incorrectly used `default = "value"` and `optional = true` syntax inside the input block:
```xs
input {
  text level { 
    description = "Severity level"
    default = "error"  // WRONG
  }
  object tags { 
    description = "Key-value pairs"
    optional = true  // WRONG
  }
}
```

**Why it was an issue:**
The validator returned errors like:
- "The argument 'default' is not valid in this context"
- "Expecting --> } <-- but found --> 'optional'"

I had to call `xanoscript_docs({topic: "types"})` to discover the correct syntax uses modifiers on the type declaration itself.

**Potential solution (if known):**
The quick_reference for types shows the correct pattern, but it's not obvious that `default` and `optional` can't be used as block properties. Consider adding a specific example showing input defaults in the quickstart documentation.

---

## 2025-02-17 04:50 PST - Filter Syntax Colon vs Comma

**What I was trying to do:**
Use the `replace` filter to remove characters from a string.

**What the issue was:**
I used comma-separated arguments like JavaScript/TypeScript:
```xs
value = $auth_part|replace: "https://", ""  // WRONG
```

**Why it was an issue:**
XanoScript uses colons for filter arguments, not commas. The error was:
- "The argument '' is not valid in this context"
- "Expecting: one of these possible Token sequences: 1. [=] 2. []"

The error message was cryptic and didn't clearly indicate the syntax should be `replace:"old":"new"`.

**Potential solution (if known):**
The syntax documentation shows filter examples but could be clearer about the colon-based argument syntax. A dedicated "Common Filter Mistakes" section would help.

---

## 2025-02-17 04:52 PST - Non-Existent Functions (uuid_v4, datetime_now)

**What I was trying to do:**
Generate a UUID and get the current datetime using functions that exist in other languages.

**What the issue was:**
I assumed functions like `uuid_v4()` and `datetime_now()` existed based on naming conventions from other languages:
```xs
value = uuid_v4()  // WRONG - doesn't exist
value = datetime_now()  // WRONG - doesn't exist
```

**Why it was an issue:**
The errors indicated these weren't valid expressions, but didn't suggest the correct alternatives. I had to search the syntax docs to discover:
- UUID: `""|uuid` (a filter on empty string)
- Current time: `"now"|to_timestamp` (a filter on string "now")

**Potential solution (if known):**
Add a "Common Functions vs Filters" comparison table in the quickstart docs. Many developers coming from JavaScript/Python expect function calls, not filter chains.

---

## 2025-02-17 04:45 PST - MCP validate_xanoscript Parameter Format Discovery

**What I was trying to do:**
Call the validate_xanoscript tool via mcporter.

**What the issue was:**
The tool kept returning: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

I tried multiple JSON formats:
- `'{"file_path": "/path"}'`
- `--file_path=/path`
- Various other combinations

None worked until I tried: `file_path="/path"` (no JSON wrapper, just key=value).

**Why it was an issue:**
The mcporter CLI syntax is different from what the function signature suggests. The error message didn't indicate the correct format.

**Potential solution (if known):**
Update the mcporter examples in the describe output to show the correct CLI syntax explicitly, or improve the error message to suggest the correct format.

---

## 2025-02-17 04:47 PST - xanoscript_docs Topic Parameter Casing

**What I was trying to do:**
Get specific topic documentation using the xanoscript_docs tool.

**What the issue was:**
I initially called `xanoscript_docs({topic: "run"})` with JSON syntax which returned the general README instead of the specific "run" topic docs.

**Why it was an issue:**
Like the validation tool, the docs tool requires `topic="run"` syntax rather than JSON format. The documentation index lists topics like "run" and "quickstart" but doesn't show the correct CLI invocation format.

**Potential solution (if known):**
Standardize all mcporter tool examples to show the correct CLI invocation format (key=value) rather than function signatures that look like JSON.

---

## Summary of Key Pain Points

1. **Input syntax**: The `?=` and `?` modifiers are elegant but not discoverable
2. **Filter arguments**: Colon-based arguments (`filter:"arg1":"arg2"`) are unusual
3. **Function vs Filter**: Many operations are filters not functions (uuid, now, etc.)
4. **CLI syntax**: mcporter tools use `key=value` not JSON
5. **Error messages**: Could be more helpful with suggestions for common mistakes

## Positive Feedback

- The validation tool is fast and gives clear line/column positions
- The quick_reference mode for docs is concise and useful
- The directory validation option is convenient for batch checking
- Once you learn the patterns, the syntax is consistent and readable
