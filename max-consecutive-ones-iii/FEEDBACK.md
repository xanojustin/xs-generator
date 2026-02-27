# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 19:35 PST] - Math operation naming confusion

**What I was trying to do:** Implement a sliding window algorithm that decrements a counter when shrinking the window

**What the issue was:** I used `math.subtract` based on my intuition about what the operation should be called, but the validator reported that only `add`, `div`, `mod`, `mul`, `sub`, and `bitwise` are valid math operations.

**Why it was an issue:** The error message was clear about what tokens were expected, but I had to guess that `sub` was short for subtract. The naming convention is inconsistent - `add` is the full word but `sub` is abbreviated. This is a minor friction point.

**Potential solution:** Consider supporting both `math.subtract` and `math.sub` as aliases, or document the abbreviated naming convention more prominently in the quick reference.

---

## [2026-02-26 19:35 PST] - foreach loop index access unclear

**What I was trying to do:** Calculate the window size in a foreach loop using the current index

**What the issue was:** I used `$each.index` based on documentation patterns, but I wasn't 100% certain this was the correct syntax for accessing the loop index. The documentation mentions `each as $item` for the value but doesn't explicitly show how to access the index.

**Why it was an issue:** I had to infer the index access pattern from limited examples. It would be helpful to have explicit documentation on loop variable access patterns.

**Potential solution:** Add a clear example in the functions documentation showing both value and index access: `each as $item` with `$each.index` for the position.
