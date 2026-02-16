# Meilisearch Index Document

A Xano Run Job that indexes documents into a [Meilisearch](https://www.meilisearch.com/) search engine instance.

## What It Does

This run job demonstrates how to integrate with Meilisearch, an open-source, typo-tolerant search engine. It sends a document to be indexed in a specified Meilisearch index, making it searchable.

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `meilisearch_host` | Your Meilisearch instance URL | `https://my-instance.meilisearch.io` or `http://localhost:7700` |
| `meilisearch_api_key` | Your Meilisearch API key (Master or Admin key for indexing) | `my-api-key-123` |

## How to Use

### 1. Set up Environment Variables

In your Xano workspace, set the required environment variables:
- `meilisearch_host` - The URL of your Meilisearch instance
- `meilisearch_api_key` - Your Meilisearch API key

### 2. Run the Job

The job will execute the `index_document` function which:
1. Takes an `index_name` (the Meilisearch index to add documents to)
2. Takes a `document` object with your data
3. Sends a POST request to Meilisearch's document indexing endpoint
4. Returns the task UID for tracking the indexing operation

### 3. Response

On success, you'll receive:
```json
{
  "success": true,
  "task_uid": 123,
  "index_name": "products",
  "message": "Document indexed successfully"
}
```

### Customizing

To index different documents, modify the `input` block in `run.xs`:

```xs
run.job "Meilisearch Index Document" {
  main = {
    name: "index_document"
    input: {
      index_name: "your_index_name"
      document: {
        id: "your_id"
        title: "Your Title"
        content: "Your searchable content"
      }
    }
  }
  env = ["meilisearch_host", "meilisearch_api_key"]
}
```

## Meilisearch Resources

- [Meilisearch Documentation](https://www.meilisearch.com/docs)
- [API Reference](https://www.meilisearch.com/docs/reference/api/documents)
- [Cloud Hosting](https://www.meilisearch.com/cloud)
