# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 21:05 PST] - Reserved variable names not documented in quick reference

**What I was trying to do:** Create a function that returns a result array

**What the issue was:** I named my variable `$result` which is reserved. The error message was helpful (`"$result" is a reserved variable name. Try a different name like "$my_result"`), but I didn't know about reserved variable names from the quick reference docs.

**Why it was an issue:** Had to rename variables after validation failure. Would be better to know upfront.

**Potential solution:** Include a list of reserved variable names (`$response`, `$output`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result`, `$index`) in the quick reference documentation.

---

## [2025-03-03 21:10 PST] - Array element update syntax unclear

**What I was trying to do:** Update a specific element in an array by index (like `arr[i] += value`)

**What the issue was:** I tried using `var.update $arr { index = $i, value = $new_val }` which seemed intuitive, but this syntax doesn't exist for arrays. The error was confusing - it said "The argument 'index' is not valid in this context".

**Why it was an issue:** I had to completely change my approach from updating elements in place to rebuilding the entire array each time using `foreach` and conditionals, which is much more verbose.

**Potential solution:** 
1. Document clearly that arrays are immutable and elements cannot be updated by index
2. Provide an example pattern for "updating" array elements (rebuild with foreach + conditional)
3. Consider adding an array filter like `|set:index:value` for functional updates

---

## [2025-03-03 21:15 PST] - Foreach index syntax confusion

**What I was trying to do:** Get both index and value in a foreach loop (`each as $idx, $val`)

**What the issue was:** Many languages support `for i, val in enumerate(arr)` or similar. I assumed XanoScript supported `each as $idx, $val` but this is invalid syntax.

**Why it was an issue:** Had to add manual index tracking with a separate counter variable, making the code more verbose and error-prone.

**Potential solution:** 
1. Document the foreach syntax more explicitly showing only `each as $val` is supported
2. Consider adding `each as $idx, $val` syntax for convenience
3. Or provide an `|enumerate` filter that returns `[{idx: 0, val: ...}, ...]`

---

## [2025-03-03 21:20 PST] - Validating multiple files requires separate calls

**What I was trying to do:** Validate both `run.xs` and `function/range_addition.xs` at once

**What the issue was:** I made two separate `validate_xanoscript` calls. While this works, it would be more convenient to validate an entire directory or multiple files in one call.

**Why it was an issue:** Minor inconvenience - had to make two tool calls instead of one.

**Potential solution:** The tool actually supports `file_paths` array and `directory` parameters! I should have used `directory` to validate the entire exercise folder at once. Document this better or provide examples.

---

## [2025-03-03 21:25 PST] - Range operator with variables

**What I was trying to do:** Create an array of zeros with length based on input: `(1..$input.length)|map:0`

**What the issue was:** I wasn't sure if the range operator `(start..end)` works with variables or only literals.

**Why it was an issue:** Had to guess/test if this would work. It did work, which is great!

**Potential solution:** Add an example using variables in the range operator documentation: `($start..$end)` is shown in the quick reference, but easy to miss.

---
