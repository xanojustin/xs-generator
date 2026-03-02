# My Calendar I

## Problem

Implement a calendar class that can book events. Each event has a start time and end time (half-open interval `[start, end)`), and the calendar should prevent double-booking.

Your calendar must support:
- **Booking events**: Attempt to book a new event with a start and end time
- The function returns `true` if the event can be booked (no overlap with existing events), `false` otherwise

Two events `[s1, e1)` and `[s2, e2)` overlap if `s1 < e2` AND `s2 < e1`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with multiple test booking attempts
- **Function (`function/my_calendar.xs`):** Contains the calendar logic with event storage and overlap detection

## Function Signature

- **Input:**
  - `bookings` (array of objects): Array of booking attempts, each with:
    - `start` (int): Start time of the event
    - `end` (int): End time of the event
- **Output:**
  - Array of booleans indicating whether each booking attempt was successful

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[{start: 10, end: 20}, {start: 15, end: 25}, {start: 20, end: 30}]` | `[true, false, true]` |
| `[{start: 1, end: 5}, {start: 5, end: 10}]` | `[true, true]` (adjacent, not overlapping) |
| `[]` | `[]` (no bookings) |
| `[{start: 5, end: 10}, {start: 5, end: 10}]` | `[true, false]` (exact same time) |

### Test Case Descriptions

1. **Basic case:** First booking succeeds, second overlaps (fails), third doesn't overlap (succeeds)
2. **Adjacent case:** Events that touch but don't overlap should both succeed `[1,5)` and `[5,10)`
3. **Edge case:** Empty input returns empty results
4. **Exact overlap:** Same time slot cannot be booked twice
