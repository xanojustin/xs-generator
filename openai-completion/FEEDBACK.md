# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 09:50 PST] - Issue: Incorrect input default value syntax

**What I was trying to do:**
Create a function input parameter with a default value for `max_tokens` and `temperature`.

**What the issue was:**
I initially tried to use the `default:` keyword like this:
```xs
int max_tokens default:150
decimal temperature default:0.7
```

And also tried:
```xs
text model filters=trim|default:"gpt-4o-mini"
```

Both resulted in validation errors:
- `Filter 'default' cannot be applied to input of type 'text'`
- `Expecting --> } <-- but found --> 'default'`

**Why it was an issue:**
The documentation shows examples like `text role?="user"` and `bool is_active?=true` for optional fields with defaults, but doesn't clearly show how to handle defaults for `int` and `decimal` types. The filter syntax `default:` doesn't exist.

**Potential solution (if known):**
- Document the difference between default syntax for different types
- Clarify that `int`/`decimal` types don't support default values in the input block
- Show the pattern of using `var` assignment with `??` operator in the stack as the workaround:
  ```xs
  var $max_tokens { value = $input.max_tokens ?? 150 }
  ```

---

## [2026-02-16 09:47 PST] - Issue: Filter order with default values

**What I was trying to do:**
Create an input parameter with both a filter and a default value:
```xs
text model filters=trim default:"gpt-4o-mini"
```

**What the issue was:**
The validator expected the `?="value"` syntax to come before `filters=`. The order matters but wasn't clear from documentation.

**Why it was an issue:**
Multiple attempts with different orderings all failed:
- `text model default:"gpt-4o-mini" filters=trim` → Expected `}` but found 'default'
- `text model filters=trim default:"gpt-4o-mini"` → Expected `}` but found 'default'

The correct syntax is `text model?="value" filters=trim` (the `?` is required for optional with default).

**Potential solution (if known):**
- Document the exact ordering requirements: `<type> <name>?="<default>" filters=<filter>`
- Include more examples with both defaults and filters in the types documentation

---

## [2026-02-16 09:45 PST] - Issue: MCP parameter passing confusion

**What I was trying to do:**
Call the `validate_xanoscript` tool via mcporter using JSON syntax.

**What the issue was:**
The mcporter call syntax was unclear. These failed:
```bash
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
mcporter call xano validate_xanoscript file_path="/path/to/file.xs"
```

**Why it was an issue:**
The error message said "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even though I was passing file_path. The correct syntax turned out to be:
```bash
mcporter call xano validate_xanoscript file_path="/path/to/file.xs"
```

But only after using `mcporter list xano` to see the examples section which showed the correct format.

**Potential solution (if known):**
- Document the exact mcporter call syntax in the tool description
- Show examples in the error message when validation fails
- Support both JSON and key=value formats consistently

---

## [2026-02-16 09:43 PST] - Issue: Finding correct run job structure

**What I was trying to do:**
Understand the structure of a `run.xs` file for a run job.

**What the issue was:**
The xanoscript_docs topic "run" didn't return specific documentation about run job syntax. It returned the same general documentation as other topics.

**Why it was an issue:**
I had to inspect existing implementations in ~/xs/ to understand the structure. The run.xs structure with `run.job`, `main`, and `env` wasn't documented in the MCP docs I could access.

**Potential solution (if known):**
- Add specific documentation for run job files under the "run" topic
- Include the run.xs schema: `run.job "Name" { main = { name: "..." input: { ... } } env = [...] }`

---

## Summary

The main struggles were:
1. **Syntax nuances**: Default values, filter ordering, and type-specific syntax rules aren't clearly documented
2. **MCP tool usage**: Parameter passing format was trial-and-error
3. **Missing specific docs**: Run job structure had to be reverse-engineered from examples

The `validate_xanoscript` tool was very helpful once I figured out the syntax, and the error messages were actually quite good with helpful suggestions.
