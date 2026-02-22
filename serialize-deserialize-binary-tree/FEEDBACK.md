# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 02:35 PST] - Empty object schema syntax not supported

**What I was trying to do:** Define a nested object schema for a binary tree node with optional left and right children.

**What the issue was:** I tried to use this syntax:
```xs
object tree? {
  schema {
    int val
    object left? { }
    object right? { }
  }
}
```

The empty braces `{ }` for the nested object schema caused a parse error:
```
[Line 8, Column 24] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '}'
```

**Why it was an issue:** There's no documented way to define recursive/nested object schemas. The empty `{}` syntax seems like it should work for "any object" but doesn't.

**Potential solution (if known):** 
1. Allow empty `{ }` to mean "any object" in schema definitions
2. Document that `json` type should be used for complex/nested objects instead of trying to define deep schemas
3. The MCP's suggestion to use `json` was helpful and correct

---

## [2026-02-22 02:38 PST] - No recursion in XanoScript makes tree algorithms challenging

**What I was trying to do:** Implement recursive tree traversal for serialization/deserialization.

**What the issue was:** XanoScript doesn't support recursive function calls. I had to convert the natural recursive preorder traversal algorithm to an iterative approach using explicit stacks.

**Why it was an issue:** Tree algorithms are traditionally expressed recursively. The iterative conversion:
1. Makes the code harder to read and understand
2. Requires manual stack management which is error-prone
3. Increases code complexity significantly

**Example of the complexity:**
The recursive pseudocode:
```
function serialize(node):
  if node == null: return "null"
  return node.val + "," + serialize(node.left) + "," + serialize(node.right)
```

Became ~100 lines of iterative stack manipulation code.

**Potential solution (if known):**
1. Document that XanoScript doesn't support recursion
2. Provide patterns/examples for common recursive-to-iterative conversions
3. Consider adding recursion support (with depth limits) for function calls

---

## [2026-02-22 02:40 PST] - Array slicing for updates is verbose

**What I was trying to do:** Update an element in the middle of an array (updating a node after setting its children).

**What the issue was:** XanoScript doesn't have direct array element assignment. I had to do:
```xs
var $before_left {
  value = $nodes|slice:0:$parent_idx
}
var $after_left {
  value = $nodes|slice:($parent_idx + 1)
}
var $nodes_with_left {
  value = $before_left|merge:[$parent_with_left]|merge:$after_left
}
var.update $nodes {
  value = $nodes_with_left
}
```

**Why it was an issue:** This is very verbose for what should be a simple operation. It also creates multiple temporary arrays.

**Potential solution (if known):**
1. Add `array.update $arr[$index] { value = ... }` syntax
2. Or allow `var.update $nodes[$parent_idx] { value = ... }`

---