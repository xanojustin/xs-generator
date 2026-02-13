# Algolia Index Sync Run Job

This Xano Run Job automatically syncs product records from your local Xano database to Algolia's search index.

## What It Does

The `algolia_index_sync` task runs daily and:

1. Queries the `products` table for records where `is_indexed` is `false` or `null`
2. Sends each unindexed product to Algolia's search index via their REST API
3. Updates the local database record with:
   - `is_indexed: true`
   - `indexed_at: timestamp`
   - `algolia_object_id: the Algolia object ID`
4. Logs the results (success count, failure count, any errors)

## Required Environment Variables

Add these to your Xano workspace environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `algolia_app_id` | Your Algolia Application ID | `ABC123DEF456` |
| `algolia_api_key` | Your Algolia Write API Key (not the Search-only key) | `your_write_api_key_here` |

## Database Table Schema

The task expects a `products` table with these fields:

```
- id (int, primary key)
- name (text)
- description (text)
- category (text)
- price (decimal)
- sku (text)
- tags (json)
- in_stock (bool)
- created_at (timestamp)
- is_indexed (bool, nullable) - tracks indexing status
- indexed_at (timestamp, nullable) - when it was indexed
- algolia_object_id (text, nullable) - Algolia's object ID
```

## Algolia Index Configuration

The task sends products to an Algolia index named `products` with this object structure:

```json
{
  "objectID": "product_id_as_string",
  "name": "Product Name",
  "description": "Product description...",
  "category": "Category Name",
  "price": 29.99,
  "sku": "SKU-12345",
  "tags": ["tag1", "tag2"],
  "in_stock": true,
  "created_at": "2026-02-13T10:30:00Z"
}
```

## Schedule

- **Runs:** Daily at 2:00 AM UTC
- **Frequency:** Every 24 hours (86400 seconds)
- **Batch Size:** Up to 100 products per run

## How to Use

1. Set up your Algolia account and create an index called `products`
2. Add the required environment variables to Xano
3. Create the `products` table with the fields listed above
4. Add products to your database (they'll have `is_indexed = null` by default)
5. The task will automatically pick them up on the next run

## Manual Trigger

You can also manually trigger this task from the Xano dashboard if you need to run it immediately.

## Monitoring

Check the task execution logs in Xano to see:
- How many products were indexed
- Any failures or errors
- API response details

## File Structure

```
algolia-index-records/
├── README.md
└── tasks/
    └── algolia_index_sync.xs
```
