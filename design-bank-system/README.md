# Design a Bank System

## Problem
Design a simple bank system that supports basic banking operations:
- **Deposit**: Add money to an account
- **Withdraw**: Remove money from an account (with balance check)
- **Transfer**: Move money between accounts
- **Check Balance**: View current account balance

The system initializes with three accounts pre-loaded with starting balances:
- Account 1: $1000
- Account 2: $500  
- Account 3: $0

All operations validate inputs and return appropriate success/error responses.

## Structure
- **Run Job (`run.xs`):** Entry point that calls the bank system function with test inputs
- **Function (`function/bank-system.xs`):** Implements the bank system logic with all four operations

## Function Signature

### Input
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `operation` | `text` | Yes | Operation to perform: `"deposit"`, `"withdraw"`, `"transfer"`, or `"balance"` |
| `account_id` | `int` | Yes | The account ID to operate on |
| `amount` | `int?` | No | Amount for deposit/withdraw/transfer (ignored for balance check) |
| `target_account_id` | `int?` | No | Target account ID for transfers |

### Output
Returns an object with:
- `success` (bool): Whether the operation succeeded
- `account_id` (int): The account operated on (for deposit/withdraw/balance)
- `balance` (int): The new/current balance (for deposit/withdraw/balance)
- `from_account` / `to_account` (int): Account IDs for transfers
- `from_balance` / `to_balance` (int): Updated balances for transfers
- `deposited` / `withdrawn` / `transferred` (int): Amount for successful operations
- `error` (text): Error message if operation failed

## Test Cases

| Operation | Input Parameters | Expected Output |
|-----------|-----------------|-----------------|
| Balance | `account_id: 1` | `success: true`, `balance: 1000` |
| Balance | `account_id: 2` | `success: true`, `balance: 500` |
| Deposit | `account_id: 3`, `amount: 250` | `success: true`, `balance: 250`, `deposited: 250` |
| Withdraw | `account_id: 1`, `amount: 200` | `success: true`, `balance: 800`, `withdrawn: 200` |
| Withdraw (insufficient) | `account_id: 3`, `amount: 100` | `success: false`, `error: "Insufficient funds"` |
| Transfer | `account_id: 1`, `target_account_id: 3`, `amount: 300` | `success: true`, `from_balance: 700`, `to_balance: 300` |
| Invalid operation | `operation: "invalid"` | `success: false`, `error: "Unknown operation"` |
| Invalid amount | `operation: "deposit"`, `amount: -50` | `success: false`, `error: "Invalid deposit amount"` |
