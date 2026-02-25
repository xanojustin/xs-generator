# Teemo Attacking

## Problem

In the game League of Legends, Teemo attacks an enemy with poison. Every time Teemo attacks, the enemy gets poisoned for a fixed duration. If Teemo attacks again before the poison ends, the poison duration **resets** (the new attack's poison overwrites the previous one).

Given:
- `time_series`: An array of timestamps (in seconds) when Teemo attacks
- `duration`: How long each poison attack lasts (in seconds)

Calculate the **total time** the enemy is poisoned.

### Example Logic

- Attack at time 1 with duration 2 → poisoned from 1 to 3
- Attack at time 4 with duration 2 → poisoned from 4 to 6
- **Total poisoned time: 4 seconds** (non-overlapping attacks)

If attacks overlap:
- Attack at time 1 with duration 2 → poisoned from 1 to 3
- Attack at time 2 with duration 2 → poison resets, now poisoned from 2 to 4
- **Total poisoned time: 3 seconds** (from 1 to 4, not 4 seconds)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/teemo_attacking.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `time_series` (int[]): Array of attack timestamps in ascending order
  - `duration` (int): Poison duration in seconds
- **Output:**
  - `total_poison` (int): Total seconds the enemy is poisoned

## Test Cases

| time_series | duration | Expected Output | Explanation |
|-------------|----------|-----------------|-------------|
| [1, 4] | 2 | 4 | Non-overlapping: (1→3) + (4→6) = 4 seconds |
| [1, 2] | 2 | 3 | Overlapping: attack at 2 resets poison, total 1→4 = 3 seconds |
| [] | 100 | 0 | Edge case: no attacks means no poison |
| [5] | 10 | 10 | Edge case: single attack = full duration |
| [1, 2, 3, 4, 5] | 5 | 9 | Series of overlapping attacks: from 1 to 10 = 9 seconds |
| [1, 2, 10, 11] | 2 | 6 | Mixed: overlapping (1→3) + non-overlapping (10→12) = 6 seconds |
