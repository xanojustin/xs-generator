# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 02:18 PST] - Comments Inside Object Literals Not Allowed

**What I was trying to do:**
Add a helpful comment inside an object literal to explain what the `audio_data` field contains.

**What the issue was:**
Placed a comment inside the object literal value block:
```xs
var $api_response {
  value = {
    success: true,
    // The audio data is in $api_result.response.result as base64
    audio_data: $api_result.response.result
  }
}
```

The validator gave this error:
```
[Line 61, Column 13] Expecting --> } <-- but found --> '// The audio data is in $api_result.response.result as base64' <--
```

**Why it was an issue:**
XanoScript doesn't allow comments inside object literals. This is a common pattern in other languages and it was surprising that it failed. The error message was somewhat helpful but didn't explicitly say "comments not allowed in objects".

**Potential solution (if known):**
- Allow comments inside object literals (most intuitive)
- Or provide a clearer error message like "Comments are not allowed inside object literal definitions"

---

## [2025-02-18 02:15 PST] - Documentation Access Pattern

**What I was trying to do:**
Access XanoScript documentation to learn the correct syntax for writing the run job.

**What the issue was:**
Had to make multiple separate calls to `xanoscript_docs` with different topic parameters to get complete information:
1. `xanoscript_docs` (general overview)
2. `xanoscript_docs({ topic: "run" })` (run jobs specifically)
3. `xanoscript_docs({ topic: "quickstart" })` (common patterns)
4. `xanoscript_docs({ topic: "integrations/external-apis" })` (API requests)

**Why it was an issue:**
It took 4 separate calls to get all the information needed. While the modular approach is good, there wasn't a single "complete reference" or "getting started for run jobs" that bundled everything needed.

**Potential solution (if known):**
- Add a topic like `"run-complete"` or `"run-quickstart"` that includes run-specific info + common patterns + external API examples in one call
- Or provide a documentation index/list of recommended topics for different use cases

---

## [2025-02-18 02:17 PST] - Precondition Logical AND Syntax

**What I was trying to do:**
Validate that an environment variable exists and is not empty.

**What the issue was:**
Initially tried using `&&` for logical AND in preconditions but wasn't 100% sure if that was correct syntax. Had to check documentation to confirm.

```xs
precondition ($env.ELEVENLABS_API_KEY != null && $env.ELEVENLABS_API_KEY != "")
```

**Why it was an issue:**
The quickstart docs show basic operators but don't explicitly document logical operators (&&, ||). Had to infer from examples.

**Potential solution (if known):**
- Add a small "Operators" section to the quickstart doc showing &&, ||, ==, !=, <, >, etc.

---

## [2025-02-18 02:20 PST] - API Response Binary Data Handling Uncertainty

**What I was trying to do:**
Handle the ElevenLabs API response which returns binary MP3 audio data.

**What the issue was:**
Wasn't sure how XanoScript handles binary responses from `api.request`. The documentation shows JSON responses but not binary/audio data handling.

**Why it was an issue:**
Had to assume that binary data would be available in `$api_result.response.result` as base64, but this wasn't documented. Unclear if:
- Binary data is auto-converted to base64
- There's a separate way to access binary responses
- File operations are needed

**Potential solution (if known):**
- Add documentation about binary response handling in `integrations/external-apis`
- Show example of working with file uploads/downloads or audio/image data

---

## General Observations

### What Worked Well:
1. The `validate_xanoscript` tool is excellent - fast feedback on syntax errors
2. Error messages include line/column numbers which is very helpful
3. The run job structure is clean and intuitive once you see an example
4. Environment variable handling with `env = [...]` in run.xs is straightforward

### Suggested Improvements:
1. Allow comments in more places (object literals, after field definitions)
2. Provide a "cheat sheet" topic that combines most common patterns
3. Document binary/non-JSON response handling
4. Consider adding a `validate_all` command to check all .xs files in a folder at once

---

Documentation version: 2.0.0
Feedback collected during: ElevenLabs text-to-speech run job implementation