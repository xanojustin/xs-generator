# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 12:47 PST] - Issue #1: Optional Syntax in run.job Input Blocks

**What I was trying to do:**
Create a run.job with an optional input parameter (source_lang) that has a default value.

**What the issue was:**
I tried to use the optional syntax `source_lang?: "EN"` in the run.job input block, similar to how it works in function input blocks.

```xs
run.job "DeepL Translate Text" {
  main = {
    name: "translate_text"
    input: {
      text: "Hello, world!"
      target_lang: "ES"
      source_lang?: "EN"  // <-- This caused a parse error
    }
  }
}
```

**Why it was an issue:**
The parser expected `:` but found `?`. The optional syntax with `?` works in function `input` blocks but not in run.job `input` blocks. This inconsistency was confusing.

**Potential solution (if known):**
Either support the same optional syntax in run.job input blocks, or document this difference clearly. The workaround is to just provide a default value without the `?` marker:
```xs
source_lang: ""  // Empty string as default
```

---

## [2025-02-17 12:48 PST] - Issue #2: Reserved Variable Name '$response'

**What I was trying to do:**
Create a variable named `$response` to build the function's response object.

**What the issue was:**
```xs
var $response {   // <-- Error: '$response' is a reserved variable name
  value = {
    success: true
    // ...
  }
}
```

**Why it was an issue:**
The error message was helpful, but I didn't realize `$response` was reserved since the docs mention `$response` as the API/function response (auto-populated), not as a reserved variable name that can't be used. I thought it was only reserved at the top level of queries.

**Potential solution (if known):**
The MCP validation caught this with a good suggestion, so the tooling worked well. Just need to be more careful about reserved names. The docs do list it, but it's easy to miss.

---

## [2025-02-17 12:49 PST] - Issue #3: Ternary Operator Syntax Confusion

**What I was trying to do:**
Use a conditional expression to determine the source language value in an object literal.

**What the issue was:**
I tried to use `??` as a ternary operator like in JavaScript:
```xs
source_language: ($input.source_lang != "") ?? $input.source_lang : $detected_source_lang
```

This caused a parse error: "Expecting --> } <-- but found --> ':'"

**Why it was an issue:**
I misunderstood the `??` operator. According to the docs, `??` is for null coalescing (like `$val ?? "default"`), not for conditional expressions. The error message was confusing because it pointed to the colon, making me think the issue was with the object syntax rather than the operator.

**Potential solution (if known):**
- Better error message: Instead of "Expecting } but found :", something like "Unexpected : after ?? operator. Did you mean to use a conditional block?"
- Or support actual ternary syntax for more concise code

**Workaround used:**
I had to rewrite using a conditional block:
```xs
var $final_source_lang { value = $detected_source_lang }
conditional {
  if ($input.source_lang != "") {
    var.update $final_source_lang { value = $input.source_lang }
  }
}
```

---

## [2025-02-17 12:50 PST] - Positive Feedback: Validation Tool

**What worked well:**
The `validate_xanoscript` tool from the Xano MCP was very helpful! It:
- Caught all syntax errors with clear line/column positions
- Provided helpful suggestions (e.g., suggesting `$my_response` instead of `$response`)
- Validated multiple files at once
- Returned structured JSON output that was easy to parse

**Potential improvement:**
Would be nice to have a "fix" or "suggest fix" mode that could automatically suggest corrections for common errors.

---

## [2025-02-17 12:51 PST] - Documentation Feedback

**What was helpful:**
- The `quickstart` topic was excellent for common patterns and mistakes
- The `run` topic clearly explained run.job vs run.service differences
- The `syntax` topic had good filter reference

**What could be improved:**
- More examples of error handling patterns in API integrations
- A clearer distinction between which syntax works in which contexts (run.job vs function vs task)
- More examples of working with JSON responses from external APIs