# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-22 11:05 PST] - MCP Tool Parameter Passing

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` MCP tool

**What the issue was:** The `mcporter` CLI wrapper had trouble passing parameters correctly to the MCP tool. Using `--file_paths` or `--directory` flags resulted in the flags being interpreted as XanoScript code instead of parameters.

**Why it was an issue:** Could not validate files through mcporter's standard CLI interface. Had to bypass mcporter and directly send JSON-RPC requests to the MCP server via stdio.

**Potential solution (if known):** 
- mcporter should properly handle named parameters and convert them to the MCP JSON-RPC format
- Alternatively, document the raw JSON-RPC approach as the recommended method for complex parameters

**Workaround used:**
```bash
echo '{"jsonrpc": "2.0", "method": "tools/call", "params": {"name": "validate_xanoscript", "arguments": {"file_paths": ["run.xs", "function/next_greater_element.xs"]}}, "id": 1}' | npx -y @xano/developer-mcp
```

---

## [2025-02-22 11:05 PST] - xanoscript_docs Topic Filtering

**What I was trying to do:** Get specific documentation about functions and run jobs by calling `xanoscript_docs` with different topic parameters

**What the issue was:** Regardless of which topic was requested ("functions", "run", "quickstart"), the MCP returned identical general documentation that didn't include specific syntax patterns for those constructs.

**Why it was an issue:** Expected detailed syntax documentation for specific topics (like how to write a `run.job` block or detailed function patterns) but only received high-level general documentation.

**Potential solution (if known):** 
- Ensure the MCP properly filters documentation based on the topic parameter
- If topics aren't implemented yet, remove the parameter or document that only general docs are available

**Workaround used:** Had to reference existing implementations in the `~/xs/` directory to understand proper syntax patterns.

---

## [2025-02-22 11:05 PST] - Missing Array Update Operations

**What I was trying to do:** Update a specific index in an array (for the result array in the next greater element algorithm)

**What the issue was:** XanoScript doesn't appear to have direct array index assignment like `$result[$idx] = $value`. Had to rebuild the entire array to "update" one element.

**Why it was an issue:** Had to write verbose code with while loops to create a new array, copying all elements except the one being updated:
```xs
var $new_result { value = [] }
var $j { value = 0 }
while ($j < ($result|count)) {
  each {
    conditional {
      if ($j == $top_idx) {
        var $new_result { value = $new_result|merge:[$current_num] }
      }
      else {
        var $new_result { value = $new_result|merge:[$result[$j]] }
      }
    }
    var.update $j { value = $j + 1 }
  }
}
var $result { value = $new_result }
```

**Potential solution (if known):** 
- Consider adding array index assignment syntax: `var.update $result[$idx] { value = $new_value }`
- Or add a filter like `$result|set:$idx:$value` that returns a new array with the updated value

---

## [2025-02-22 11:05 PST] - Missing Stack Pop Operation

**What I was trying to do:** Pop the last element from a stack array

**What the issue was:** No direct `pop` filter or operation available. Had to manually rebuild the array without the last element using a while loop.

**Why it was an issue:** Verbose code for a common stack operation:
```xs
var $new_stack { value = [] }
var $k { value = 0 }
while ($k < (($stack|count) - 1)) {
  each {
    var $new_stack { value = $new_stack|merge:[$stack[$k]] }
    var.update $k { value = $k + 1 }
  }
}
var $stack { value = $new_stack }
```

**Potential solution (if known):** 
- Add a `pop` filter that returns array without last element: `$stack|pop`
- Add a `slice` filter: `$stack|slice:0:-1`
- Or document the recommended pattern for stack operations

---

## [2025-02-22 11:05 PST] - Boolean Logic in While Conditions

**What I was trying to do:** Write a while loop with multiple conditions: `while (($stack|count) > 0 && $continue_checking)`

**What the issue was:** The `&&` operator didn't work as expected in the while condition. The docs mention expressions use backticks for complex logic, but it wasn't clear if that applies to while conditions.

**Why it was an issue:** Unclear syntax for compound boolean expressions in control flow statements.

**Potential solution (if known):** 
- Document boolean operators (`&&`, `||`, `!`) clearly in the syntax documentation
- Clarify whether backticks are required for compound expressions in conditions

**Workaround used:** Used a flag variable `$continue_checking` combined with the count check in the while loop condition.

---

## Summary

Overall, the XanoScript language is expressive and the structure is clear. The main pain points were:
1. MCP tooling issues (parameter passing, docs not filtering by topic)
2. Verbose array manipulation (no index assignment, no pop operation)
3. Unclear boolean operator syntax in conditions

The validation tool itself worked great once the correct calling convention was found!
