# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 23:48 PST] - While Loop Requires `each` Blocks

**What I was trying to do:**
Create a polling loop to check AssemblyAI transcription status until complete.

**What the issue was:**
My initial code used a standard while loop:
```xs
while ($attempts < $max_attempts && $transcription_complete == false) {
  // polling logic here
}
```

The validator error was very cryptic:
```
Expecting --> each <-- but found --> '
' <--
```

It took me a while to understand that XanoScript requires `while` loop bodies to use `each { ... }` blocks:
```xs
while ($attempts < $max_attempts) {
  each {
    // polling logic here
  }
}
```

**Why it was an issue:**
The error message was confusing - it said "expecting 'each'" but didn't explain that `each` is required syntax for while loop bodies. I had to look at the cheat sheet example carefully to realize this pattern.

**Potential solution:**
- Improve the error message to say something like: "While loop bodies must use 'each { ... }' blocks. See: while ($condition) { each { ... } }"
- Or document this more prominently in the quickstart guide

---

## [2026-02-17 23:50 PST] - No `&&` or `||` Logical Operators

**What I was trying to do:**
Combine conditions in a while loop: `$attempts < $max_attempts && $transcription_complete == false`

**What the issue was:**
The `&&` operator caused validation errors. I had to restructure my logic to only check `$attempts < $max_attempts` and rely on the `transcription_complete` flag being set to break out (though actually, I realized I needed to add a check to break the loop when complete, but that's a logic issue on my end).

Actually, the real issue was the `each` requirement mentioned above, not the `&&` operator. After fixing the `each` issue, the single condition worked fine.

**Why it was an issue:**
I initially thought the error was about `&&` but it was actually about the missing `each`. This was confusing.

**Potential solution:**
- Document which logical operators are supported (`&&`, `||`, `!`)
- The cheat sheet doesn't mention logical operators at all

---

## [2026-02-17 23:52 PST] - `if` Statements Must Be Inside `conditional` Blocks

**What I was trying to do:**
Check the HTTP status code after an API request:
```xs
var $status_code { value = $status_result.response.status }

if ($status_code == 200) {
  // handle success
}
```

**What the issue was:**
Got error: `Expecting --> } <-- but found --> 'if' <--`

I discovered that all `if` statements must be wrapped in a `conditional` block:
```xs
conditional {
  if ($status_code == 200) {
    // handle success
  }
}
```

**Why it was an issue:**
This is different from most programming languages where `if` can stand alone. The cheat sheet does show `conditional { if ... }` but I initially thought `conditional` was optional for single if statements. The error message was not helpful - it made me think there was a brace mismatch.

**Potential solution:**
- Error message could say: "'if' statements must be inside a 'conditional' block. Use: conditional { if (...) { ... } }"
- Or make `conditional` wrapper optional for single if statements (feature request)

---

## [2026-02-17 23:53 PST] - No `|default:` Filter (Use `??` Instead)

**What I was trying to do:**
Provide a default value for potentially null fields:
```xs
utterances: $transcription_result.utterances|default:[]
```

**What the issue was:**
The validator suggested: "There is no 'default' filter. Use 'first_notnull' or '??' operator instead"

I had to change to:
```xs
utterances: $transcription_result.utterances ?? []
```

**Why it was an issue:**
The `|default:` filter is common in templating languages (like Twig, Jinja2). The `??` operator is less discoverable. The error message was helpful though!

**Potential solution:**
- Add `|default:` as an alias for `??` (developer ergonomics)
- Or document the `??` operator more prominently in the cheat sheet

---

## [2026-02-17 23:54 PST] - Documentation Discovery

**What I was trying to do:**
Find the correct syntax for various XanoScript constructs.

**What the issue was:**
Had to call multiple `xanoscript_docs` queries to get different pieces of information:
- `run` for run job structure
- `integrations/external-apis` for API requests
- `cheatsheet` for common patterns

**Why it was an issue:**
The documentation is well-organized by topic, but for building a run job I needed to piece together information from multiple sources. It wasn't immediately obvious which topics to query.

**Potential solution:**
- Consider a "run-job-example" topic that shows a complete working example
- Or a "quickstart-run-job" guide specifically for this use case

---

## Summary

Overall the Xano MCP validation tool was **very helpful** - it caught syntax errors immediately and gave actionable suggestions. The main pain points were:

1. **Error message clarity** - Some errors were cryptic and required trial-and-error to fix
2. **Syntax discoverability** - Some patterns (like `each` in while loops) aren't obvious from the cheat sheet alone
3. **Missing documentation** - No explicit mention of logical operators (`&&`, `||`), though they might work

The MCP itself worked perfectly - fast responses, clear schema, good tool design. The struggles were all with learning XanoScript's specific syntax quirks, which is expected for a new language.

---

*Generated during AssemblyAI run job creation*
