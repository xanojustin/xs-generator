# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 20:32 PST] - Array element updates not supported

**What I was trying to do:** Implement the Union-Find data structure using arrays to store parent pointers and ranks (standard implementation)

**What the issue was:** XanoScript doesn't support updating array elements at specific indices. I tried using `array.splice` (common in JavaScript) but it doesn't exist in XanoScript.

**Why it was an issue:** The Union-Find algorithm requires updating parent pointers during path compression and union operations. Without array element updates, I had to completely restructure the solution to use objects with string keys instead of arrays.

**Potential solution (if known):** 
- Add `array.set` filter to update element at index: `$arr|set:0:"new_value"`
- Or add `array.splice` for more complex operations
- Document this limitation clearly in the array-filters documentation with a workaround example

---

## [2025-03-02 20:33 PST] - Converting between integers and strings for object keys

**What I was trying to do:** Use integer indices as object keys (e.g., parent[0], parent[1])

**What the issue was:** Object keys in XanoScript are strings, but my algorithm uses integer indices. I had to repeatedly convert integers to text using `$i|to_text` to use as object keys.

**Why it was an issue:** This made the code more verbose and harder to read. Each array access required:
1. Convert index to text: `var $key { value = $index|to_text }`
2. Access with key: `$parent|get:$key`

**Potential solution (if known):**
- Allow automatic type coercion in object get/set filters (integers auto-convert to string keys)
- Or provide a shorthand: `$obj|get_int:$index` that handles the conversion internally

---

## [2025-03-02 20:30 PST] - Validating multiple files at once

**What I was trying to do:** Validate multiple .xs files in a single MCP call

**What the issue was:** The `file_paths` parameter expects an array format, but it's not immediately clear how to pass arrays via the CLI. I initially tried comma-separated string which failed.

**Why it was an issue:** Had to figure out the correct JSON format for the `--args` parameter:
```bash
mcporter call xano.validate_xanoscript --args '{"file_paths": ["/path/to/file1.xs", "/path/to/file2.xs"]}'
```

**Potential solution (if known):**
- Accept comma-separated paths as a convenience: `file_paths="file1.xs,file2.xs"`
- Or provide a clearer example in the tool description

---

## [2025-03-02 20:35 PST] - Missing array manipulation documentation

**What I was trying to do:** Find the complete list of array operations available

**What the issue was:** The `syntax/array-filters` documentation lists many filters but doesn't explicitly state that array element updates are not supported. I spent time looking for a way to update array elements before realizing it's not possible.

**Why it was an issue:** Wasted time searching for non-existent functionality and had to refactor the solution significantly.

**Potential solution (if known):**
- Add a "Not Supported" section to array-filters documentation listing common operations that don't exist (set by index, splice, etc.)
- Provide recommended workarounds (use objects instead of arrays for mutable collections)

---

## [2025-03-02 20:36 PST] - While loop syntax confusion

**What I was trying to do:** Implement a while loop for the find operation with path compression

**What the issue was:** Initially placed the while loop directly in the stack without the `each` block, which caused syntax errors.

**Why it was an issue:** The documentation says "While loop outside of stack block" is wrong, but the correct pattern (with `each` block inside) wasn't immediately obvious from the quick reference.

**Potential solution (if known):**
- Add a clear while loop example to the essentials documentation showing the `each` requirement

---