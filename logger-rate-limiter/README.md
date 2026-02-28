# Logger Rate Limiter

## Problem
Design a logger system that receives messages and timestamps. The system should return `true` if a message should be printed, and `false` otherwise. A message should only be printed if it hasn't been printed in the last 10 seconds.

This is a classic system design interview question that tests your ability to:
- Manage state across function calls
- Implement time-based logic
- Handle edge cases like new messages and expired cooldowns

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/should_print_message.xs`):** Contains the rate limiter logic

## Function Signature
- **Input:**
  - `message` (text): The message to potentially print
  - `timestamp` (int): Current timestamp in seconds
  - `message_history` (object, optional): Map of message -> last printed timestamp
- **Output:**
  - `should_print` (bool): Whether the message should be printed
  - `updated_history` (object): Updated message history map

## Algorithm
1. Look up the last printed timestamp for the given message in the history
2. If the message was never printed (not in history), allow it
3. If the message was printed 10 or more seconds ago, allow it
4. Otherwise, block the message (within cooldown period)
5. If allowed, update the history with the new timestamp
6. Return the decision and updated history

## Test Cases

| message | timestamp | message_history | Expected Output |
|---------|-----------|-----------------|-----------------|
| "hello" | 1 | `{}` | `should_print: true`, history: `{"hello": 1}` |
| "hello" | 2 | `{"hello": 1}` | `should_print: false`, history unchanged |
| "world" | 3 | `{"hello": 1}` | `should_print: true`, history: `{"hello": 1, "world": 3}` |
| "hello" | 11 | `{"hello": 1}` | `should_print: true`, history: `{"hello": 11}` |
| "" | 5 | `{}` | `should_print: true`, history: `{"": 5}` (empty string edge case) |

### Test Case Explanations

1. **New message:** Should always print and be added to history
2. **Within cooldown:** Same message at t=2 when last printed at t=1 (only 1 second apart) → should NOT print
3. **Different message:** New messages should always print, existing history preserved
4. **After cooldown:** Same message at t=11 when last printed at t=1 (10 seconds apart) → should print
5. **Empty message:** Edge case - empty string should be handled like any other message

## Example Usage

```xs
// First call - new message
function.run "should_print_message" {
  input = {
    message: "hello"
    timestamp: 1
    message_history: {}
  }
} as $result1
// $result1.should_print = true
// $result1.updated_history = {"hello": 1}

// Second call - same message within 10 seconds
function.run "should_print_message" {
  input = {
    message: "hello"
    timestamp: 5
    message_history: $result1.updated_history
  }
} as $result2
// $result2.should_print = false (only 4 seconds elapsed)
// $result2.updated_history = {"hello": 1} (unchanged)

// Third call - after cooldown period
function.run "should_print_message" {
  input = {
    message: "hello"
    timestamp: 12
    message_history: $result2.updated_history
  }
} as $result3
// $result3.should_print = true (11 seconds elapsed)
// $result3.updated_history = {"hello": 12}
```
