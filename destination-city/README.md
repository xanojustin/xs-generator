# Destination City

## Problem

You are given an array of travel paths where `paths[i] = [cityAi, cityBi]` means there exists a direct path going from `cityAi` to `cityBi`. Return the destination city, that is, the city without any path outgoing to another city.

It is guaranteed that the graph of paths forms a line without any loop, therefore, there will be exactly one destination city.

### Examples

**Example 1:**
- Input: paths = [["London","New York"],["New York","Lima"],["Lima","Sao Paulo"]]
- Output: "Sao Paulo"
- Explanation: Starting at "London" city you will reach "Sao Paulo" city which is the destination city. Your trip consist of: "London" -> "New York" -> "Lima" -> "Sao Paulo".

**Example 2:**
- Input: paths = [["B","C"],["D","B"],["C","A"]]
- Output: "A"
- Explanation: All possible trips are: 
  - "D" -> "B" -> "C" -> "A"
  - "B" -> "C" -> "A"
  - "C" -> "A"
  - "A"
  Clearly the destination city is "A".

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_destination_city.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `paths` (json): An array of paths where each path is a two-element array `[source_city, destination_city]`
- **Output:** 
  - `destination` (text): The name of the destination city (the city with no outgoing paths)

## Algorithm

The solution uses a set-based approach:
1. Collect all source cities (cities that appear as the first element in any path)
2. Iterate through all destination cities (second element of each path)
3. Return the destination city that is NOT in the set of source cities

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[["London","New York"],["New York","Lima"],["Lima","Sao Paulo"]]` | `"Sao Paulo"` |
| `[["B","C"],["D","B"],["C","A"]]` | `"A"` |
| `[["A","Z"]]` | `"Z"` (single path - edge case) |
| `[["a","b"],["b","c"],["c","d"],["d","e"]]` | `"e"` (longer chain) |
