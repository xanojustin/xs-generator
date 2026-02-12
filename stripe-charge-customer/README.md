# Stripe Charge Customer - Xano Run Job

## Overview

This Xano run job automatically charges customers for pending invoices using the Stripe API.

## What It Does

1. Queries the database for pending invoices that are due
2. For each invoice, retrieves the associated customer
3. If the customer has Stripe credentials stored, creates a PaymentIntent
4. Processes the payment off-session (no customer interaction required)
5. Updates invoice status based on payment result
6. Returns a summary of all processed invoices

## Files

| File | Purpose |
|------|---------|
| `run.xs` | Run job configuration - defines the entry point and environment variables |
| `functions/charge_pending_invoices.xs` | Main function that implements the Stripe integration logic |

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `STRIPE_SECRET_KEY` | Your Stripe secret API key (sk_live_... or sk_test_...) |

## Database Schema Assumptions

This run job expects the following tables:

### `invoice` table
- `id` - Invoice identifier
- `customer_id` - Reference to customer
- `status` - Invoice status (pending, paid, failed, etc.)
- `due_date` - When the invoice is due
- `amount_cents` - Amount in cents
- `paid_at` - Timestamp when paid
- `stripe_payment_intent_id` - Stripe payment intent ID

### `customer` table
- `id` - Customer identifier
- `stripe_customer_id` - Stripe customer ID
- `stripe_payment_method_id` - Stripe payment method ID for charging

## How to Run

### In Xano:
1. Upload these files to your Xano workspace
2. Ensure the required tables exist with proper schema
3. Set the `STRIPE_SECRET_KEY` environment variable
4. Deploy and run the job via Xano Job Runner

### Via Xano CLI:
```bash
xano run --job "Charge Pending Invoices"
```

## Payment Flow

1. **Success**: Invoice marked as `paid`, `paid_at` set to current time
2. **Requires Action**: Invoice marked as `requires_auth` (3D Secure needed)
3. **Failed**: Invoice marked as `failed`, error message stored
4. **Skipped**: No Stripe customer/payment method on file

## Response Format

```json
[
  {
    "invoice_id": 123,
    "status": "paid",
    "payment_intent_id": "pi_xxx"
  },
  {
    "invoice_id": 124,
    "status": "failed",
    "error": "card declined"
  }
]
```

## Notes

- Uses `off_session=true` and `confirm=true` for automatic charging
- Supports USD currency only (easily changed in the function)
- Logs debug info for each processed invoice
