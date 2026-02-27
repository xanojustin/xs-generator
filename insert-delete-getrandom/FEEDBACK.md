# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 19:15 PST] - Object Filter Names

**What I was trying to do:** Implement a RandomizedSet data structure that uses an object (hash map) to store value-to-index mappings for O(1) lookups.

**What the issue was:** I incorrectly used `has_key` instead of `has` to check if a key exists in an object, and `delete` instead of `unset` to remove a key from an object.

**Why it was an issue:** The validation failed with:
- "Unknown filter function 'has_key'" 
- "Unknown filter function 'delete'"

This is a common pattern in many programming languages (Python uses `in` or `.get()`, JavaScript uses `hasOwnProperty` or `in`, etc.), so it was natural to assume `has_key` might work. The `delete` keyword is also common in JavaScript for removing object properties.

**Potential solution (if known):** 
The documentation clearly shows the correct filters are `has` and `unset`. However, it might be helpful if:
1. The MCP error messages could suggest the correct filter name ("Did you mean 'has'?")
2. The quickstart documentation could have a more prominent "Common Filter Mistakes" section highlighting object operations

---

## [2025-02-26 19:10 PST] - MCP Tool Parameter Naming

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths.

**What the issue was:** Initially tried using `files` as the parameter name, but the tool expects `file_paths` (with underscore).

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" wasn't immediately clear about what I was doing wrong since I was providing a `files` parameter.

**Potential solution (if known):** 
The error message could mention that the parameter name provided doesn't match any expected parameters, which would help identify the issue faster.

---

## [2025-02-26 19:05 PST] - Finding Object Filter Documentation

**What I was trying to do:** Find the correct filter names for object operations (check key existence, delete key).

**What the issue was:** Had to search through the syntax documentation to find the Object Filters section.

**Why it was an issue:** While the documentation exists and is comprehensive, it took some grepping to find the specific section. The quickstart mentions object filters briefly but doesn't list them all.

**Potential solution (if known):** 
Consider adding a "Filter Reference by Type" section at the top of the syntax documentation that lists all filters organized by the data type they operate on (string filters, array filters, object filters, etc.).