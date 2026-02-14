# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-14 01:50 PST - Overall Success with Minor Documentation Gap

**What I was trying to do:**
Create a Calendly one-off event type run job using XanoScript.

**What the issue was:**
No significant issues encountered. The validation passed on first attempt for both files.

**Why it was an issue:**
N/A - Everything worked well.

**Potential solution (if known):**
The MCP and documentation are working well for this use case.

---

## 2026-02-14 01:45 PST - Documentation Request: Multiple applyTo Patterns

**What I was trying to do:**
Understand how the xanoscript_docs `file_path` parameter works when requesting documentation for a specific file.

**What the issue was:**
The documentation topics have `applyTo` patterns (e.g., `run/**/*.xs`, `function/**/*.xs`), but it's unclear how to use `file_path` to get the right docs. I tried `file_path` with different values but was unsure if I was using it correctly.

**Why it was an issue:**
Without clear guidance on how `file_path` pattern matching works, I defaulted to using `topic` parameter instead, which worked fine but may not give context-aware docs.

**Potential solution (if known):**
- Add examples showing `file_path` usage in the xanoscript_docs documentation
- Clarify if file_path uses glob patterns, exact matching, or hierarchical matching
- Consider a `get_docs_for_file` tool that's more explicit

---

## 2026-02-14 01:45 PST - Quick Reference vs Full Mode

**What I was trying to do:**
Decide between `mode=quick_reference` and `mode=full` for documentation retrieval.

**What the issue was:**
The docs mention `quick_reference` is "recommended for context efficiency" but I wasn't sure if it contains enough information to write valid code. I used `mode=full` to be safe, but this may use more tokens than necessary.

**Why it was an issue:**
Uncertainty about whether `quick_reference` contains all necessary syntax details led to using `full` mode "just in case", which is less efficient.

**Potential solution (if known):**
- Add a clear comparison of what's included in each mode
- Perhaps have the MCP auto-select the right mode based on task complexity
- Or make `quick_reference` the default since it's recommended

---

## 2026-02-14 01:45 PST - Validation Success Feedback

**What I was trying to do:**
Validate the XanoScript files I created.

**What the issue was:**
None - validation worked perfectly on first try!

**Why it was an issue:**
N/A

**Potential solution (if known):**
The validate_xanoscript tool is excellent - clear success messages and would presumably give helpful error info if there were issues.

---

## General Observations

### What Worked Well
1. **Documentation is comprehensive** - The topics cover all major areas (run, functions, syntax, types, quickstart)
2. **Validation is fast and clear** - Got instant feedback that code was valid
3. **Examples in docs are helpful** - The quickstart examples showed common patterns like API requests with error handling
4. **MCP tools are well-organized** - Easy to discover available topics

### Suggestions for Improvement
1. **Add a `xanoscript_docs topic=examples` topic** with complete, real-world run job examples
2. **Consider a `validate_workspace` tool** that can validate all .xs files in a directory at once
3. **Add auto-complete/suggestions** in the MCP for common patterns

