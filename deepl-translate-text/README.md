# DeepL Translate Text - Xano Run Job

This Xano Run Job translates text using the DeepL API, one of the most accurate machine translation services available.

## What It Does

The run job executes a function that translates text from one language to another using DeepL's neural machine translation API. It supports automatic language detection and can translate between 30+ languages.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `deepl_api_key` | Your DeepL API key (starts with your DeepL plan identifier) |

## How to Use

1. Set up your environment variable in the Xano dashboard or your `.env` file
2. Run the job with your desired text and target language:

```bash
# Default values translate "Hello, world!" to Spanish
# Modify run.xs to customize the translation
```

### Modifying Input Parameters

Edit the `run.xs` file to change the default input:

```xs
run.job "Translate Text with DeepL" {
  main = {
    name: "translate_text"
    input: {
      text: "Your text to translate"
      target_lang: "FR"  // Target language code (FR, DE, JA, etc.)
      source_lang: "EN"  // Optional: source language (auto-detected if omitted)
    }
  }
  env = ["deepl_api_key"]
}
```

## Supported Languages

Common target language codes:
- `BG` - Bulgarian
- `CS` - Czech
- `DA` - Danish
- `DE` - German
- `EL` - Greek
- `EN` - English
- `ES` - Spanish
- `ET` - Estonian
- `FI` - Finnish
- `FR` - French
- `HU` - Hungarian
- `ID` - Indonesian
- `IT` - Italian
- `JA` - Japanese
- `KO` - Korean
- `LT` - Lithuanian
- `LV` - Latvian
- `NB` - Norwegian (Bokmål)
- `NL` - Dutch
- `PL` - Polish
- `PT` - Portuguese
- `RO` - Romanian
- `RU` - Russian
- `SK` - Slovak
- `SL` - Slovenian
- `SV` - Swedish
- `TR` - Turkish
- `UK` - Ukrainian
- `ZH` - Chinese (simplified)

## API Reference

The function uses DeepL's REST API:
- **Endpoint**: `POST https://api-free.deepl.com/v2/translate`
- **Authentication**: DeepL-Auth-Key header
- **Request Body** (JSON):
  - `text`: Array of strings to translate (required)
  - `target_lang`: Target language code (required)
  - `source_lang`: Source language code (optional, auto-detected if omitted)

## File Structure

```
deepl-translate-text/
├── run.xs                # Run job configuration
├── function/
│   └── translate_text.xs # Translation function
└── README.md             # This file
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "translated_text": "¡Hola, mundo!",
  "detected_source_language": "EN",
  "target_language": "ES"
}
```

## Error Handling

The function validates inputs and handles API errors:
- Missing text or target language returns input error
- DeepL API errors are caught and thrown with descriptive messages
- Supports both free and pro API endpoints

## Getting a DeepL API Key

1. Sign up at [deepl.com](https://www.deepl.com/pro-api)
2. Choose a plan (free tier includes 500,000 characters/month)
3. Get your API key from the [DeepL Account](https://www.deepl.com/account/summary)
4. Copy the API key and set it as `deepl_api_key` in your environment

## Notes

- The function uses the **free API endpoint** (`api-free.deepl.com`). If you have a Pro plan, change the URL to `api.deepl.com` in the function.
- Language codes are automatically converted to uppercase
- Source language is optional; DeepL auto-detects if not provided
- The API accepts an array of texts, but this function translates one text at a time for simplicity