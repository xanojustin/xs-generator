# Clearbit Company Enrichment Run Job

This Xano run job enriches company data using the Clearbit Company API. Pass a company domain and get back detailed company information including name, description, logo, location, employee count, industry, and social media handles.

## What It Does

The run job calls Clearbit's Company API to retrieve enriched company data from a domain name. This is useful for:

- Lead enrichment and qualification
- CRM data augmentation
- Company research and profiling
- Automatic company logo/description fetching

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `clearbit_api_key` | Your Clearbit API key | Sign up at [clearbit.com](https://clearbit.com) and get your API key from the dashboard |

## How to Use

### Running the Job

```bash
# Using Xano CLI
xano run execute --job "Clearbit Company Enrichment"

# With custom domain
xano run execute --job "Clearbit Company Enrichment" --input '{"domain": "example.com"}'
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | text | Yes | The company domain to enrich (e.g., "stripe.com") |

### Example Response

```json
{
  "domain": "stripe.com",
  "name": "Stripe",
  "legal_name": "Stripe, Inc.",
  "description": "Stripe is a suite of payment APIs that powers commerce for online businesses.",
  "logo": "https://logo.clearbit.com/stripe.com",
  "website": "https://stripe.com",
  "founded_year": 2010,
  "employees": 8000,
  "employees_range": "5001-10000",
  "industry": "Software",
  "sector": "Information Technology",
  "tags": ["Payments", "SaaS", "Financial Services"],
  "location": {
    "city": "San Francisco",
    "state": "CA",
    "country": "US",
    "postal_code": "94105"
  },
  "linkedin": "stripe",
  "twitter": "stripe",
  "facebook": "Stripe",
  "enriched_at": "2025-02-18T10:30:00Z"
}
```

## Error Handling

The run job handles these error cases:

- **404 Not Found**: Company not found for the given domain
- **401 Unauthorized**: Invalid or missing API key
- **API Errors**: Other Clearbit API errors with status code

## File Structure

```
clearbit-enrich-company/
├── run.xs                 # Run job configuration
├── function/
│   └── enrich_company.xs  # Main enrichment function
└── README.md              # This file
```

## API Reference

- [Clearbit Company API Docs](https://dashboard.clearbit.com/docs#company-api)
- Rate limits apply based on your Clearbit plan
