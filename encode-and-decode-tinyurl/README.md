# Encode and Decode TinyURL

## Problem
Design a TinyURL service that encodes long URLs into short URLs and decodes short URLs back to their original long URLs.

This is a classic system design interview question that tests your ability to:
- Design a key generation system
- Handle bidirectional mappings (encode/decode)
- Manage in-memory storage (simulating a database)
- Handle edge cases like duplicate URLs

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs to demonstrate encoding a long URL
- **Function (`function/tinyurl_service.xs`):** Contains the complete TinyURL service implementation with encode and decode operations

## Function Signature
- **Input:** 
  - `operation` (text): Either "encode" or "decode"
  - `url` (text, optional): The original long URL (required for encode)
  - `tinyurl` (text, optional): The short URL (required for decode)
- **Output:** 
  - For encode: Object containing `operation`, `original_url`, `tinyurl`, and `short_key`
  - For decode: Object containing `operation`, `tinyurl`, `short_key`, and `original_url` (or `error` if not found)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{"operation": "encode", "url": "https://www.example.com/some/very/long/url/path"}` | Short URL like `http://tinyurl.com/15ftgA` with corresponding key |
| `{"operation": "decode", "tinyurl": "http://tinyurl.com/15ftgA"}` | Original URL `https://www.example.com/some/very/long/url/path` |
| `{"operation": "encode", "url": ""}` | Error: "URL is required for encode operation" |
| `{"operation": "decode", "tinyurl": "http://tinyurl.com/nonexistent"}` | Error response: "URL not found" |

## Implementation Notes

The solution uses:
1. **Base62 Encoding**: Converts a counter to a short alphanumeric key using 0-9, A-Z, a-z
2. **In-Memory Storage**: A JSON object simulates the database mapping short keys to original URLs
3. **Duplicate Detection**: Checks if a URL already exists before creating a new short key
4. **Key Padding**: Ensures all keys are at least 6 characters for consistency

## Algorithm Complexity
- **Time Complexity:** O(n) for encoding (where n is the counter size), O(1) for lookup
- **Space Complexity:** O(m) where m is the number of unique URLs stored
