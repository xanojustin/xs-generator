# Clearbit Enrich Company Run Job

This XanoScript run job enriches company data using the Clearbit API.

## What It Does

This run job retrieves detailed company information from Clearbit's enrichment API. It handles:

- Looking up company data by domain name
- Extracting company metadata (name, description, industry, employees)
- Gathering company location and contact information
- Retrieving social media handles (Twitter, LinkedIn)
- Getting funding and technology stack information
- Returning structured company data with error handling

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `CLEARBIT_API_KEY` | Your Clearbit API key (starts with `sk_`) |

## How to Use

### Run the Job

The job is configured with a test domain (`stripe.com`) in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `domain` | text | Yes | Company domain to enrich (e.g., `stripe.com`, `xano.com`) |
| `company_name` | text | No | Optional company name to help with matching |
| `enrich_type` | text | No | Type of enrichment: `company` or `combined` (default: `company`) |

### Response

```json
{
  "success": true,
  "domain": "stripe.com",
  "company": {
    "name": "Stripe",
    "legal_name": "Stripe, Inc.",
    "logo": "https://logo.clearbit.com/stripe.com",
    "description": "Stripe is a technology company that builds economic infrastructure for the internet...",
    "industry": "Internet Software & Services",
    "employees": 4000,
    "founded_year": 2010,
    "funding_raised": 2200000000,
    "location": "San Francisco, CA, United States",
    "website": "https://stripe.com",
    "twitter_handle": "stripe",
    "linkedin_handle": "company/stripe",
    "tech_stack": ["Google Apps", "Marketo", "Salesforce", "Segment", "Zendesk"]
  },
  "raw_data": { /* Full Clearbit response */ },
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "domain": "notarealdomain.xyz",
  "company": {
    "name": null,
    "legal_name": null,
    "logo": null,
    "description": null,
    "industry": null,
    "employees": null,
    "founded_year": null,
    "funding_raised": null,
    "location": null,
    "website": null,
    "twitter_handle": null,
    "linkedin_handle": null,
    "tech_stack": []
  },
  "raw_data": null,
  "error": "Company not found for domain: notarealdomain.xyz"
}
```

## File Structure

```
clearbit-enrich-company/
├── run.xs                    # Run job definition
├── function/
│   └── enrich_company.xs     # Function to enrich company data
└── README.md                 # This file
```

## Clearbit API Reference

- [Company Enrichment API](https://dashboard.clearbit.com/docs#company-api)
- [API Authentication](https://dashboard.clearbit.com/docs#authentication)
- [Response Schema](https://dashboard.clearbit.com/docs#company-api-company-schema)

## Testing

Test with well-known domains:
- `stripe.com` - Fintech company
- `xano.com` - No-code backend platform
- `github.com` - Developer platform
- `slack.com` - Communication platform

## Rate Limits

Clearbit rate limits vary by plan:
- Free: 20 requests/month
- Growth: 2,500 requests/month
- Business: 10,000+ requests/month

## Security Notes

- Never commit your `CLEARBIT_API_KEY` to version control
- Use environment variables for API keys
- Consider implementing rate limiting for production use
- Clearbit API keys should be kept confidential

## Use Cases

- Lead enrichment for sales teams
- Customer onboarding data collection
- CRM data augmentation
- Market research and competitive analysis
- Form auto-completion by domain
