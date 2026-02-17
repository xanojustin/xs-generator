# Cloudinary Image Upload Run Job

This Xano Run Job uploads images to [Cloudinary](https://cloudinary.com), a cloud-based media management platform for storing, transforming, and delivering images and videos.

## What This Run Job Does

The run job uploads an image to Cloudinary with the following features:
- Upload images from URLs or base64 data
- Organize images into folders
- Assign custom public IDs
- Add tags for easy searching
- Control overwrite behavior
- Returns complete image metadata including URLs, dimensions, and file size

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `CLOUDINARY_CLOUD_NAME` | Your Cloudinary cloud name | Found in your Cloudinary dashboard URL: `https://console.cloudinary.com/console/{cloud_name}` |
| `CLOUDINARY_UPLOAD_PRESET` | An unsigned upload preset for secure uploads | Create in Cloudinary Dashboard → Settings → Upload → Upload presets |

## Optional Environment Variables

None required for basic functionality.

## How to Use

### 1. Set up Cloudinary

1. Create a free Cloudinary account at https://cloudinary.com
2. Note your cloud name from the dashboard
3. Create an unsigned upload preset:
   - Go to Settings → Upload → Upload presets
   - Click "Add upload preset"
   - Set "Signing Mode" to "Unsigned"
   - Configure any default transformations (optional)
   - Save the preset name

### 2. Configure Environment Variables

Set these in your Xano workspace environment variables:
- `CLOUDINARY_CLOUD_NAME` - your cloud name (e.g., "mycompany")
- `CLOUDINARY_UPLOAD_PRESET` - your upload preset name (e.g., "my_preset")

### 3. Run the Job

Execute via Xano CLI or the Run API:

```bash
# Using Xano CLI
xano run execute --file run.xs
```

Or via the Run API with custom inputs:

```json
{
  "image_url": "https://example.com/my-image.jpg",
  "folder": "products/2024",
  "public_id": "product_123_main",
  "tags": "product,main,2024",
  "overwrite": true
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `image_url` | text | Yes | URL or base64 data of the image to upload |
| `folder` | text | No | Folder path in Cloudinary (e.g., "products/2024") |
| `public_id` | text | No | Custom public ID for the image (auto-generated if not provided) |
| `tags` | text | No | Comma-separated tags for the image |
| `overwrite` | bool | No | Whether to overwrite if image with same public_id exists (default: false) |

## Response

On success, returns:

```json
{
  "success": true,
  "message": "Image uploaded successfully",
  "image": {
    "public_id": "uploads/2024/sample",
    "version": "1234567890",
    "signature": "abc123...",
    "width": 1920,
    "height": 1080,
    "format": "jpg",
    "resource_type": "image",
    "created_at": "2024-01-15T10:30:00Z",
    "bytes": 250000,
    "url": "http://res.cloudinary.com/...",
    "secure_url": "https://res.cloudinary.com/..."
  }
}
```

## Use Cases

- **E-commerce**: Upload product images with organized folders
- **User Content**: Store user-uploaded profile pictures or galleries
- **Asset Management**: Batch upload marketing materials
- **Media Processing**: Upload images for on-the-fly transformations

## File Structure

```
cloudinary-upload-image/
├── run.xs              # Run job configuration
├── function/
│   └── upload_image.xs # Image upload function
└── README.md           # This file
```

## Error Handling

The function handles common error cases:
- `inputerror` - Missing or invalid image_url
- `UploadError` - Invalid image format or Cloudinary rejection
- `AuthError` - Invalid credentials
- `APIError` - Other Cloudinary API errors

## Rate Limits

Cloudinary free tier allows:
- 25 credits/month for transformations
- 25GB storage
- 25GB bandwidth

See [Cloudinary pricing](https://cloudinary.com/pricing) for details.

## Links

- [Cloudinary Documentation](https://cloudinary.com/documentation)
- [Upload API Reference](https://cloudinary.com/documentation/image_upload_api_reference)
- [Upload Presets](https://cloudinary.com/documentation/upload_presets)
