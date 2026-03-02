# Rate Limiter

## Problem
Implement a **Sliding Window Rate Limiter** that controls the rate of requests per user. The rate limiter should allow a maximum number of requests within a given time window for each unique user.

Given a list of requests (each with a timestamp and user_id), return an array of booleans indicating whether each request is allowed (true) or rate limited (false).

## Structure
- **Run Job (`run.xs`):** Calls the rate_limiter function with test inputs simulating 8 requests from 2 users
- **Function (`function/rate_limiter.xs`):** Contains the sliding window rate limiter logic

## Function Signature
- **Input:**
  - `requests` (object[]): Array of request objects, each containing:
    - `timestamp` (int): The time of the request
    - `user_id` (text): The user making the request
  - `limit` (int): Maximum number of requests allowed in the time window
  - `window` (int): Time window duration in seconds
- **Output:** (bool[]): Array of booleans where true = request allowed, false = rate limited

## Algorithm
The sliding window algorithm:
1. For each request, calculate the window start: `current_time - window + 1`
2. Filter the user's request history to only include timestamps within the window
3. If the count of recent requests is less than the limit, allow the request
4. Otherwise, rate limit the request
5. Update the user's history (maintaining sliding window behavior)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `requests: [{t:1,u:"user1"},{t:1,u:"user2"},{t:2,u:"user1"},{t:3,u:"user1"},{t:4,u:"user1"},{t:5,u:"user1"},{t:6,u:"user1"},{t:7,u:"user1"}]`, `limit: 5`, `window: 5` | `[true, true, true, true, true, true, true, false]` |

### Test Case Breakdown:

**Basic/Happy Path Cases:**
- User2's single request at t=1 is allowed (user2 has no prior requests)
- User1's first 5 requests (t=1,2,3,4,5) are all allowed (within limit)

**Edge Cases:**
- Empty request array would return empty results (handled by loop logic)
- Zero limit would rate limit all requests (not explicitly tested but algorithm handles it)

**Boundary/Interesting Cases:**
- At t=6: User1's 6th request is allowed because the sliding window excludes t=1 (window is t=2 to t=6), so only 4 requests count
- At t=7: User1's 7th request is rate limited because the window (t=3 to t=7) contains 5 requests (t=3,4,5,6)

**Expected Output for Run Job:** `[true, true, true, true, true, true, true, false]`
- Request 1 (user1, t=1): ✅ Allowed (0 prior in window)
- Request 2 (user2, t=1): ✅ Allowed (0 prior in window, different user)
- Request 3 (user1, t=2): ✅ Allowed (1 prior: t=1)
- Request 4 (user1, t=3): ✅ Allowed (2 prior: t=1,2)
- Request 5 (user1, t=4): ✅ Allowed (3 prior: t=1,2,3)
- Request 6 (user1, t=5): ✅ Allowed (4 prior: t=1,2,3,4)
- Request 7 (user1, t=6): ✅ Allowed (4 prior: t=2,3,4,5 - window slid)
- Request 8 (user1, t=7): ❌ Rate Limited (5 prior: t=3,4,5,6 - at limit)
