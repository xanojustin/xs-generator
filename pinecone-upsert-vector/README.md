# Pinecone Upsert Vector Run Job

This XanoScript run job upserts (inserts or updates) a vector into a Pinecone vector database index.

## What It Does

This run job adds or updates a vector embedding in a Pinecone index. It handles:

- Upserting a vector with specified ID and values
- Optional metadata attachment to the vector
- Namespace support for organizing vectors
- Proper error handling and response formatting

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `PINECONE_API_KEY` | Your Pinecone API key |
| `PINECONE_ENVIRONMENT` | Your Pinecone environment (e.g., `gcp-starter`, `us-east-1-aws`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `index_name` | text | Yes | Name of your Pinecone index |
| `id` | text | Yes | Unique identifier for the vector (e.g., `doc-001`) |
| `values` | list | Yes | Array of float values representing the vector embedding |
| `namespace` | text | No | Namespace within the index for organization (default: none) |
| `metadata` | object | No | JSON object with metadata to attach to the vector |

### Response

```json
{
  "success": true,
  "upserted_count": 1,
  "vector_id": "vec-001",
  "index_name": "my-index",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "upserted_count": 0,
  "vector_id": "vec-001",
  "index_name": "my-index",
  "error": "Index not found"
}
```

## File Structure

```
pinecone-upsert-vector/
├── run.xs                    # Run job definition
├── function/
│   └── upsert_vector.xs      # Function to upsert vector
└── README.md                 # This file
```

## Pinecone API Reference

- [Upsert Vectors API](https://docs.pinecone.io/reference/upsert)
- [Vector Database Concepts](https://docs.pinecone.io/docs/overview)

## Example Usage

### Basic Vector Upsert

```json
{
  "index_name": "my-embeddings",
  "id": "article-123",
  "values": [0.1, 0.2, 0.3, ...]  // Your embedding vector
}
```

### With Metadata

```json
{
  "index_name": "my-embeddings",
  "id": "article-123",
  "values": [0.1, 0.2, 0.3, ...],
  "namespace": "articles",
  "metadata": {
    "title": "Introduction to Vector Databases",
    "author": "John Doe",
    "category": "technology",
    "published_date": "2024-01-15"
  }
}
```

## Security Notes

- Never commit your `PINECONE_API_KEY` to version control
- Use environment-specific indexes (dev/staging/production)
- Consider namespace isolation for multi-tenant applications
