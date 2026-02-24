# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 06:05 PST] - mcporter Parameter Passing Issue

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The mcporter CLI tool had issues passing parameters to the validate_xanoscript function. When using `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'`, it kept returning:
```
Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

**Why it was an issue:** This blocked validation until I found a workaround using direct JSON-RPC calls via npx.

**Workaround found:** Using direct JSON-RPC via npx worked:
```bash
echo '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"validate_xanoscript","arguments":{"file_path":"/path/to/file.xs"}}}' | npx -y @xano/developer-mcp
```

**Potential solution:** The mcporter tool may need fixes in how it passes JSON object parameters to MCP tools. It seems to be wrapping or escaping the parameters incorrectly.

---

## [2026-02-24 06:03 PST] - xanoscript_docs Generic Response

**What I was trying to do:** Get specific XanoScript syntax documentation for writing the partition labels function

**What the issue was:** The `xanoscript_docs` function returned the same general documentation regardless of the topic parameter. I tried topics like "quickstart", "functions", "syntax", and "run" but all returned nearly identical high-level documentation.

**Why it was an issue:** I couldn't get detailed syntax information like:
- Complete list of available filters
- How to iterate with index access
- Object/dictionary manipulation methods
- Array slice operations

**Workaround found:** I had to examine existing implementations in `~/xs/` to understand the actual syntax patterns used in working code.

**Potential solution:** The MCP should return topic-specific detailed documentation, especially for:
- Filter reference (all available filters and their signatures)
- Loop patterns with examples
- Data structure operations (objects, arrays)
- Expression syntax and operators

---

## [2026-02-24 06:02 PST] - No Array Pop/Slice Operations

**What I was trying to do:** Implement stack operations for the partition labels algorithm (though I ended up not needing a stack)

**What the issue was:** Looking at existing code like `valid_parentheses`, I saw that popping from an array requires manual reconstruction:
```xs
// To "pop" from stack, you have to create a new array:
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

**Why it was an issue:** This is verbose and inefficient for a common operation. The partition labels problem didn't need a stack, but many problems do.

**Potential solution:** Add filters for:
- `$array|slice:start:end` - Array slicing
- `$array|pop` - Remove last element
- `$array|shift` - Remove first element
- `$array|remove:index` - Remove at specific index

---

## General Observation

The XanoScript language is quite readable and the structure is consistent. The main friction points are:
1. Tooling issues with parameter passing
2. Limited documentation accessible via MCP
3. Some common operations (array manipulation) require verbose workarounds

The validation tool works well once you can call it properly - it caught no errors in my initial implementation which suggests either the syntax is intuitive or I learned well from examples.
