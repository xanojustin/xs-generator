# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 02:08 PST] - Non-existent array.sort statement

**What I was trying to do:** Sort an array of envelope objects by width.

**What the issue was:** I assumed there would be an `array.sort` statement based on common patterns in other languages, and initially wrote:
```xs
array.sort ($envelopes) {
  by = $this.width
  direction = "asc"
}
```

**Why it was an issue:** XanoScript doesn't have an `array.sort` statement. The validation error was:
```
[Line 22, Column 11] Expecting: one of these possible Token sequences but found: 'sort'
```

**Potential solution:** The documentation mentions a `sort` filter (e.g., `$arr|sort:n:text:false`), but I couldn't get it to work in the function stack context. It would be helpful to have:
1. A clear statement-level sort function like `array.sort`
2. Better documentation on when/where the `sort` filter can be used
3. More examples of sorting complex objects in function stacks

---

## [2025-02-28 02:10 PST] - Reserved variable name $env

**What I was trying to do:** Iterate over envelopes in a foreach loop using a concise variable name.

**What the issue was:** I used `$env` as the loop variable:
```xs
foreach ($input.envelopes) {
  each as $env {
```

**Why it was an issue:** `$env` is a reserved system variable for accessing environment variables. The error was cryptic:
```
[Line 17, Column 15] Expecting: one of these possible Token sequences but found: '$env'
```

**Potential solution:** 
1. Include a list of reserved variable names more prominently in the documentation
2. Provide a clearer error message like: "'$env' is a reserved variable name, use a different name like '$envelope'"

---

## [2025-02-28 02:12 PST] - Sort filter syntax confusion

**What I was trying to do:** Use the sort filter documented in array-filters to sort envelope objects by width.

**What the issue was:** The documentation shows:
```
[{n:"z"},{n:"a"}]|sort:n:text:false
```

But when I tried:
```xs
var $sorted_by_width { value = $envelope_objects|sort:width:int:false }
```

I got a parse error expecting a different token sequence after the first colon.

**Why it was an issue:** The filter syntax seems to work differently in practice than documented, or only works in specific contexts (maybe only in db.query or certain expressions?).

**Potential solution:**
1. Clarify in the documentation where the sort filter can and cannot be used
2. Provide working examples of sorting within function stacks
3. Consider adding a statement-level sort operation that's more reliable

---

## [2025-02-28 02:15 PST] - Validation requires manual iteration

**What I was trying to do:** Validate files individually using the `file_paths` parameter.

**What the issue was:** The mcporter CLI syntax for array parameters wasn't intuitive. I tried multiple formats:
```bash
mcporter call xano.validate_xanoscript file_paths="[""run.xs"", ""function/max_russian_dolls.xs""]"
```

But kept getting "expected array, received string" errors.

**Why it was an issue:** The correct way to pass arrays via mcporter CLI isn't clearly documented. Using `directory` parameter was a workaround.

**Potential solution:**
1. Better documentation on how to pass array parameters via mcporter CLI
2. More examples of common validation patterns
3. Consider adding a simpler `validate` command to the xano CLI tool

---

## General Observations

1. **Missing standard library:** XanoScript lacks common operations like sorting, which forces developers to implement basic algorithms (like bubble sort) manually. This is error-prone and inefficient.

2. **Filter vs Statement confusion:** It's not always clear when to use a filter (`$arr|filter:...`) vs a statement (`array.filter $arr if ...`). More guidance on this would help.

3. **Error messages:** While generally helpful, some error messages could be more specific (e.g., "reserved variable name" instead of generic token expectation errors).

4. **Documentation gaps:** The documentation is comprehensive but sometimes lacks practical examples for complex scenarios like sorting objects or implementing algorithms.
