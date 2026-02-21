# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 18:05 PST] - Type naming confusion

**What I was trying to do:** Define an input parameter for an array of integers

**What the issue was:** Used `int_array` as the type, but XanoScript uses `int[]` syntax

**Why it was an issue:** The error message was helpful (suggested using "type[]"), but it took a validation failure to discover this. The quick_reference docs show `int[]` in some places but the specific syntax for array types in inputs wasn't obvious.

**Potential solution (if known):** Could have a more prominent section in the quick_reference specifically for "Array Type Declarations" showing `int[]`, `text[]`, `json[]`, etc.

---

## [2026-02-20 18:08 PST] - While loop requires `each` block

**What I was trying to do:** Write a standard while loop for the two-pointer algorithm

**What the issue was:** XanoScript's `while` loop requires an `each` block inside it, which is unusual syntax

**Why it was an issue:** The documentation shows `while` with `each` in examples, but doesn't explicitly state that `each` is REQUIRED. The error message "Expecting --> each <--" was clear, but the reason why isn't documented.

**Potential solution (if known):** The quick_reference for syntax should explicitly note that `while` loops must contain an `each` block, or show the complete syntax pattern:
```xs
while (condition) {
  each {
    // loop body
  }
}
```

---

## [2026-02-20 18:12 PST] - Cannot modify $input directly

**What I was trying to do:** Modify array elements using `$input.nums[$index] = value`

**What the issue was:** `$input` is reserved and cannot be used on the left side of assignments

**Why it was an issue:** The error message was helpful ("$input is a reserved variable name"), but this forces a copy of potentially large arrays just to modify them. For the "move zeros" problem which asks for in-place modification, this is semantically different.

**Potential solution (if known):** Document the immutability of `$input` more prominently in the functions documentation. Also, clarify if there's any way to do true in-place array modification.

---

## [2026-02-20 18:15 PST] - Array index assignment syntax unclear

**What I was trying to do:** Assign a value to a specific array index: `var $nums[$write_index] { value = 0 }`

**What the issue was:** This syntax is not valid in XanoScript - array index assignment doesn't work in `var` statements

**Why it was an issue:** This is a common pattern in other languages. The error message was cryptic (expecting various tokens but found '['). I had to completely change my approach from the two-pointer in-place algorithm to a functional filter/merge approach.

**Potential solution (if known):** 
1. Document that array elements cannot be assigned via index using `var`
2. If there's an alternative (like `array.set`), document it
3. The error message could be more helpful: "Array index assignment not supported, use array filters instead"

---

## [2026-02-20 18:18 PST] - array.filter requires parentheses

**What I was trying to do:** Use `array.filter $input.nums if (...)` 

**What the issue was:** The syntax requires parentheses around the array: `array.filter ($input.nums) if (...)`

**Why it was an issue:** The error message said "Expecting --> ( <-- but found --> '$input'" which was confusing because I thought `$input` was the problem (from the previous error). Actually it was the missing parentheses.

**Potential solution (if known):** The quick_reference for array functions shows:
```xs
array.filter $customer_ages if ($this > 18) as $adults
```
But this seems to require the variable directly, not `$input.field`. The documentation should clarify when parentheses are needed vs when the bare variable works.

---

## [2026-02-20 18:20 PST] - Range operator doesn't work at statement level

**What I was trying to do:** Create an array of zeros using `(1..$zero_count)|map:0`

**What the issue was:** This expression can't start a statement - it expects `}` instead

**Why it was an issue:** Range syntax `..` and filters like `map` work in expressions but can't be used as standalone statements. I had to switch to the `|fill` filter instead.

**Potential solution (if known):** Document that range expressions need to be assigned to variables or used within expressions, not as standalone statements. The `|fill` filter was a good alternative but wasn't obvious from the initial documentation search.

---

## General Observations

1. **Error messages are generally helpful** - The suggestions like "Use int[] instead of array" were very useful
2. **Syntax patterns aren't always obvious** - The `while`+`each` requirement and array function parentheses rules could be better documented
3. **In-place array modification is difficult** - The functional approach (filter/merge) worked but changed the algorithm complexity
4. **MCP validate_xanoscript is invaluable** - Being able to validate iteratively saved a lot of time compared to trial-and-error deployment
