# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 13:35 PST] - Issue 1: Array Type Syntax Documentation

**What I was trying to do:** Define a 2D array input parameter for a grid/matrix problem

**What the issue was:** I assumed `text[][] board` would work for a 2D string array (similar to TypeScript/Java syntax). The validation error was:
```
[Line 5, Column 11] Expecting token of type --> Identifier <-- but found --> '[' <--
```

**Why it was an issue:** No obvious documentation on how to declare multi-dimensional arrays. Had to look at existing examples (rotting-oranges) to discover that `json` type is used instead.

**Potential solution:** The quick_reference docs could include a type mapping table showing:
| Other Language | XanoScript |
|---------------|------------|
| `string[][]` | `json` |
| `number[][]` | `json` |
| `T[][]` | `json` |

---

## [2026-02-25 13:40 PST] - Issue 2: Function Call Syntax

**What I was trying to do:** Call a helper function from within another function

**What the issue was:** I wrote `var $result { value = helper_function(arg1, arg2) }` which is natural in most languages. Got error:
```
Expecting: Expected an expression but found: 'helper_function'
```

**Why it was an issue:** The `quick_reference` for functions only shows the definition syntax, not the calling syntax. I had to guess that `function.run` might be the right approach.

**Potential solution:** Add a "Calling Functions" section to the `functions` quick_reference:
```xs
// Call a function and capture result
function.run "function-name" {
  input = { key: value }
} as $result
```

---

## [2026-02-25 13:45 PST] - Issue 3: One Function Per File Rule

**What I was trying to do:** Define helper functions in the same file as the main function (common pattern in many languages)

**What the issue was:** Got error:
```
[Line 162, Column 1] Redundant input, expecting EOF but found: // Helper function...
```

**Why it was an issue:** This is a strict architectural constraint of XanoScript that wasn't immediately clear from the error message. The suggestion about "bool vs boolean" was misleading - the real issue was multiple functions in one file.

**Potential solution:** 
1. Improve error message to say something like: "Only one function definition allowed per .xs file. Move additional functions to separate files."
2. Document this clearly in the `functions` topic with a note like:
   > **⚠️ One Function Per File:** Each `.xs` file can contain exactly one function definition. Create multiple files for helper functions.

---

## [2026-02-25 13:50 PST] - Issue 4: File Paths Parameter Parsing

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP tool interpreted each character of the path as a separate file path:
```
File not found: U
File not found: s
File not found: e
File not found: r
...
```

**Why it was an issue:** The tool expected an array but received a string. The mcporter CLI syntax `file_paths=path1,path2` doesn't properly convert to a JSON array.

**Potential solution:** The MCP could either:
1. Accept comma-separated strings and parse them
2. Better document that `file_paths` requires actual JSON array format
3. The mcporter wrapper could auto-convert comma-separated values to arrays

Workaround: Use `directory` parameter instead for batch validation.

---

## [2026-02-25 13:55 PST] - Issue 5: Naming Convention Discovery

**What I was trying to do:** Follow project naming conventions

**What the issue was:** Had to discover through trial and error that:
- Function names use hyphens: `surrounded-regions` (not `surrounded_regions`)
- File names match function names

**Why it was an issue:** No explicit documentation on naming conventions in the quick_reference.

**Potential solution:** Add a "Naming Conventions" section:
```
### Naming Conventions
- Function names: lowercase with hyphens (`my-function`)
- File names: match function name (`my-function.xs`)
- Variable names: snake_case with $ prefix (`$my_variable`)
```

---

## General Observations

### What Worked Well
1. The validation tool provides helpful line/column error locations
2. The quick_reference mode is concise and useful
3. The `directory` parameter for batch validation works well
4. Error recovery was straightforward once I understood the constraints

### Suggested Documentation Improvements
1. Add a "Common Pitfalls" section to quickstart covering:
   - Array types → use `json`
   - Function calls → use `function.run`
   - One function per file
   - Input access → always `$input.field`

2. Include complete mini-examples showing the full file structure

3. Document the relationship between function names and file paths
