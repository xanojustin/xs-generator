# Pinecone Upsert Vector Run Job

This Xano Run Job upserts (inserts or updates) a vector embedding into a Pinecone vector database index.

## What This Run Job Does

The `pinecone-upsert-vector` run job stores vector embeddings in Pinecone, a managed vector database service. This is commonly used for:

- Storing AI/ML embeddings (text, image, audio)
- Building semantic search applications
- Creating recommendation systems
- Implementing similarity matching

## Prerequisites

1. A Pinecone account (https://www.pinecone.io/)
2. A Pinecone index created in your project
3. Your Pinecone API key
4. The index host URL from your Pinecone dashboard

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `pinecone_api_key` | Your Pinecone API key (found in Pinecone console) |

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `index_host` | text | Yes | Pinecone index host URL (e.g., `https://my-index-12345.svc.us-east1-gcp.pinecone.io`) |
| `vector_id` | text | Yes | Unique identifier for the vector (used for updates/retrieval) |
| `vector_values` | vector | Yes | Array of float values representing the embedding |
| `namespace` | text | No | Namespace for the vector (default: `"default"`) |
| `metadata` | json | No | Optional JSON object with additional data attached to the vector |

## Usage

### Basic Usage

```bash
# Using xano CLI
xano run execute pinecone-upsert-vector --input '{
  "index_host": "https://my-index.svc.us-east1-gcp.pinecone.io",
  "vector_id": "doc_123",
  "vector_values": [0.1, 0.2, 0.3, 0.4, 0.5]
}'
```

### With Metadata

```bash
xano run execute pinecone-upsert-vector --input '{
  "index_host": "https://my-index.svc.us-east1-gcp.pinecone.io",
  "vector_id": "article_456",
  "vector_values": [0.1, 0.2, 0.3, 0.4, 0.5],
  "namespace": "articles",
  "metadata": {
    "title": "Getting Started with Vector Databases",
    "author": "Jane Doe",
    "category": "technology"
  }
}'
```

## Response

On success, returns:

```json
{
  "success": true,
  "upsertedCount": 1,
  "message": "Vector upserted successfully to Pinecone"
}
```

On error, throws `PineconeAPIError` with details.

## Getting Your Index Host

1. Log into Pinecone Console: https://app.pinecone.io
2. Navigate to your index
3. Copy the "Host" URL from the index details

## API Reference

- Pinecone Docs: https://docs.pinecone.io/
- Upsert API: https://docs.pinecone.io/reference/upsert

## Related Operations

To query vectors after upserting, you would use the Pinecone query endpoint:
```
POST https://<index-host>/query
```

## Notes

- Vector dimensions must match your index configuration
- Metadata can store up to 40KB per vector
- Namespaces allow logical separation of vectors within the same index