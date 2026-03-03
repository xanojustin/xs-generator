# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 06:35 PST] - Sort filter syntax unclear

**What I was trying to do:** Sort an array of objects by a numeric property in descending order

**What the issue was:** The `sort` filter syntax was not clear from the documentation. I tried multiple variations:
1. `$word_entries|sort:$$.value:desc` - failed with "but found: 'desc'"
2. `$word_entries|sort:value:int:false` - failed with "but found: 'int'"
3. `$word_entries|sort:"value":int:false` - failed with "but found: 'int'"

**Why it was an issue:** The documentation shows `[{n:"z"},{n:"a"}]|sort:n:text:false` but this syntax didn't work with my attempts. The error messages didn't help clarify the correct syntax.

**Potential solution (if known):** 
- Provide more examples in the array-filters documentation for common sorting scenarios
- Error messages could suggest the correct syntax pattern
- A working example with entries/values would be helpful

---

## [2026-03-03 06:32 PST] - Documentation format for arrays

**What I was trying to do:** Pass file paths as an array to the validate_xanoscript tool

**What the issue was:** The MCP expects a JSON array format `{"file_paths": ["path1", "path2"]}` but this wasn't immediately clear from the tool description.

**Why it was an issue:** Had to experiment with different formats before finding the correct one via `--args` with JSON.

**Potential solution (if known):**
- Add an example in the tool description showing the exact JSON format needed
- Consider supporting comma-separated strings as an alternative

---

## [2026-03-03 06:30 PST] - Quick reference was too minimal

**What I was trying to do:** Understand the complete structure of run.job and function definitions

**What the issue was:** The quick_reference mode for `run` and `functions` topics only showed minimal syntax without complete examples.

**Why it was an issue:** Had to look at existing implementations in ~/xs/ to understand the full structure.

**Potential solution (if known):**
- Include a complete minimal example in the quick_reference for each object type
- The essentials topic was much more helpful - perhaps recommend that first
