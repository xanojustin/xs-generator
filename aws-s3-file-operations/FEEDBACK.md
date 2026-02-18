# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 21:18 PST] - Index Type Documentation Unclear

**What I was trying to do:**
Create a table with multiple indexes for better query performance on fields like created_at, operation, and bucket.

**What the issue was:**
I used `type: "index"` for secondary indexes, which resulted in validation errors:
```
Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`
```

**Why it was an issue:**
The documentation at `xanoscript_docs({ topic: "tables" })` doesn't clearly explain what the valid index types are. I had to discover through trial and error that "index" is not a valid type, and that I should use "btree" instead for standard indexes.

**Potential solution (if known):**
- Update the tables documentation to list all valid index types with explanations
- Provide examples showing different index types (primary, btree, btree|unique, gin, search, vector)
- Explain when to use each type

---

## [2025-02-17 21:20 PST] - Function Validation Very Slow

**What I was trying to do:**
Validate the XanoScript files after fixing the index types.

**What the issue was:**
The validation call via mcporter took about 10-15 seconds for just 3 files. This feels slow for a local MCP tool.

**Why it was an issue:**
When iterating and fixing syntax errors, the slow validation cycle makes development frustrating. With 3 small files taking 10+ seconds, larger projects would be painful.

**Potential solution (if known):**
- Cache validation results for unchanged files
- Provide a fast mode that only checks syntax without deep validation
- Allow batch validation with better performance

---

## [2025-02-17 21:15 PST] - No Auto-complete for Cloud Storage Operations

**What I was trying to do:**
Write S3 operations using the cloud.aws.s3.* functions.

**What the issue was:**
While I found the cloud-storage documentation, I initially wasn't sure what operations were available. I had to read through the full documentation to find upload_file, read_file, sign_url, list_directory, and delete_file.

**Why it was an issue:**
Without knowing the exact function names upfront, I had to search through documentation rather than having them readily available.

**Potential solution (if known):**
- Provide a quick reference or cheat sheet for common cloud operations
- Include function signatures in the main quickstart docs

---

## [2025-02-17 21:10 PST] - Reserved Keywords Not Checked Early

**What I was trying to do:**
Originally considered using $response as a variable name in my function.

**What the issue was:**
I remembered from the quickstart docs that $response is reserved, but the documentation warns about this after you might have already made the mistake. The validation didn't catch this because I avoided it.

**Why it was an issue:**
New users might not read all documentation before writing code and would encounter confusing errors.

**Potential solution (if known):**
- The validator should check for reserved variable names and provide clear error messages
- Consider a linter mode that warns about potential issues without failing validation

---

## General Notes

**What worked well:**
- The xanoscript_docs MCP tool is comprehensive and provides good examples
- The validation error messages include line/column numbers which is helpful
- The quickstart guide with common mistakes section is very useful
- Having applyTo frontmatter in docs helps filter relevant information

**Suggestions for improvement:**
1. Add a "tables" section to the quickstart with index examples
2. Provide a syntax validator that can be run locally without MCP for faster iteration
3. Consider adding more examples for cloud integrations in the quickstart
4. Document the expected return types for cloud operations (e.g., what fields does upload_file return?)
