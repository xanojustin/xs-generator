# Stripe Payment Monitor - Xano Run Job

## Overview

A Xano run job that fetches recent charges from Stripe and stores them in your database for record-keeping and analysis.

## What It Does

1. Connects to the Stripe API to fetch recent charges
2. Filters charges by status (default: succeeded)
3. Processes each charge and stores relevant data in the database
4. Returns a summary with count and total amounts

## Files

| File | Purpose |
|------|---------|
| `run.xs` | Run job configuration - defines the entry point and environment variables |
| `functions/fetch_recent_charges.xs` | Main function that fetches and processes Stripe charges |
| `tables/` | Contains table schema definitions |

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `stripe_secret_key` | Your Stripe secret API key (sk_live_... or sk_test_...) |

## Database Schema

### `processed_charges` table

| Field | Type | Description |
|-------|------|-------------|
| `charge_id` | text | Stripe charge ID (ch_...) |
| `amount` | int | Charge amount in cents |
| `currency` | text | Currency code (e.g., 'usd') |
| `customer_email` | text | Customer's receipt email |
| `description` | text | Charge description |
| `status` | text | Charge status (succeeded, pending, failed) |
| `created_at` | timestamp | When the charge was created in Stripe |
| `processed_at` | timestamp | When the charge was recorded in your database |

## How to Run

### In Xano:
1. Upload these files to your Xano workspace
2. Ensure the `processed_charges` table exists with proper schema
3. Set the `stripe_secret_key` environment variable
4. Deploy and run the job via Xano Job Runner

### Via Xano CLI:
```bash
xano run --job "Stripe Payment Monitor"
```

### Default Input Parameters

| Parameter | Type | Default Value | Description |
|-----------|------|---------------|-------------|
| `limit` | int | 10 | Number of charges to fetch (max 100) |
| `status` | text | "succeeded" | Filter by charge status |

## Response Format

```json
{
  "message": "Successfully processed 10 Stripe charges",
  "total_amount_cents": 150000,
  "total_amount_usd": 1500.00,
  "charge_count": 10,
  "charges_stored": 10
}
```

## Use Cases

This run job is useful for:
- Keeping a local copy of Stripe charges for reporting
- Reconciling payments with your internal records
- Building dashboards without hitting Stripe API repeatedly
- Auditing and accounting purposes

## Extending This Job

You could extend this to:
- Fetch other Stripe objects (invoices, subscriptions, refunds)
- Add date range filters for historical sync
- Deduplicate charges before storing
- Send notifications for high-value charges
- Integrate with accounting software

## API Reference

Uses the Stripe Charges API:
- Documentation: https://stripe.com/docs/api/charges
- Endpoint: `GET https://api.stripe.com/v1/charges`
