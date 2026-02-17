# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 22:50 PST - MCP JSON Parameter Parsing Issues

**What I was trying to do:**
Validate XanoScript files using the MCP server's `validate_xanoscript` tool

**What the issue was:**
The MCP tool accepts JSON parameters, but the mcporter CLI has inconsistent behavior when passing JSON arguments. Multiple attempts failed:
- `mcporter call xano validate_xanoscript '{"directory":"/path"}'` - Error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"
- Same error with `file_path`, `file_paths`, and `code` parameters
- The MCP server would intermittently disconnect with "Unknown MCP server 'xano'"

**Why it was an issue:**
Could not validate files for several minutes despite correct JSON syntax. Had to discover the workaround through trial and error.

**Potential solution:**
Document the `key:value` syntax more prominently in the tool help. The working format is:
```bash
mcporter call xano validate_xanoscript directory:/path/to/folder
mcporter call xano validate_xanoscript file_path:/path/to/file.xs
```

---

## 2025-02-16 22:52 PST - Filter Expression Syntax Confusion

**What I was trying to do:**
Write a conditional that checks if a string input has length greater than 0: `if ($input.assignee|strlen > 0)`

**What the issue was:**
Validation error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:**
The documentation doesn't clearly explain that filter expressions combined with comparison operators need parentheses around the entire filter expression. Had to guess the correct syntax.

**Potential solution:**
Add clear examples in the syntax documentation showing:
- ❌ `if ($input.text|strlen > 0)` - Invalid
- ✅ `if (($input.text|strlen) > 0)` - Valid

Also document the ternary operator syntax with filters:
- ❌ `assignee: $input.assignee|strlen > 0 ? $input.assignee : null`
- ✅ `assignee: (($input.assignee|strlen) > 0) ? $input.assignee : null`

---

## 2025-02-16 22:55 PST - Documentation Topic Redundancy

**What I was trying to do:**
Get specific documentation for "tasks", "run", and "quickstart" topics

**What the issue was:**
All three topics returned identical generic documentation instead of specific content about:
- Task/cron job syntax specifics
- Run job configuration details  
- Quickstart patterns and examples

**Why it was an issue:**
Had to infer the correct syntax from the high-level overview and existing examples in ~/xs folder rather than getting specific documentation for what I needed.

**Potential solution:**
Ensure each topic returns distinct, specific content. The "run" topic should detail the `run.job` construct with all available options. The "quickstart" should have copy-pasteable patterns for common use cases.

---

## 2025-02-16 22:57 PST - Optional Field Handling in XanoScript

**What I was trying to do:**
Build a payload object that conditionally includes optional fields (assignee and due_date)

**What the issue was:**
XanoScript doesn't seem to have a clean way to conditionally add keys to an object. Had to use multiple `var $task_data` reassignments in conditional blocks, which feels verbose and error-prone.

**Why it was an issue:**
The approach of redeclaring `$task_data` multiple times with different values in conditionals works but:
1. It's verbose
2. It's easy to forget to copy all fields
3. The logic for optional fields with defaults (like `null`) is unclear

**Potential solution:**
Document the recommended pattern for conditional object construction. Consider if there's a spread operator or `merge` function that could help:
```xs
var $task_data {
  value = {
    data: {
      name: $input.name,
      projects: [$input.project_id],
      notes: $input.notes,
      ...(($input.assignee|strlen) > 0 ? {assignee: $input.assignee} : {})
    }
  }
}
```

---

## General Feedback

**What worked well:**
- Once the `key:value` syntax was discovered, validation worked great
- Error messages are helpful with line/column numbers
- The `directory` parameter validates all .xs files recursively

**What could be improved:**
1. More prominent documentation of the `key:value` CLI syntax
2. More specific content for each documentation topic
3. Better examples of conditional logic and object construction
4. A cheatsheet of common patterns (API calls, conditionals, error handling)
