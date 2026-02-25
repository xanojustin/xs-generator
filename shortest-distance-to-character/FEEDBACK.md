# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 06:33 PST] - Filter validation in input blocks

**What I was trying to do:** Add a filter to ensure the target character `c` is a single character by using `filters=strlen:1`

**What the issue was:** The validator rejected `text c filters=strlen:1` with error: "Filter 'strlen' cannot be applied to input of type 'text'"

**Why it was an issue:** I expected to be able to use filters in the input block to validate that a text input has a specific length. This is a common validation pattern (e.g., ensuring a single character input).

**Potential solution (if known):** Either:
1. Allow `strlen` filter in input declarations for text validation
2. Document which filters are allowed in input blocks vs which can only be used in stack logic
3. Provide an alternative way to validate text length in inputs (maybe a `length` constraint or `minlength`/`maxlength` filters)

---

## [2026-02-25 06:35 PST] - mcporter parameter passing documentation

**What I was trying to do:** Call the `validate_xanoscript` tool with the `file_paths` parameter

**What the issue was:** I initially struggled with the correct syntax for passing array parameters to mcporter. The command `mcporter call xano.validate_xanoscript file_paths:='["path1", "path2"]'` didn't work.

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing because I was providing `file_paths`. The issue was with how mcporter parses arguments, not with the parameter name.

**Potential solution (if known):** 
1. Add examples in the MCP tool descriptions showing the exact mcporter syntax for array parameters
2. Consider accepting comma-separated values as an alternative to JSON arrays for simpler cases

**Workaround found:** Using `directory=` parameter worked well for validating all files in a folder.

---

## [2026-02-25 06:36 PST] - No filter for array element access

**What I was trying to do:** Update an element at a specific index in an array during the second pass of the algorithm

**What the issue was:** XanoScript doesn't seem to have a direct way to set an array element at a specific index. I had to work around this by slicing the array before and after the target index and concatenating.

**Why it was an issue:** The code becomes verbose and potentially inefficient:
```xs
var $before { value = ($result|slice:0:$i) }
var $after { value = ($result|slice:($i + 1):$len) }
var.update $result { value = $before ~ [$dist_from_right] ~ $after }
```

**Potential solution (if known):** 
1. Add a `set` filter for arrays that works like the object `set` filter: `$arr|set:$index:$value`
2. Or add an `array.update` operation similar to `var.update`

---
