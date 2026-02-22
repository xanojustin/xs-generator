# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-22 06:32 PST] - MCP Array Parameter Parsing Issue

**What I was trying to do:** Validate multiple specific files using the `file_paths` parameter

**What the issue was:** The `file_paths` array parameter is not being parsed correctly by the MCP. When passing an array like `["/path/1", "/path/2"]`, the MCP appears to split each character as a separate path, resulting in errors like "File not found: [" and "File not found: U" (first character of Users).

Tried these syntaxes:
- `file_paths:='["/path/1", "/path/2"]'` - rejected as missing parameter
- `file_paths=[/path/1,/path/2]` - parsed as individual characters

**Why it was an issue:** Could not validate specific files by array; had to use the `directory` parameter as a workaround, which validates all files in the directory.

**Potential solution:** The MCP should properly handle JSON array syntax for the `file_paths` parameter, or document the expected format more clearly.

---

## [2025-02-22 06:32 PST] - Documentation Clarification: Object Hash Maps

**What I was trying to do:** Build a character frequency counter using an object as a hash map

**What the issue was:** The documentation mentions using objects but doesn't explicitly show the pattern for:
1. Initializing an empty object: `var $obj { value = {} }`
2. Getting a value with default: `$obj|get:"key":0`
3. Setting/updating a value: `$obj|set:"key":value`

Had to infer this from various examples across different doc sections.

**Why it was an issue:** Took some trial and error to figure out the correct filter syntax for object manipulation.

**Potential solution:** Add a specific section in the documentation about using objects as hash maps / dictionaries, with clear examples of get/set patterns.

---

## [2025-02-22 06:32 PST] - Empty String Iteration Behavior

**What I was trying to do:** Split a string into characters using `split:""`

**What the issue was:** Wasn't sure what `split:""` would return for empty strings or if it would include empty strings in the result.

**Why it was an issue:** Added conditional checks `if ($char != "")` to be safe, but unclear if this is necessary.

**Potential solution:** Document the exact behavior of `split` with empty delimiter, and what happens when iterating over empty arrays.

---

## [2025-02-22 06:32 PST] - Function Input Filters with Test Data

**What I was trying to do:** Use `filters=trim` on input fields while testing with the run job

**What the issue was:** The filter syntax worked fine, but it was unclear if the filters are applied before the function receives the input, or if they need to be manually invoked.

**Why it was an issue:** Minor uncertainty about when filters execute.

**Potential solution:** Clarify in the documentation that input filters are automatically applied when the function is called.

---

## Overall Impressions

The documentation is comprehensive and the examples are helpful. Once I understood the basic patterns, writing XanoScript felt natural. The validation tool is fast and helpful. The main friction point was the array parameter parsing for `file_paths`.
