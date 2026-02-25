# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 07:35 PST] - Documentation: Optional Input Syntax Unclear

**What I was trying to do:** Define optional input parameters for the function

**What the issue was:** I used `optional = true` syntax which resulted in error: "The argument 'optional' is not valid in this context"

**Why it was an issue:** The documentation doesn't clearly explain how to mark inputs as optional. The error message suggests using just `optional` without a value, but it's unclear if that's the correct approach.

**Potential solution:** Add clear documentation about optional input syntax in the `types` or `functions` topic. Show examples of optional vs required inputs.

---

## [2025-02-25 07:36 PST] - Documentation: Object vs JSON Type Unclear

**What I was trying to do:** Define an input parameter to accept an object/hashmap structure

**What the issue was:** I used `object` type which resulted in error suggesting to use `json` instead

**Why it was an issue:** The documentation mentions `object` as a type in some places but `json` is the actual valid type name. This is inconsistent and confusing.

**Potential solution:** Standardize type names in documentation. If `object` is not a valid type, remove all references to it and consistently use `json`.

---

## [2025-02-25 07:37 PST] - Missing Filter: merge_at

**What I was trying to do:** Update an element at a specific index in an array

**What the issue was:** I assumed there was a `merge_at` filter to replace an element at an index, but it doesn't exist

**Why it was an issue:** Had to work around by using `slice` to get before/after parts and then `merge` them together with the new element. This is verbose and less readable.

**Potential solution:** Add a `merge_at` or `set_at` filter that allows updating/replacing an element at a specific index. The workaround is:
```xs
$before = $array|slice:0:$index
$after = $array|slice:($index + 1):($array|count)
$new_array = $before|merge:[$new_element]|merge:$after
```

---

## [2025-02-25 07:38 PST] - Reserved Variable Names Not Documented

**What I was trying to do:** Create a variable named `$output` to store the function response data

**What the issue was:** Got error: "'$output' is a reserved variable name and should not be used as a variable"

**Why it was an issue:** The documentation lists reserved variables in one place but `$output` wasn't in that list. The error message was helpful but it would be better to have a complete list upfront.

**Potential solution:** Update the reserved variables list in the documentation to include `$output`. The current list shows: `$response`, `$output`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result`, `$index` but the documentation only mentions some of these.

---

## [2025-02-25 07:39 PST] - MCP Tool Parameter Format Unclear

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths

**What the issue was:** Initially tried JSON format `{"file_paths": [...]}` but mcporter uses `key=value` format instead

**Why it was an issue:** The error message said a parameter was required but didn't clarify the expected format. Had to look at mcporter help to understand the correct syntax.

**Potential solution:** Update the MCP tool documentation or error messages to indicate that parameters should be passed as `key=value` pairs, not JSON.

---
