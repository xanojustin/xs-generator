# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-26 02:02 PST - run.job syntax completely different from function syntax

**What I was trying to do:** Create a run.xs file that would serve as the entry point for testing the single_number_ii function.

**What the issue was:** I assumed run.job would have a similar structure to function - with `description`, `stack`, and `return` properties. I wrote:

```xs
run.job {
  description = "..."
  stack {
    // test code
  }
}
```

This failed validation with error: `Expecting: one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'`

**Why it was an issue:** The error message wasn't clear about what was wrong. It took me reading the full documentation to discover that run.job uses a completely different syntax:

```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { key: value }
  }
}
```

This is a significant departure from the function syntax. There's no `stack`, no `description`, and the function call is declarative (just specifying name and input) rather than imperative (using function.run).

**Potential solution (if known):** 
1. The validate_xanoscript error could be more helpful - perhaps detecting that I'm using `run.job` without a name string and suggesting the correct syntax
2. The quick_reference for 'run' topic only shows a minimal table - it would help to show the actual syntax example
3. A note in the function documentation saying "run.job syntax is different - see run docs" would help

---

## 2025-02-26 02:00 PST - Array access syntax unclear

**What I was trying to do:** Access array elements by index in the bit manipulation loop.

**What the issue was:** I wasn't sure if XanoScript uses `$array[index]` or `$array.index` or something else for array access.

**Why it was an issue:** The quick_reference docs don't explicitly show array element access syntax. I had to infer it from examples and hope it works like JavaScript bracket notation.

**Potential solution (if known):** Add a small table or example showing:
- Array access: `$array[index]`
- Object property access: `$obj.property` or `$obj["key"]`
- Nested access: `$array[$index].field`

---

## 2025-02-26 02:01 PST - No bitwise operators available

**What I was trying to do:** Use bitwise AND (`&`), OR (`|`), and shifts (`<<`, `>>`) for the bit manipulation solution.

**What the issue was:** XanoScript doesn't have bitwise operators. The operator table only shows:
- Comparison: `==`, `!=`, `>`, `<`, `>=`, `<=`
- Logical: `&&`, `||`, `!`
- Math: `+`, `-`, `*`, `/`, `%`

**Why it was an issue:** I had to completely rewrite the bit manipulation algorithm to use arithmetic operations (division by 2, modulo 2) instead of bitwise operations. This makes the code significantly more verbose and potentially slower:

```xs
// What I wanted to write:
if (num & (1 << bit_position)) {
  bit_count++
}

// What I had to write:
var $working_num { value = $temp_num }
var $div_count { value = 0 }
while ($div_count < $bit_position) {
  var.update $working_num { value = ($working_num / 2)|to_int }
  var.update $div_count { value = $div_count + 1 }
}
if (($working_num % 2) == 1) {
  // bit is set
}
```

**Potential solution (if known):** Consider adding bitwise operators or at least a filter-based approach like `$num|bit_and:mask` or `$num|bit_shift_left:5`

---

## 2025-02-26 02:03 PST - while loop requires `each` block

**What I was trying to do:** Write a while loop to iterate through bits and array elements.

**What the issue was:** I initially wrote:
```xs
while ($counter < 10) {
  var.update $counter { value = $counter + 1 }
}
```

This didn't match the documentation pattern which shows:
```xs
while ($counter < 10) {
  each {
    var.update $counter { value = $counter + 1 }
  }
}
```

**Why it was an issue:** The extra `each` wrapper feels redundant and the error messages don't clearly indicate it's required. It's an unusual pattern compared to other languages.

**Potential solution (if known):** Make the `each` block optional for while loops, or provide a clearer error message when it's missing like "while loop body must be wrapped in an each block"

---

## 2025-02-26 02:04 PST - Missing filters for common operations

**What I was trying to do:** Use math functions like power/exponentiation (2^bit_position).

**What the issue was:** There's no power operator (`^` or `**`) and no power filter. I had to write a manual while loop to calculate 2^n:

```xs
var $bit_value { value = 1 }
var $shift { value = 0 }
while ($shift < $bit_position) {
  each {
    var.update $bit_value { value = $bit_value * 2 }
    var.update $shift { value = $shift + 1 }
  }
}
```

**Why it was an issue:** Very verbose for a simple mathematical operation. Makes bit manipulation algorithms much more complex than they need to be.

**Potential solution (if known):** Add a `power` or `pow` filter: `$base|pow:exponent` or `$base|power:$exponent`

---
