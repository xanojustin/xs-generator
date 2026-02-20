# MCP/XanoScript Issues and Feedback

## Issue #1: MCP Tools Unavailable

**Date:** 2026-02-20  
**Severity:** Medium - Unable to perform automated validation

### Problem Description
The Xano MCP tools (`xanoscript_docs` and `validate_xanoscript`) referenced in the task specification are not available through the current OpenClaw CLI environment.

### Attempted Access Methods

1. **Direct MCP command:**
   ```
   openclaw mcp xanoscript_docs
   Result: MCP tool not available via openclaw
   ```

2. **NPX MCP package:**
   ```
   npx -y @anthropic-ai/mcp@latest list
   Result: MCP not available via npx
   ```

3. **OpenClaw CLI help:**
   - No `mcp` subcommand listed in `openclaw --help`
   - No `tools` subcommand for tool listing

### Resolution
MCP tools were located through the `mcporter` skill:
```bash
mcporter list                    # Lists available MCP servers
mcporter list xano --schema      # Shows xano server tools and schema
mcporter call xano.validate_xanoscript file_paths='["/path/to/file.xs"]'
```

---

## Issue #2: Syntax Error - `each` Blocks in Conditionals

**Date:** 2026-02-20  
**Severity:** Low - Documentation gap

### Problem Description
Using `each` blocks inside `conditional` statements causes a syntax error.

### Error Message
```
[Line 57, Column 13] Expecting --> } <-- but found --> 'each' <--
```

### Solution
`each` blocks should only be used within loops (`while`, `for`), not inside `conditional` blocks. Inside `conditional { if (...) { ... } }`, write statements directly without `each` wrapper.

**Incorrect:**
```xs
conditional {
  if ($condition) {
    each {
      var $x { value = 1 }
      array.push $arr { value = $x }
    }
  }
}
```

**Correct:**
```xs
conditional {
  if ($condition) {
    var $x { value = 1 }
    array.push $arr { value = $x }
  }
}
```

---

## Issue #3: Syntax Error - Math Operation Names

**Date:** 2026-02-20  
**Severity:** Low - Documentation gap

### Problem Description
Used `math.subtract` instead of the correct `math.sub`.

### Error Message
```
[Line 66, Column 18] Expecting: one of these possible Token sequences:
  1. [add]
  2. [div]
  3. [mod]
  4. [mul]
  5. [sub]
  6. [bitwise]
but found: 'subtract'
```

### Solution
Use short-form math operation names:
- `math.add` ✅
- `math.sub` ✅ (not `math.subtract`)
- `math.mul` (not `math.multiply`)
- `math.div` (not `math.divide`)
- `math.mod`
- `math.bitwise`

---

## General Feedback

### MCP Tools Work Well
Once discovered, the MCP tools work excellently:
- Clear error messages with line/column numbers
- Helpful suggestions in error messages
- JSON output option for programmatic use

### Documentation Request
Would be helpful to have:
1. Clear documentation on `each` block usage constraints
2. Complete list of valid math operation names
3. Quick reference card for common syntax patterns

### Files Affected
- `function/spiral_matrix.xs` - Fixed both issues above
