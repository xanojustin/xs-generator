# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 10:47 PST] - Validate Tool Code Parameter Encoding Issue

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool with the `code` parameter by base64-encoding the file content.

**What the issue was:**
I initially tried to pass base64-encoded content to the `code` parameter like this:
```bash
mcporter call xano.validate_xanoscript code="$(cat file.xs | base64)" filename="run.xs"
```

The validation tool returned errors showing it was interpreting the base64 string as literal code instead of decoding it first:
```
Found 1 error(s):
1. [Line 1, Column 1] Expecting --> function <-- but found --> 'cnVuLmpvYiAiR29vZ2xlIFNoZWV0cyBBcHBlbmQgUm93IiB7...'
```

**Why it was an issue:**
The error message showed the base64-encoded content (`cnVuLmpvYi...`) being treated as the actual code, which obviously fails parsing. This suggests either:
1. The tool doesn't auto-detect/decode base64
2. The filename parameter wasn't being respected
3. There's no explicit flag to indicate the code is base64-encoded

**Potential solution (if known):**
- The tool should either auto-detect base64 encoding or provide a flag like `code_encoding: "base64"`
- Better documentation on how to pass multi-line code strings via MCP
- I discovered that using `file_path` parameter is the recommended approach and works perfectly, so this is more of a documentation/clarity issue

**Workaround used:**
Switched to using `file_path` parameter which worked flawlessly:
```bash
mcporter call xano.validate_xanoscript file_path="/Users/justinalbrecht/xs/google-sheets-append-row/run.xs"
```

---

## [2025-02-17 10:48 PST] - XanoScript Learning Curve with Type Names

**What I was trying to do:**
Write proper XanoScript code with correct type annotations.

**What the issue was:**
Even with documentation, I made initial mental mistakes like:
- Thinking `integer` instead of `int`
- Thinking `string` instead of `text`
- Thinking `array` instead of `text[]`

The documentation does clearly state these, but muscle memory from other languages caused hesitation.

**Why it was an issue:**
Had to stop and look up the type names even though they're in the docs. Common aliases (int/integer, string/text, array/list) are so prevalent in other languages that this is a constant friction point.

**Potential solution (if known):**
- The validate tool could suggest corrections: "Did you mean 'int' instead of 'integer'?"
- A quick-reference card in the documentation index would be helpful
- The docs are actually quite good here, so this is minor

---

## [2025-02-17 10:48 PST] - Documentation Discovery for Run Jobs

**What I was trying to do:**
Understand the proper structure for a `run.job` vs `run.service`.

**What the issue was:**
I had to call `xanoscript_docs` with topic="run" to discover that `run.job` needs a `main` attribute while `run.service` uses `pre`. This isn't immediately obvious.

**Why it was an issue:**
The naming difference (`main` vs `pre`) is subtle and the documentation says run.service "cannot use main" which is a negative constraint rather than a positive one saying "use pre instead".

**Potential solution (if known):**
- A comparison table in the main docs showing job vs service side-by-side
- Better naming (maybe `init` instead of `pre` for services, or `execute` for jobs)
- The docs do have a comparison table, but it's not the first thing you see

---

## [2025-02-17 10:49 PST] - String Concatenation Operator

**What I was trying to do:**
Build a URL string by concatenating multiple parts.

**What the issue was:**
The `~` operator for string concatenation was easy to miss in the docs. I initially looked for `+` or a `concat()` filter.

**Why it was an issue:**
Most languages use `+` for string concatenation. The `~` operator is unusual (though common in template languages like Twig). Had to search the syntax docs to find it.

**Potential solution (if known):**
- The quickstart guide does mention this, so this is minor
- Maybe accept `+` as an alias for string concatenation (though I understand wanting explicit operators)

---

## Overall Assessment

The MCP and documentation worked well overall. The main friction points were:

1. **Initial validation attempt** with base64 encoding - easily solved by using `file_path`
2. **Type name differences** from other languages - minor, well documented
3. **Discovering the right docs** - the topic-based system works well once you know it exists

The `xanoscript_docs` tool with topics is excellent - being able to pull up `quickstart`, `run`, `integrations/external-apis` etc. made this much easier than guessing syntax.

The validation tool with `file_path` works perfectly and gives clear error messages.
