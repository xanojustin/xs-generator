# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 00:30 PST] - Cannot modify input array elements with var.update

**What I was trying to do:** Implement the two-pointer technique for removing duplicates, which requires modifying array elements in-place.

**What the issue was:** I tried to use `var.update $input.nums[$i] { value = $input.nums[$idx] }` to update an element in the input array, but got this error:
```
[Line 28, Column 24] Expecting: expecting variable (e.g. $variable or $var.variable)
but found: '$input'
```

**Why it was an issue:** The documentation mentions that `$input` is a reserved variable, but it wasn't immediately clear that this means you cannot modify elements of input arrays. I had to create a working copy (`var $working_nums { value = $input.nums }`) and modify that instead, which is slightly less efficient.

**Potential solution (if known):** The error message was actually helpful! It clearly identified that `$input` is reserved and suggested a different name. However, it might be worth mentioning in the `functions` documentation that input arrays cannot be modified element-by-element and require a copy if in-place modification is needed.

