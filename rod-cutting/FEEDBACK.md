# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 14:05 PST] - Input block filters syntax confusion

**What I was trying to do:** Add input validation with a `min:0` filter on the `rod_length` input field.

**What the issue was:** I initially wrote:
```xs
int rod_length { description = "Length of the rod to cut", filters = min:0 }
```

The validator gave me errors:
1. `The argument 'filters' is not valid in this context`
2. `Expecting: Expected a null but found: 'min'`

**Why it was an issue:** The documentation shows filters inline for simple cases (`int quantity filters=min:0`) and I assumed I could combine it with a description block using comma separation like object literal syntax. The error messages weren't clear about the correct syntax.

**Potential solution:** The error message could suggest the correct syntax: "filters must come before the description block, not inside it" or "use: `int rod_length filters=min:0 { description = ... }`"

---

## [2025-02-25 14:08 PST] - While loop body structure confusion

**What I was trying to do:** Create nested while loops for the dynamic programming algorithm.

**What the issue was:** I wrote the loop increment outside the `each` block:
```xs
while ($j <= $i) {
  each {
    // loop body
  }
  var.update $j { value = $j + 1 }  // <-- outside each
}
```

This caused: `Expecting --> } <-- but found --> 'var'`

**Why it was an issue:** I didn't realize that `each` is the actual loop body container in XanoScript while loops. The `while` only provides the condition check, and ALL loop body statements must be inside `each`. Coming from other languages where the braces after `while` contain the body, this was unexpected.

**Potential solution:** 
1. Better documentation example showing a complete while loop with increment inside `each`
2. A more descriptive error like "Loop body statements must be inside the 'each' block"
3. Consider allowing statements after `each` inside `while` (though this would be a language change)

---

## [2025-02-25 14:10 PST] - No issues with validate_xanoscript tool

**What I was trying to do:** Validate my XanoScript files using the MCP.

**What the issue was:** None - the validation tool worked well and provided helpful line/column numbers.

**Why it was an issue:** N/A

**Potential solution:** The validation tool is good. It would be even better if it could suggest fixes for common errors (like the input filters syntax issue above).

---
