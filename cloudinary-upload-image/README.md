# Cloudinary Upload Image Run Job

This Xano Run Job uploads images to [Cloudinary](https://cloudinary.com/), a popular cloud-based image and video management service used by developers for media uploads, transformations, storage, and delivery.

## What It Does

The run job uploads an image from a URL to your Cloudinary account and returns the upload details including the public URL, dimensions, file size, and more.

## Required Environment Variables

Set these in your Xano workspace environment variables:

| Variable | Description | How to Get It |
|----------|-------------|---------------|
| `cloudinary_cloud_name` | Your Cloudinary cloud name | Found in your Cloudinary dashboard URL: `https://console.cloudinary.com/console/<cloud_name>/...` |
| `cloudinary_api_key` | Your Cloudinary API key | Cloudinary Dashboard → Settings → Security → API Key |
| `cloudinary_api_secret` | Your Cloudinary API secret | Cloudinary Dashboard → Settings → Security → API Secret |

## How to Use

### Basic Usage

```bash
# Using Xano CLI
xano run execute --job "Cloudinary Upload Image"
```

### With Custom Input

Modify the `run.xs` file to customize the upload:

```xs
run.job "Cloudinary Upload Image" {
  main = {
    name: "upload_image"
    input: {
      image_url: "https://your-domain.com/photo.jpg"
      public_id: "my_custom_name"
      folder: "products/2024"
    }
  }
  env = ["cloudinary_cloud_name", "cloudinary_api_key", "cloudinary_api_secret"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `image_url` | text | Yes | URL of the image to upload to Cloudinary |
| `public_id` | text | No | Custom identifier for the image in Cloudinary. If not provided, Cloudinary generates one. |
| `folder` | text | No | Folder path in Cloudinary (e.g., "products/photos") |

### Response

On success, the run job returns:

```json
{
  "success": true,
  "public_id": "my_custom_name",
  "secure_url": "https://res.cloudinary.com/<cloud_name>/image/upload/v1234567890/my_custom_name.jpg",
  "url": "http://res.cloudinary.com/<cloud_name>/image/upload/v1234567890/my_custom_name.jpg",
  "format": "jpg",
  "width": 1920,
  "height": 1080,
  "bytes": 234567,
  "created_at": "2024-01-15T10:30:00Z",
  "original_filename": "photo"
}
```

## Cloudinary API Reference

- [Upload API Documentation](https://cloudinary.com/documentation/image_upload_api_reference)
- [Authentication](https://cloudinary.com/documentation/upload_images#authenticated_requests)

## Notes

- The upload uses **authenticated uploads** with signature generation for security
- Images are uploaded as `image` resource type
- The upload is synchronous - the job waits for Cloudinary to process and return the result
- Maximum file size and other limits depend on your Cloudinary plan
