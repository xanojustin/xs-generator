# Task Scheduler

## Problem
Given a characters array `tasks`, representing the tasks a CPU needs to do, where each letter represents a different task. Tasks could be done in any order. Each task is done in one unit of time. For each unit of time, the CPU could complete either one task or just be idle.

However, there is a non-negative integer `n` that represents the cooldown period between two same tasks (the same letter in the array), that is that there must be at least `n` units of time between any two same tasks.

Return the least number of units of times that the CPU will take to finish all the given tasks.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/task_scheduler.xs`):** Contains the solution logic using a greedy approach

## Function Signature
- **Input:**
  - `tasks` (text[]): Array of task identifiers (e.g., ["A", "A", "B"])
  - `n` (int): Cooldown period between identical tasks (non-negative)
- **Output:** 
  - (int): Minimum number of time units required to complete all tasks

## Algorithm Explanation
The solution uses a greedy approach:

1. **Count Task Frequencies:** Build a frequency map of all tasks
2. **Find Maximum Frequency:** Identify the task(s) that appear most frequently
3. **Calculate Minimum Time:** Use the formula:
   - `part_count = max_freq - 1` (number of chunks between max frequency tasks)
   - `part_length = n + 1` (length of each chunk including one max task)
   - `min_time = part_count * part_length + max_freq_count`
   - Final result: `max(min_time, total_tasks)` (handles cases where cooldown is small)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| tasks: ["A","A","A","B","B","B"], n: 2 | 8 | A → B → idle → A → B → idle → A → B |
| tasks: ["A","A","A","B","B","B"], n: 0 | 6 | No cooldown needed, tasks run sequentially |
| tasks: ["A"], n: 5 | 1 | Single task, no cooldown issues |
| tasks: ["A","B","C","D"], n: 2 | 4 | All unique tasks, no conflicts |
| tasks: ["A","A","A","B","B","C","C"], n: 2 | 7 | A → B → C → A → B → C → A |

## Edge Cases
- Empty tasks array (validated with precondition)
- Single task
- All unique tasks (no cooldown needed)
- Zero cooldown period
- Large cooldown periods requiring many idle slots
