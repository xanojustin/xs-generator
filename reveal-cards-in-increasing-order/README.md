# Reveal Cards In Increasing Order

## Problem

You are given an integer array `deck` where `deck[i]` represents the number written on the `i-th` card.

You can reorder the deck in any order you want. Initially, all cards are face down (unrevealed) in one deck.

You will do the following steps repeatedly until all cards are revealed:

1. Take the top card of the deck, reveal it, and take it out of the deck.
2. If there are still cards in the deck, put the next top card of the deck at the bottom of the deck.
3. If there are still unrevealed cards, go back to step 1. Return the ordering of the deck that would reveal the cards in **increasing order**.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reveal_cards.xs`):** Contains the solution logic using a queue simulation

## Function Signature

- **Input:** 
  - `deck` (int[]): Array of integers representing the deck of cards
- **Output:** 
  - int[]: The ordering of the deck that reveals cards in increasing order

## Algorithm

The solution uses a queue simulation approach:

1. Sort the deck in increasing order
2. Initialize a queue with indices 0 to n-1 (representing positions in the result)
3. For each card in sorted order (smallest to largest):
   - Take the front index from the queue and place the card there
   - If the queue is not empty, move the next front index to the back of the queue
4. Return the result array

This simulates the reveal process in reverse — we're determining where each card must start to be revealed in sorted order.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[17, 13, 11, 2, 3, 5, 7]` | `[2, 13, 3, 11, 5, 17, 7]` |
| `[1, 2, 3, 4, 5]` | `[1, 5, 2, 4, 3]` |
| `[1]` | `[1]` |
| `[1, 1000]` | `[1, 1000]` |

### Explanation of Example 1

Sorted deck: `[2, 3, 5, 7, 11, 13, 17]`

Starting with indices queue: `[0, 1, 2, 3, 4, 5, 6]`

1. Place `2` at index `0`, move index `1` to back → Queue: `[2, 3, 4, 5, 6, 1]`
2. Place `3` at index `2`, move index `3` to back → Queue: `[4, 5, 6, 1, 3]`
3. Place `5` at index `4`, move index `5` to back → Queue: `[6, 1, 3, 5]`
4. Place `7` at index `6`, move index `1` to back → Queue: `[3, 5, 1]`
5. Place `11` at index `3`, move index `5` to back → Queue: `[1, 5]`
6. Place `13` at index `1`, move index `5` to back → Queue: `[5]`
7. Place `17` at index `5` → Queue: `[]`

Result: `[2, 13, 3, 11, 5, 17, 7]`

## Complexity

- **Time Complexity:** O(n log n) due to sorting, where n is the number of cards
- **Space Complexity:** O(n) for the queue and result array
