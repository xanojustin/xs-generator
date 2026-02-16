# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 23:16 PST] - MCP Tool Availability

**What I was trying to do:**
Call the xanoscript_docs tool to get documentation for creating a run job.

**What the issue was:**
The MCP tool documentation shows the xanoscript_docs function, but the quick_reference mode returns minimal information (just a directory structure for run jobs). I had to call it multiple times with different topics to get comprehensive documentation.

**Why it was an issue:**
Had to make multiple calls to get complete information. The quick_reference mode was too minimal for run jobs.

**Potential solution:**
The quick_reference for run jobs should include at least the full syntax for run.job and run.service, similar to how other topics provide complete syntax reference.

---

## [2026-02-15 23:18 PST] - Conditional Block Syntax Unclear

**What I was trying to do:**
Conditionally add user_metadata and app_metadata to the user payload only if they are provided.

**What the issue was:**
The quickstart docs showed conditional syntax, but I was unsure about:
1. How to check for null values
2. Whether I could reassign variables in different conditional blocks
3. The proper syntax for null-safe comparison operators

**Why it was an issue:**
I used `!= null` comparison but wasn't confident this was the correct syntax. The syntax docs mention null-safe operators (`==?`, `!=?`) but I wasn't sure if I should use those or regular operators.

**Potential solution:**
Add more examples showing:
- How to handle optional JSON inputs
- Variable reassignment patterns
- Null checking best practices

---

## [2026-02-15 23:19 PST] - Variable Reassignment Within Same Stack

**What I was trying to do:**
Update the $user_payload variable conditionally to add user_metadata and app_metadata.

**What the issue was:**
I wasn't sure if I could declare `var $user_payload` multiple times in the same stack block, or if I should use a different pattern. I ended up using conditional blocks with the same variable name, but this felt potentially wrong.

**Why it was an issue:**
Variable scoping rules aren't clear. Can I redeclare a variable? Should I use `set` instead? The syntax docs don't explain variable reassignment.

**Potential solution:**
Document variable scoping rules:
- Can variables be redeclared?
- What's the scope of variables declared in conditional blocks?
- Best practice for building objects conditionally

---

## [2026-02-15 23:20 PST] - JSON Type Handling

**What I was trying to do:**
Define optional JSON metadata inputs (user_metadata and app_metadata).

**What the issue was:**
The input block uses `json user_metadata?` syntax, but I wasn't sure:
1. If `json` is a valid type
2. How to check if the JSON input was provided
3. How to set a JSON property on an object using `set` filter

**Why it was an issue:**
Guessed that `json` is a valid type based on `text`, `int`, etc. Also guessed that `set` filter works with JSON values, but this wasn't confirmed.

**Potential solution:**
Add a data types reference showing all valid types for inputs and variables.

---

## [2026-02-15 23:21 PST] - String Concatenation with Environment Variables

**What I was trying to do:**
Build URLs using environment variables and string concatenation.

**What the issue was:**
The quickstart shows `$env.API_KEY` syntax, but I wasn't 100% sure if environment variables use `$env.` prefix or just the variable name directly.

**Why it was an issue:**
Had to infer from the example that `$env.` is the correct prefix. Also, string concatenation with `~` operator works well, but I had to wrap my head around parentheses requirements when using filters.

**Potential solution:**
Add a dedicated environment variables section showing:
- How to reference env vars in code
- Examples of building URLs/paths with env vars
- Common patterns

---

## [2026-02-15 23:22 PST] - Overall Feedback

**Positive:**
- The validate_xanoscript tool is excellent - it caught no errors on first try!
- The documentation structure is logical and organized by topic
- The run.job and run.service syntax is clean and intuitive

**Areas for improvement:**
1. **Consolidated examples**: A single "complete example" doc showing a real-world run job with functions, tables, and APIs would be very helpful
2. **Common patterns**: A patterns guide showing frequently used patterns like:
   - Building conditional payloads
   - Error handling best practices
   - Working with external APIs
3. **Type reference**: A comprehensive list of all valid types for inputs and variables
4. **Filter reference**: Complete list of available filters with examples

**What worked well:**
- Creating the run job structure was straightforward
- Validation passed on first attempt
- The overall XanoScript syntax is clean and readable

---

Documented by: Brecht
Date: Sunday, February 15th, 2026
