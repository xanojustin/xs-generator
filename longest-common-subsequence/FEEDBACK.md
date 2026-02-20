# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 09:05 PST] - No Issues Encountered

**What I was trying to do:** Create a complete XanoScript coding exercise for Longest Common Subsequence (LCS)

**What the issue was:** No issues encountered - all files passed validation on the first attempt.

**Why it was an issue:** N/A - successful implementation

**Potential solution (if known):** N/A

---

## General Observations

### What Worked Well

1. **MCP Documentation Access**: The `xanoscript_docs` tool provided clear examples for functions and run jobs
2. **Existing Examples**: The `edit-distance` example in the repo was extremely helpful for understanding:
   - How to work with 2D arrays (arrays of arrays)
   - Dynamic programming patterns in XanoScript
   - Variable scoping and updates within loops

3. **Validation Tool**: The `validate_xanoscript` tool provided clear feedback and correctly identified all 3 files as valid

### Patterns Learned

1. **2D Array Access Pattern** (critical for DP problems):
   ```xs
   // Get a row from the DP matrix
   var $row { value = $dp|get:$i }
   // Get/set a value in that row
   var $val { value = $row|get:$j }
   var $updated_row { value = $current_row|set:$j:$new_val }
   var $dp { value = $dp|set:$i:$updated_row }
   ```

2. **Character Access in Strings**:
   ```xs
   var $char { value = $input.str1|substr:$index:1 }
   ```

3. **Test Function Pattern**:
   - Run job calls a test function (e.g., `lcs_tests`)
   - Test function calls the actual function multiple times with different inputs
   - Results are compiled into an object with `expected`, `actual`, and `passed` fields

### Suggestions for MCP Improvement

None at this time - the tools worked as expected for this exercise.
