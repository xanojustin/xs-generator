# Angle Between Hands of a Clock

## Problem
Given two numbers, `hour` and `minutes`, return the smaller angle (in degrees) formed between the hour and the minute hand on an analog clock.

**Notes:**
- The hour hand moves continuously (not just on the hour marks)
- At 12:00, both hands are at 0 degrees
- The angle should always be the smaller one (≤ 180 degrees)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/calculate_clock_angle.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `hour` (int): Hour value from 1 to 12
  - `minutes` (int): Minutes value from 0 to 59
- **Output:** 
  - `result` (decimal): The smaller angle between the two hands in degrees

## How It Works

1. **Hour Hand Position:** Each hour represents 30 degrees (360° / 12 hours), and the hour hand also moves 0.5 degrees per minute (30° / 60 minutes).
   - Formula: `hour_angle = 30 * hour + 0.5 * minutes`

2. **Minute Hand Position:** Each minute represents 6 degrees (360° / 60 minutes).
   - Formula: `minute_angle = 6 * minutes`

3. **Calculate Difference:** Find the absolute difference between the two angles.

4. **Return Smaller Angle:** The angle between hands could be `diff` or `360 - diff`. Return the smaller one.

## Test Cases

| Input (hour, minutes) | Expected Output | Explanation |
|-----------------------|-----------------|-------------|
| (12, 30) | 165 | Hour hand at 15°, minute hand at 180°, diff = 165° |
| (3, 30) | 75 | Hour hand at 105°, minute hand at 180°, diff = 75° |
| (3, 15) | 7.5 | Hour hand at 97.5°, minute hand at 90°, diff = 7.5° |
| (6, 0) | 180 | Hour hand at 180°, minute hand at 0°, diff = 180° |
| (12, 0) | 0 | Both hands at 0° |
| (1, 57) | 76.5 | Edge case with large minute value |

## Example

At 3:30:
- Hour hand: 3 × 30 + 30 × 0.5 = 90 + 15 = 105 degrees
- Minute hand: 30 × 6 = 180 degrees
- Difference: |105 - 180| = 75 degrees
- Smaller angle: min(75, 285) = 75 degrees
