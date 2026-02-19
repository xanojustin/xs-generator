# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 08:05 PST] - Unknown filter functions 'ord' and 'chr'

**What I was trying to do:** Implement a Caesar cipher that shifts letters by converting characters to ASCII codes, adding the shift amount, and converting back to characters.

**What the issue was:** I assumed XanoScript would have `ord` (character to ASCII code) and `chr` (ASCII code to character) filters since these are common in many programming languages. The validation revealed these filters don't exist.

**Why it was an issue:** I had to completely rethink the algorithm. Instead of the efficient ASCII math approach, I had to use a brute-force array search approach:
- Create arrays of all 26 uppercase and 26 lowercase letters
- For each character, loop through the arrays to find a match
- Use the index for shifting with modulo arithmetic
- Look up the shifted character by index

This makes the code much more verbose and less efficient (O(n*m) instead of O(n) where n is text length and m is alphabet size).

**Potential solution (if known):** 
1. Add `ord` and `chr` filters to XanoScript for character/ASCII conversions
2. Add a `char_code` filter that returns the Unicode/ASCII code point
3. Add a `from_char_code` filter to convert back
4. Document available string manipulation filters more prominently in the quickstart guide

## [2026-02-19 08:04 PST] - Filter expression parentheses requirement unclear

**What I was trying to do:** Check if the input text is empty using `$input.text|strlen == 0`.

**What the issue was:** The validator complained that "An expression should be wrapped in parentheses when combining filters and tests." I had to change it to `($input.text|strlen) == 0`.

**Why it was an issue:** This syntax requirement isn't immediately obvious from the documentation. Most languages don't require parentheses around filtered expressions in comparisons.

**Potential solution (if known):** 
1. Include this specific case in the "Common Mistakes" section of the quickstart documentation
2. The error message was helpful but could include an example of the correct syntax

## [2026-02-19 08:03 PST] - Parameter passing format for validate_xanoscript

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter with JSON parameters.

**What the issue was:** The `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file"}'` format didn't work. After several attempts, `mcporter call xano validate_xanoscript directory=/path/to/dir` worked.

**Why it was an issue:** The tool's help text shows JSON parameter format in the examples (`Examples: mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)`), but the actual working syntax is different (key=value without quotes).

**Potential solution (if known):** 
1. Update the mcporter examples to show the correct syntax
2. Or make JSON parameter format work as shown in examples
3. Add a note about the key=value syntax in the tool description

## General Observations

1. **No character manipulation filters:** Beyond the missing ord/chr, it would be helpful to have filters like `is_alpha`, `is_digit`, `is_upper`, `is_lower`, `to_upper`, `to_lower` for common string operations.

2. **Finding array index:** The current approach to find an element's index in an array requires manual iteration. An `index_of` filter would be very useful.

3. **Array contains check:** Similarly, a `contains` filter for arrays would simplify "is this character a letter?" checks.

4. **Documentation discovery:** The `xanoscript_docs` tool returned the same overview content for different topics (`functions`, `quickstart`, `syntax`). It wasn't clear if I was getting the right detailed documentation or if those sections just don't have unique content yet.
