# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 01:17 PST] - Array Parameter Parsing Issue in validate_xanoscript

**What I was trying to do:**
Validate multiple .xs files at once using the `file_paths` parameter (array of strings) as documented in the MCP schema.

**What the issue was:**
When calling `validate_xanoscript` with `file_paths` as a JSON array, the MCP treated each character of the JSON string as a separate file path. The output showed 128 "files" being validated, all being individual characters from the path string:

```
File not found: [
File not found: U
File not found: s
File not found: e
...
```

This suggests the MCP is not correctly parsing the JSON array parameter - it seems to be iterating over the string characters instead of the array elements.

**Why it was an issue:**
This blocked batch validation. I had to work around by calling validate_xanoscript twice (once per file) using the `file_path` parameter instead.

**Potential solution (if known):**
The MCP server should properly deserialize the JSON array parameter before processing file paths. The CLI might also need better parameter passing for array types.

**Workaround:**
Use `file_path` parameter for single files instead of `file_paths` for batch validation.

---

## [2026-02-17 01:15 PST] - Limited Documentation for Array/List Manipulation

**What I was trying to do:**
Build a list of formatted track objects in a loop using `foreach`.

**What the issue was:**
The quick_reference docs show basic array syntax (`type[]`) but don't clearly explain:
1. How to initialize an empty array: `value = []`
2. How to append items to an array in a loop: `value = $array ~ [$new_item]`
3. Whether array concatenation uses `~` or another operator

I had to infer this from the string concatenation example (`~` operator) and hope it worked for arrays too.

**Why it was an issue:**
Trial and error for basic list operations. If my guess about array concatenation was wrong, I would have had to validate multiple times to find the correct syntax.

**Potential solution (if known):**
Add a specific "Array/List Operations" section to the quickstart or cheatsheet documentation showing:
- Empty array initialization: `var $list { value = [] }`
- Appending items: `var.update $list { value = $list ~ [item] }`
- Array length: `$list|count`
- Accessing items: `$list[0]`

---

## [2026-02-17 01:14 PST] - Null Coalescing Operator Unclear

**What I was trying to do:**
Handle potentially null values in the API response (specifically `preview_url` which may be null for some tracks).

**What the issue was:**
The quickstart mentions null handling briefly: `$val ?? "default"` or `$val|first_notnull:"default"`, but doesn't show a clear example in context.

I wasn't sure:
1. If `??` is a proper operator or pseudo-code
2. Whether the filter syntax would be `$val|first_notnull:"default"` or something else
3. How this interacts with object property access

**Why it was an issue:**
Had to guess the syntax for: `$track.preview_url ?? null`. I used `$track.preview_url ?? null` hoping it works, but I'm not 100% certain this is valid XanoScript.

**Potential solution (if known):**
Add an explicit example showing null coalescing with object properties:
```xs
var $preview {
  value = $track.preview_url ?? "fallback"
}
```

---

## [2026-02-17 01:10 PST] - Environment Variable Access in Input Block

**What I was trying to do:**
Use an environment variable directly in the run.job's input block.

**What the issue was:**
The run job documentation shows input values must be constants:
> "Input values must be constants - No variables like `$input` allowed"

But it's unclear whether `$env` variables are considered "constants" for this purpose. The examples show both literal values and the pattern `access_token: ""` with `env = ["spotify_access_token"]`.

I wasn't sure if I could use `$env.spotify_access_token` directly in the input block or if I must pass it as an empty string and rely on the `env` declaration.

**Why it was an issue:**
Uncertainty about the correct pattern for passing env vars to run jobs. I ended up using the empty string + env declaration pattern shown in the docs, but this feels like a workaround rather than proper env var usage.

**Potential solution (if known):**
Clarify in the run.job documentation:
1. Can `$env.VAR_NAME` be used directly in input blocks?
2. If not, what's the recommended pattern for passing env vars to functions?

---

## [2026-02-17 01:08 PST] - String Concatenation with Filters Syntax Ambiguity

**What I was trying to do:**
Build a URL with query parameters, concatenating strings and filtered values.

**What the issue was:**
The quickstart shows string concatenation: `"Hello, " ~ $input.name ~ "!"`
And mentions: "With filters (use parentheses)"

But it's unclear if parentheses are needed around every variable with a filter, or only when the filter is part of a larger expression.

I wrote:
```xs
value = "https://api.spotify.com/v1/search?q=" ~ ($input.query|url_encode) ~ "&type=track&limit=" ~ ($input.limit|to_text)
```

Are the parentheses required? Would this also work?
```xs
value = "https://api.spotify.com/v1/search?q=" ~ $input.query|url_encode ~ "&type=track&limit=" ~ $input.limit|to_text
```

**Why it was an issue:**
Uncertainty about operator precedence and filter application. I used parentheses defensively but don't know if they're actually required.

**Potential solution (if known):**
Add a clear example showing filter usage in concatenation:
```xs
// Without parentheses - may not work as expected
var $bad { value = "Count: " ~ $items|count }

// With parentheses - explicit precedence
var $good { value = "Count: " ~ ($items|count) }
```

---

## Summary

The Xano MCP and XanoScript documentation are functional but have gaps in:
1. **Array parameter handling** - CLI parameter passing issue
2. **Array/list operations** - Missing explicit examples
3. **Null handling** - Unclear operator behavior
4. **Environment variables in run jobs** - Ambiguous patterns
5. **Filter precedence in expressions** - Needs clarification

Despite these issues, I was able to create a working run job by inferring from examples and validating iteratively.
