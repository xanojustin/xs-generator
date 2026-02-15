# Imgix Process Image Run Job

This XanoScript run job processes and optimizes images using the Imgix API.

## What It Does

This run job generates Imgix URLs for on-the-fly image processing. It handles:

- Resizing images to specified dimensions
- Converting between image formats (WebP, JPEG, PNG, etc.)
- Adjusting image quality for optimal file sizes
- Applying various fit modes (crop, clip, max, scale)
- Returning processed image URLs with metadata

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `IMGIX_API_KEY` | Your Imgix API key (found in Imgix dashboard source settings) |
| `IMGIX_DOMAIN` | Your Imgix domain (e.g., `yourdomain.imgix.net`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `image_url` | text | Yes | Source image URL to process (must be accessible to Imgix) |
| `width` | text | No | Target width in pixels (e.g., `800`) |
| `height` | text | No | Target height in pixels (e.g., `600`) |
| `format` | text | No | Output format: `webp`, `jpg`, `png`, `auto` (default: `auto`) |
| `quality` | text | No | Image quality 1-100 (default: `75`) |
| `fit` | text | No | Resize fit mode: `crop`, `clip`, `max`, `scale` (default: `crop`) |
| `params` | text | No | Additional Imgix params as query string (e.g., `blur=50&sat=-100`) |

### Response

```json
{
  "success": true,
  "processed_url": "https://yourdomain.imgix.net/image.jpg?auto=compress,format&w=800&h=600&fm=webp&q=85",
  "original_url": "https://example.com/image.jpg",
  "width": "800",
  "height": "600",
  "format": "webp",
  "content_type": "image/webp",
  "content_length_bytes": "45231",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "processed_url": null,
  "original_url": "https://example.com/image.jpg",
  "width": "800",
  "height": "600",
  "format": "webp",
  "content_type": null,
  "content_length_bytes": null,
  "error": "IMGIX_API_KEY environment variable not configured"
}
```

## File Structure

```
imgix-process-image/
├── run.xs                    # Run job definition
├── function/
│   └── process_image.xs      # Function to process images
└── README.md                 # This file
```

## Imgix API Reference

- [Imgix URL API Reference](https://docs.imgix.com/apis/rendering)
- [Image Parameters](https://docs.imgix.com/apis/rendering)

## Common Use Cases

### Generate responsive images
```
width: "400"
format: "webp"
quality: "80"
```

### Create thumbnails
```
width: "200"
height: "200"
fit: "crop"
```

### Apply effects
```
params: "blur=50&sat=-100"  // Blurred grayscale image
```

### Format conversion
```
format: "webp"  // Convert to WebP for better compression
```

## Security Notes

- Never commit your `IMGIX_API_KEY` to version control
- The Imgix domain must be configured to allow access to your source images
- Consider enabling secure URLs in your Imgix dashboard for production use
