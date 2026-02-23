# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 07:05 PST] - Slice filter doesn't support negative indices

**What I was trying to do:** Pop the last element from a stack array using the slice filter with a negative index: `$stack|slice:0,-1`

**What the issue was:** The XanoScript parser doesn't support negative indices in the slice filter. The validation error was:
```
[Line 34, Column 38] Expecting --> } <-- but found --> '-1' <----
```

**Why it was an issue:** In many programming languages (Python, JavaScript, etc.), negative indices are commonly used to reference elements from the end of an array. I expected `slice:0,-1` to return all elements except the last one (a common "pop" operation pattern).

**Potential solution (if known):** 
1. Document clearly that slice filter only accepts positive integers
2. Consider supporting negative indices in the slice filter to match developer expectations from other languages
3. Or provide a dedicated `pop` filter for arrays that removes and returns the last element

The workaround required manually iterating through the array and building a new array without the last element, which is verbose:
```xs
var $new_stack { value = [] }
var $j { value = 0 }
while ($j < (($stack|count) - 1)) {
  each {
    var $new_stack { value = $new_stack|merge:[$stack[$j]] }
    var.update $j { value = $j + 1 }
  }
}
var $stack { value = $new_stack }
```

---

## [2026-02-23 07:03 PST] - MCP validation tool expects file-based parameters

**What I was trying to do:** Call the `validate_xanoscript` tool with a `files` array containing paths and content (similar to how many AI coding tools work)

**What the issue was:** The tool actually expects `file_path`, `file_paths`, `directory`, or `code` - not a `files` array. My first attempt used a JSON structure with `files: [{path, content}]` which wasn't valid.

**Why it was an issue:** The tool schema wasn't immediately clear from the initial documentation call. I had to discover the correct parameter names by examining the full schema with `--schema`.

**Potential solution (if known):** 
The documentation is actually quite good once you know to use `--schema`. Perhaps a quick example in the initial xanoscript_docs output showing how to call validate_xanoscript would help.

---
