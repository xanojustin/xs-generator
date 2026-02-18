# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 20:15 PST] - Missing Loop Syntax Documentation

**What I was trying to do:**
Create a run job that iterates over an array of items to build line items for a QuickBooks invoice.

**What the issue was:**
I tried to use `for $i in $input.item_names|count|range` syntax which failed validation. The error was:
```
Expecting --> ( <-- but found --> '$i' <--
```

I couldn't find proper loop syntax in the xanoscript_docs for the `functions` topic. The docs mention "Loops" as a section but don't provide the actual syntax pattern for iterating with an index.

**Why it was an issue:**
Without knowing the proper loop syntax, I had to work around by using conditional blocks with manual index handling (if count >= 1, if count >= 2, etc.), which is verbose and limits the implementation to a fixed number of items.

**Potential solution:**
Add clear loop syntax examples in the functions documentation showing:
- How to iterate over an array with an index
- How to use range() with for loops
- The proper variable declaration syntax inside loops

---

## [2026-02-17 20:20 PST] - Variable Assignment in Conditional Blocks Not Allowed

**What I was trying to do:**
Calculate a running total inside conditional blocks based on the number of items.

**What the issue was:**
I tried to assign to a variable inside a conditional block:
```xs
conditional {
  if ($item_count >= 1) {
    $total_amount = $total_amount + $input.item_amounts[0]
  }
}
```

The validator error was:
```
Expecting --> } <-- but found --> '$total_amount'
```

**Why it was an issue:**
This constraint wasn't documented anywhere obvious. I had to restructure my logic to use ternary expressions to calculate the total, which made the code more complex:
```xs
var $total_amount {
  value = ($item_count == 1) ? $input.item_amounts[0] : (($item_count == 2) ? ...)
}
```

**Potential solution:**
Document that variable assignments are not allowed inside conditional blocks, and provide the recommended pattern for conditional calculations (using ternary operators or restructuring logic).

---

## [2026-02-17 20:25 PST] - Array Push Syntax Unclear

**What I was trying to do:**
Build an array incrementally by pushing items into it.

**What the issue was:**
I tried `$line_items|push: $line_item_0` which failed with:
```
Expecting --> } <-- but found --> '$line_items'
```

The filter/pipe syntax for array manipulation isn't clearly documented.

**Why it was an issue:**
I had to abandon the incremental approach and instead build the full array in a single expression using ternary operators, which is less readable and harder to maintain.

**Potential solution:**
Add documentation for array manipulation filters including:
- How to push/append items to arrays
- How to merge arrays
- Whether arrays can be modified after creation

---

## [2026-02-17 20:30 PST] - Optional Chaining and Null Coalescing Not Supported

**What I was trying to do:**
Safely access nested properties in an API response that might be null:
```xs
$qb_result.response.result.fault?.error?[0]?.message ?? "Unknown error"
```

**What the issue was:**
The `?.` optional chaining and `??` null coalescing operators are not valid XanoScript syntax. The parser expected various tokens but found `.`

**Why it was an issue:**
Without these operators, safely accessing deeply nested optional properties requires multiple conditional checks, making error handling more verbose.

**Potential solution:**
Either:
1. Add support for optional chaining (`?.`) and null coalescing (`??`) operators
2. Document the recommended pattern for safe nested property access (perhaps using `conditional` blocks or the `has` filter)

---

## [2026-02-17 20:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Check if an array has items using `$input.item_names|count > 0`.

**What the issue was:**
The validator error was:
```
An expression should be wrapped in parentheses when combining filters and tests
```

I had to change it to `($input.item_names|count) > 0`.

**Why it was an issue:**
While the fix was simple, this rule wasn't obvious from the documentation. The precedence rules for filters vs comparisons weren't clear.

**Potential solution:**
Add a note in the syntax documentation about parentheses requirements when using filters with comparison operators.

---

## [2026-02-17 20:40 PST] - Date Format Filter Doesn't Exist

**What I was trying to do:**
Format the current timestamp as a date string: `now|date_format:"Y-m-d"`.

**What the issue was:**
The `date_format` filter doesn't exist in XanoScript. Error was:
```
Unknown filter function 'date_format'
```

**Why it was an issue:**
I had to remove the date formatting and just pass `now` directly, hoping the QuickBooks API accepts ISO format timestamps. Without knowing what date filters exist, I'm guessing at the API contract.

**Potential solution:**
Document the available date/time filters including:
- How to format timestamps
- How to parse dates
- How to perform date arithmetic

---

## General MCP Feedback

**What worked well:**
- The `validate_xanoscript` tool with the `directory` parameter is very convenient for batch validation
- Error messages include line and column numbers which is helpful
- The documentation index is well-organized by topic

**What could be improved:**
- The `xanoscript_docs` tool returns the same general README content for different topics instead of specific documentation for that topic. When I requested topic "functions" or "quickstart", I got mostly the same generic content.
- There's no way to get a compact syntax reference - the docs are verbose with lots of repeated content
- More real-world examples showing complete, valid implementations would be helpful

---
