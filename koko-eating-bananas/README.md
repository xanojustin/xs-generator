# Koko Eating Bananas

## Problem

Koko loves to eat bananas. There are `n` piles of bananas, the `i`th pile has `piles[i]` bananas. The guards have gone and will come back in `h` hours.

Koko can decide her bananas-per-hour eating speed of `k`. Each hour, she chooses some pile of bananas and eats `k` bananas from that pile. If the pile has less than `k` bananas, she eats all of them instead and will not eat any more bananas during this hour.

Koko likes to eat slowly but still wants to finish eating all the bananas before the guards come back.

Return the **minimum integer `k`** such that she can eat all the bananas within `h` hours.

### Example 1
```
Input: piles = [3, 6, 7, 11], h = 8
Output: 4
```

### Example 2
```
Input: piles = [30, 11, 23, 4, 20], h = 5
Output: 30
```

### Example 3
```
Input: piles = [30, 11, 23, 4, 20], h = 6
Output: 23
```

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/koko_eating_bananas.xs`):** Contains the binary search solution logic

## Function Signature

- **Input:**
  - `piles` (int[]): Array of integers where piles[i] is the number of bananas in the ith pile
  - `h` (int): Number of hours before the guards return
- **Output:**
  - `int`: Minimum eating speed k (bananas per hour) to finish all bananas within h hours

## Algorithm

This problem uses **binary search**:

1. **Search space:** The minimum possible speed is 1 banana/hour, maximum is the largest pile size
2. **For each candidate speed `k`:** Calculate how many hours it would take to eat all bananas
   - Hours for each pile = `ceil(pile / k)`
3. **Binary search logic:**
   - If hours_needed ≤ h: We can eat at this speed, try slower (decrease right)
   - If hours_needed > h: We need to eat faster (increase left)
4. **Result:** The smallest speed where hours_needed ≤ h

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| piles: [3, 6, 7, 11], h: 8 | 4 | Speed 4: pile times are [1, 2, 2, 3] = 8 hours total |
| piles: [30, 11, 23, 4, 20], h: 5 | 30 | Must eat at max speed to finish in 5 hours |
| piles: [30, 11, 23, 4, 20], h: 6 | 23 | Speed 23: pile times are [2, 1, 1, 1, 1] = 6 hours |
| piles: [], h: 5 | 0 | Edge case: no piles means 0 speed needed |
| piles: [5], h: 5 | 1 | Single pile, plenty of time - minimum speed |
| piles: [5], h: 1 | 5 | Single pile, must finish in 1 hour |
