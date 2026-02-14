# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 10:18 PST] - Ternary Operator Not Supported

**What I was trying to do:**
Conditionally set a variable value based on input presence using a ternary operator (common pattern in most languages).

**What the issue was:**
Used the ternary syntax `condition ? value_if_true : value_if_false` which resulted in a validation error: "Expecting --> } <-- but found --> '?' <--"

**Why it was an issue:**
The quickstart documentation mentions using `??` for null coalescing and shows conditional blocks, but doesn't explicitly state that ternary operators aren't supported. I had to rewrite using verbose `conditional { if {...} }` blocks.

**Potential solution:**
Add explicit documentation about what operators are NOT supported, or add ternary operator support to the language.

---

## [2026-02-14 10:19 PST] - Object Literal Syntax Confusion

**What I was trying to do:**
Create an object literal with multiple properties like `{ key1: value1, key2: value2 }`.

**What the issue was:**
Used commas between object properties which caused validation error: "Expecting --> } <-- but found --> ',' <--"

**Why it was an issue:**
Most programming languages (JSON, JavaScript, Python dicts) require commas between object properties. XanoScript uses newlines without commas, which is unusual.

**Potential solution:**
Make the object syntax clearer in the documentation with a big warning that commas are NOT used between properties. Show a "wrong vs right" example.

---

## [2026-02-14 10:20 PST] - $response is a Reserved Variable Name

**What I was trying to do:**
Create a variable named `$response` to store the API response data.

**What the issue was:**
Validation error: "'$response' is a reserved variable name and should not be used as a variable."

**Why it was an issue:**
The documentation mentions `$response` is reserved for function response blocks, but I didn't realize I couldn't use it as a stack variable. Had to rename to `$result`.

**Potential solution:**
Add a clear list of ALL reserved variable names to the syntax documentation ($response, $input, $auth, $env, etc.).

---

## [2026-02-14 10:17 PST] - validate_xanoscript Requires Code Parameter

**What I was trying to do:**
Validate an .xs file by passing the file path to the validate_xanoscript tool.

**What the issue was:**
Tried using `file="path/to/file.xs"` but got error: "'code' parameter is required". Had to read file content and pass as `code` parameter.

**Why it was an issue:**
The tool would be more convenient if it accepted either a file path OR code directly. Reading file content into a shell variable is cumbersome and prone to escaping issues.

**Potential solution:**
Add a `file` parameter alternative to the validate_xanoscript tool, or make the tool read from stdin when code="-" is passed.

---

## [2026-02-14 10:17 PST] - Shell Escaping Issues with Code Parameter

**What I was trying to do:**
Pass multi-line XanoScript code via the `code` parameter in mcporter call.

**What the issue was:**
Complex XanoScript with quotes, newlines, and special characters caused shell parsing errors when trying to pass directly on command line.

**Why it was an issue:**
Had to work around with `CODE=$(cat file.xs)` pattern which is clunky.

**Potential solution:**
Support stdin input or file-based validation to avoid shell escaping complexity.

---

## General Observations

1. **Documentation is good but scattered** - Had to call xanoscript_docs multiple times with different topics to get complete information.

2. **Error messages are helpful** - The validator gives clear line/column numbers and expected vs found tokens.

3. **MCP server was already installed** - The @xano/developer-mcp package was already available, which was convenient.
