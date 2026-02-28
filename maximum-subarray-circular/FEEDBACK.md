# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 15:35 PST] - Confusion about run.job syntax

**What I was trying to do:** Create a run job that executes test cases for the max_subarray_circular function

**What the issue was:** I incorrectly assumed `run.job` could contain a `stack` block with inline code, similar to how functions work. I wrote:
```xs
run.job "test_max_subarray_circular" {
  description = "..."
  stack {
    // test code here
  }
}
```

**Why it was an issue:** The validator returned errors:
- `The argument 'description' is not valid in this context`
- `The argument 'stack' is not valid in this context`

This was confusing because the essentials documentation says "Each `.xs` file must contain exactly one construct" and shows `function` examples with `description` and `stack`. I assumed `run.job` would follow similar patterns.

**Potential solution (if known):** The documentation for `run` topics could explicitly state that `run.job` uses `main` to call a function rather than containing a `stack`. A comparison table or "Common mistakes" section in the run docs would help, similar to what's in the essentials doc.

---

## [2025-02-28 15:37 PST] - MCP validate_xanoscript file_paths parameter format unclear

**What I was trying to do:** Validate multiple specific files using the `file_paths` parameter

**What the issue was:** I tried calling:
```
mcporter call xano.validate_xanoscript file_paths="run.xs,function/max_subarray_circular.xs"
```

Got error: `expected array, received string`

I wasn't sure what format the MCP expects for array parameters. Should it be JSON array? Multiple arguments? Space-separated?

**Why it was an issue:** The mcporter CLI help doesn't clearly show how to pass array parameters. I had to fall back to using the `directory` parameter instead.

**Potential solution (if known):** Document the expected format for array parameters in mcporter help, or provide examples showing `--args '{"file_paths": ["a.xs", "b.xs"]}'` syntax.

---

## [2025-02-28 15:40 PST] - Overall XanoScript documentation structure feedback

**What I was trying to do:** Understand the complete structure of a run job without trial and error

**What the issue was:** The `essentials` doc is excellent for functions but doesn't cover run jobs. The `run` doc has the syntax but finding it required knowing which topic to request. 

**Why it was an issue:** As a new XanoScript developer, I didn't know that `run.job` and `function` have fundamentally different structures until I got validation errors. The mental model that "everything has a stack block" was hard to shake.

**Potential solution (if known):** 
1. Add a "Common patterns for different file types" section to the essentials doc
2. Or include a brief example of `run.job` syntax in the essentials "Quick Reference"
3. A visual diagram showing: "run.job -> calls function -> which has stack" would help clarify the architecture

---
