# CloudConvert File Conversion

A Xano Run Job that creates file conversion jobs using the CloudConvert API. Supports 200+ file formats including documents, images, videos, audio files, and archives.

## What This Run Job Does

1. Accepts a file URL, target output format, and desired filename
2. Submits a conversion job to CloudConvert's API
3. Stores the job details in the database for tracking
4. Returns the job ID and status immediately

The conversion runs asynchronously on CloudConvert's servers. You can use the returned `job_id` to check the conversion status via the CloudConvert API or set up a webhook to be notified when complete.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `cloudconvert_api_key` | Your CloudConvert API key (get from https://cloudconvert.com/dashboard/api) |

## How to Use

### Run the Job

The job is configured in `run.xs` with default values. Modify the input in `run.xs` or call the function directly with custom parameters:

```xs
main = {
  name: "convert_file"
  input: {
    input_url: "https://example.com/document.docx"
    output_format: "pdf"
    filename: "my-document"
  }
}
```

### Supported Conversions

CloudConvert supports conversions between 200+ formats including:

- **Documents**: PDF, DOCX, DOC, ODT, RTF, TXT, HTML, EPUB
- **Images**: JPG, PNG, GIF, WEBP, SVG, TIFF, BMP, ICO
- **Videos**: MP4, AVI, MKV, MOV, WMV, FLV, WEBM
- **Audio**: MP3, WAV, AAC, FLAC, OGG, M4A, WMA
- **Archives**: ZIP, RAR, 7Z, TAR, GZ
- **Spreadsheets**: XLSX, XLS, CSV, ODS
- **Presentations**: PPTX, PPT, ODP

### Function Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `input_url` | text | Yes | Publicly accessible URL to the file to convert |
| `output_format` | text | Yes | Target format (e.g., "pdf", "jpg", "mp4") |
| `filename` | text | Yes | Desired base filename for the output (without extension) |

### Response

```json
{
  "success": true,
  "job_id": "job-id-from-cloudconvert",
  "status": "processing",
  "record_id": 123,
  "message": "Conversion job created successfully. Use the job_id to check status."
}
```

### Checking Job Status

Use the returned `job_id` to check the conversion status:

```bash
curl -X GET "https://api.cloudconvert.com/v2/jobs/{job_id}" \
  -H "Authorization: Bearer {your_api_key}"
```

When the job is complete, the response will include the download URL for the converted file.

## Example Use Cases

- Convert uploaded DOCX files to PDF for sharing
- Generate thumbnails by converting images to smaller formats
- Convert video files to web-optimized formats
- Create archive files from multiple documents
- Convert audio files to different bitrates

## Database Schema

The `conversion` table stores:
- `job_id`: CloudConvert job ID
- `input_url`: Source file URL
- `output_format`: Target format
- `output_filename`: Resulting filename (null until complete)
- `output_url`: Download URL for the converted file (null until complete)
- `status`: Job status (e.g., "processing", "finished", "error")
- `created_at`: Timestamp

## API Reference

- CloudConvert API Docs: https://cloudconvert.com/api/v2
- CloudConvert Dashboard: https://cloudconvert.com/dashboard
