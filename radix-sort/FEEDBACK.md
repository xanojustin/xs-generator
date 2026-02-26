# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 10:05 PST] - Complex arithmetic expressions in while loop conditions

**What I was trying to do:** Write a while loop with a compound arithmetic expression as the condition for radix sort: `while (($max_num / $exp) > 0)`

**What the issue was:** The XanoScript parser threw an error when encountering the division operator `/` inside the while loop condition. The error message was confusing:
```
[Line 28, Column 29] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

The error message incorrectly suggested using "int" instead of "integer" for type declaration, which was unrelated to the actual issue.

**Why it was an issue:** I had to refactor the code to pre-compute the division result into a separate variable and update it each iteration, making the code less readable:
```xs
// Instead of:
while (($max_num / $exp) > 0) { ... }

// I had to write:
var $max_div_exp { value = $max_num / $exp }
while ($max_div_exp > 0) {
  // ... loop body ...
  var.update $max_div_exp { value = $max_num / $exp }
}
```

**Potential solution:** The parser should support arithmetic expressions inside while loop conditions, or the documentation should clearly state this limitation. The error message could also be more helpful by indicating that complex expressions aren't supported in conditions.

---

## [2025-02-26 10:06 PST] - validate_xanoscript file_paths parameter parsing

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated values as shown in the tool schema.

**What the issue was:** The command:
```
mcporter call xano.validate_xanoscript file_paths="/path/1,/path/2" 
```

Was interpreted character by character, producing errors like:
```
File not found: U
File not found: s
File not found: e
...
```

**Why it was an issue:** I had to run validation separately for each file, which is less efficient.

**Potential solution:** The MCP tool should properly parse comma-separated file paths, or support JSON array input format. The documentation could also clarify the expected format for multiple files.
