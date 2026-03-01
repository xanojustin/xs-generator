# Fraction Addition

## Problem
Given a string expression representing an expression of fractions, add/subtract all the fractions and return the result as a string in the form "numerator/denominator".

The input string contains an expression of fractions that need to be added and subtracted. The fractions are in the format "numerator/denominator" and can be positive or negative. The fractions are separated by '+' or '-' operators.

For example:
- "-1/2+1/2" should return "0/1"
- "-1/2+1/2+1/3" should return "1/3"
- "1/3-1/2" should return "-1/6"

The result fraction should be in its reduced form (numerator and denominator have no common factors other than 1).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/fraction_addition.xs`):** Contains the solution logic

## Function Signature
- **Input:** `expression` (text) - A string containing fraction expressions like "-1/2+1/2+1/3"
- **Output:** (text) - The sum as a reduced fraction in the format "numerator/denominator"

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| "-1/2+1/2" | "0/1" |
| "-1/2+1/2+1/3" | "1/3" |
| "1/3-1/2" | "-1/6" |
| "5/3+1/6" | "11/6" |
| "-7/3" | "-7/3" (single fraction) |
