# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 19:35 PST] - Parser confused by multi-line comments with empty lines

**What I was trying to do:** Create a function file with a descriptive header comment explaining the exercise

**What the issue was:** The parser gave cryptic errors like "Expecting --> function <-- but found --> '\n'" when I had multi-line comments with empty `//` lines before the function definition.

**Code that failed:**
```xs
// Design Hit Counter - System Design Exercise
// 
// Design a hit counter which counts...

function "hit_counter" {
```

**Why it was an issue:** The empty `//` line (with just a space after) confused the parser, causing it to not recognize the function definition.

**Potential solution:** Document that comments should be compact without empty `//` lines, or fix the parser to handle them gracefully.

---

## [2026-02-28 19:35 PST] - object[] schema syntax not supported

**What I was trying to do:** Define a strongly-typed array of objects in the input block using schema definition

**What the issue was:** The syntax `object[] test_operations { schema { ... } }` failed validation

**Code that failed:**
```xs
input {
  object[] test_operations {
    schema {
      text action { ... }
      int timestamp { ... }
    }
  }
}
```

**Why it was an issue:** I expected to define the schema for array elements, but this syntax isn't supported.

**Potential solution:** Document that arrays of objects should use `json` type instead, or provide the correct syntax.

**Workaround:** Changed to `json test_operations { description = "..." }`

---

## [2026-02-28 19:37 PST] - Table index type "index" not valid

**What I was trying to do:** Create a secondary index on the timestamp field

**What the issue was:** Used `type: "index"` which is not a valid index type

**Code that failed:**
```xs
index = [
  {type: "primary", field: [{name: "id"}]},
  {type: "index", field: [{name: "timestamp", direction: "asc"}]}
]
```

**Why it was an issue:** The error message says expected one of `primary`, `btree`, `gin`, etc. but intuitively "index" seems like it should work for a generic index.

**Potential solution:** Consider supporting "index" as an alias for "btree" or document the valid types more prominently.

**Fix:** Changed to `type: "btree"` and removed the `direction` key.

---

## [2026-02-28 19:37 PST] - MCP tool parameter passing issues

**What I was trying to do:** Validate multiple files using `file_paths` parameter

**What the issue was:** The MCP tool expects an array for `file_paths` but I couldn't figure out the correct CLI syntax to pass it.

**Tried:**
- `mcporter call xano.validate_xanoscript file_paths=run.xs,function/hit_counter.xs`
- `mcporter call xano.validate_xanoscript file_paths="[run.xs,function/hit_counter.xs]"`

**Why it was an issue:** The help shows `file-paths:value1,value2` format but that didn't work.

**Workaround:** Used `directory` parameter instead.

**Potential solution:** Provide clearer examples in the tool description for array parameters.
