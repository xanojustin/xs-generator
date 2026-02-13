# Cloudinary Image Upload Run Job

This Xano run job uploads images to [Cloudinary](https://cloudinary.com/) - a cloud-based image and video management service.

## What It Does

The run job uploads an image from a URL to your Cloudinary account and returns the uploaded image metadata including the secure URL, dimensions, format, and file size.

## Prerequisites

1. A Cloudinary account (free tier available at https://cloudinary.com/users/register/free)
2. An unsigned upload preset configured in your Cloudinary dashboard

## Required Environment Variables

| Variable | Description | Where to Find |
|----------|-------------|---------------|
| `CLOUDINARY_CLOUD_NAME` | Your Cloudinary cloud name | Cloudinary Dashboard → Product Environment Credentials |
| `CLOUDINARY_API_KEY` | Your Cloudinary API key | Cloudinary Dashboard → Product Environment Credentials |
| `CLOUDINARY_UPLOAD_PRESET` | Unsigned upload preset name | Cloudinary Console → Settings → Upload → Upload presets |

## Setting Up an Unsigned Upload Preset

1. Log into your Cloudinary dashboard
2. Go to Settings → Upload
3. Scroll to "Upload presets" and click "Add upload preset"
4. Set "Signing Mode" to "Unsigned"
5. Configure any desired transformations (optional)
6. Save the preset and note its name

## Usage

### Default Usage

The run job comes with a default image URL. Simply run:

```bash
xano run
```

### Customizing the Input

Edit `run.xs` to change the input parameters:

```xs
run.job "Cloudinary Image Upload" {
  main = {
    name: "upload_image"
    input: {
      image_url: "https://your-image-url.com/photo.jpg"
      public_id: "my_custom_image_name"
    }
  }
  env = ["CLOUDINARY_CLOUD_NAME", "CLOUDINARY_API_KEY", "CLOUDINARY_UPLOAD_PRESET"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `image_url` | text | Yes | URL of the image to upload to Cloudinary |
| `public_id` | text | No | Custom identifier for the image (auto-generated if not provided) |

### Response

On success, the function returns:

```json
{
  "success": true,
  "public_id": "sample_upload_20240212174300",
  "url": "https://res.cloudinary.com/your-cloud/image/upload/v1707777788/sample_upload_20240212174300.jpg",
  "format": "jpg",
  "width": 400,
  "height": 300,
  "bytes": 15234,
  "created_at": "2024-02-12T17:43:00Z"
}
```

## File Structure

```
cloudinary-upload-image/
├── run.xs                    # Run job configuration
├── function/
│   └── upload_image.xs       # Upload function
└── README.md                 # This file
```

## Learn More

- [Cloudinary Documentation](https://cloudinary.com/documentation)
- [Upload Presets Guide](https://cloudinary.com/documentation/upload_presets)
- [Image Transformations](https://cloudinary.com/documentation/image_transformations)
