# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 18:05 PST] - MCP file_paths Argument Parsing Issue

**What I was trying to do:** Validate multiple XanoScript files using the `validate_xanoscript` tool with the `file_paths` parameter.

**What the issue was:** When passing a comma-separated list of file paths to `file_paths`, the MCP server parsed each character as a separate file path. For example, passing `"~/xs/matrix-diagonal-sum/run.xs,~/xs/matrix-diagonal-sum/function/matrix_diagonal_sum.xs"` resulted in the server trying to validate individual characters like `~`, `x`, `s`, `m`, `a`, `t`, `r`, etc. as separate files.

**Why it was an issue:** This made the `file_paths` parameter unusable for batch validation. The error output was extremely verbose (128 "files" reported as invalid) and didn't provide useful feedback about the actual files.

**Workaround used:** Used the `directory` parameter instead, which worked correctly and validated all `.xs` files in the directory.

**Potential solution:** The MCP server should properly parse comma-separated values in the `file_paths` array parameter, or the documentation should clarify the expected format (perhaps it expects a JSON array rather than a comma-separated string).

---

## [2025-02-25 18:06 PST] - Documentation for 2D Array Input Type

**What I was trying to do:** Define the input type for a square matrix (2D array of integers).

**What the issue was:** The XanoScript documentation doesn't clearly specify how to declare a 2D array type in the `input` block. I tried `int[][] matrix` but wasn't sure if that was valid syntax.

**Why it was an issue:** Without clear guidance on multi-dimensional arrays, I had to use the generic `object` type with a description instead of a properly typed 2D array.

**What I used instead:** 
```xs
input {
  object matrix {
    description = "A square matrix (2D array of integers)"
  }
}
```

**Potential solution:** Add documentation about multi-dimensional array types (e.g., `int[][]`, `text[][]`) to the types documentation, or clarify if nested arrays should use `object` or `json` types.

---

## [2025-02-25 18:07 PST] - Array Element Access Pattern

**What I was trying to do:** Access elements in a 2D array using nested `get` filters: `matrix[i][j]`.

**What the issue was:** It wasn't immediately clear from the documentation how to chain array/object access. I needed to use `$input.matrix|get:$i|get:$j` but had to infer this from the single-level examples.

**Why it was an issue:** Multi-level data structure access is common in matrix problems, and clearer examples would help developers write correct code faster.

**Potential solution:** Add examples of nested/chained filter access in the documentation, such as:
```xs
// Accessing nested array elements
var $element { value = $matrix|get:$row_idx|get:$col_idx }

// Accessing nested object properties
var $name { value = $user|get:"profile"|get:"name" }
```
