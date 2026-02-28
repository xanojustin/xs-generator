# Design Parking System

## Problem
Design a parking system for a parking lot. The parking lot has three kinds of parking spaces: big, medium, and small, with a fixed number of slots for each size.

The parking system should:
- Initialize with a fixed number of big, medium, and small parking spots
- Accept requests to park cars of different types (1 = big, 2 = medium, 3 = small)
- Return whether a car can be parked based on available spots for that car type
- Cars can only park in spots matching their type (big cars in big spots, etc.)

## Structure
- **Run Job (`run.xs`):** Calls the test function to run all test cases
- **Function (`function/parking-system.xs`):** Contains the parking system logic that checks if a car can be parked
- **Function (`function/parking-system-test.xs`):** Runs multiple test cases and returns results

## Function Signature

### parking-system
- **Input:**
  - `big` (int): Number of available big parking spots
  - `medium` (int): Number of available medium parking spots
  - `small` (int): Number of available small parking spots
  - `carType` (int): Type of car (1 = big, 2 = medium, 3 = small)
- **Output:** (bool) - `true` if the car can be parked, `false` otherwise

### parking-system-test
- **Input:** None
- **Output:** (object) - Results of all test cases

## Test Cases

| Test | Input (big, medium, small, carType) | Expected Output |
|------|-------------------------------------|-----------------|
| Big car with big spot | (1, 0, 0, 1) | true |
| Medium car with medium spot | (0, 1, 0, 2) | true |
| Small car with no spots | (0, 0, 0, 3) | false |
| Invalid car type | (5, 5, 5, 4) | false |
| Small car with spots | (0, 0, 3, 3) | true |
| Big car with no big spots | (0, 2, 2, 1) | false |
| Medium car with no medium spots | (1, 0, 1, 2) | false |
