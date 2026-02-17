# DeepL Translate Text

A Xano Run Job that translates text using the DeepL Translation API.

## What This Run Job Does

This run job translates text from one language to another using DeepL's neural machine translation API. It supports:

- Translating text to 30+ target languages
- Optional source language specification (auto-detected if not provided)
- Automatic handling of both Free and Pro DeepL API endpoints
- Character count tracking
- Proper error handling for common API issues

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `DEEPL_API_KEY` | Your DeepL API authentication key | Yes |

### Getting a DeepL API Key

1. Sign up at [DeepL](https://www.deepl.com/pro-api)
2. Choose either the Free or Pro plan
3. Copy your API key from the account settings
4. Free API keys typically end in `:fx`

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
- `NB` - Norwegian
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
- `ZH` - Chinese

## How to Use

### Basic Usage

```bash
# Set your API key
export DEEPL_API_KEY="your-api-key"

# Run the job
xano job run deepl-translate-text
```

### With Custom Input

Modify the `input` object in `run.xs`:

```xs
run.job "DeepL Translate Text" {
  main = {
    name: "translate_text"
    input: {
      text: "Hello, how are you today?"
      target_lang: "FR"
      source_lang: "EN"
    }
  }
  env = ["DEEPL_API_KEY"]
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `text` | string | Yes | The text to translate |
| `target_lang` | string | Yes | Target language code (e.g., "ES", "FR", "DE") |
| `source_lang` | string | No | Source language code. If omitted, DeepL auto-detects |

### Response

On success, returns:

```json
{
  "success": true,
  "original_text": "Hello, world!",
  "translated_text": "¡Hola, mundo!",
  "source_language": "EN",
  "target_language": "ES",
  "character_count": 13
}
```

## Error Handling

The run job handles these common errors:

- **400 Bad Request** - Invalid language codes or malformed request
- **403 Forbidden** - Invalid API key
- **429 Too Many Requests** - Rate limit exceeded
- **456 Quota Exceeded** - Monthly character limit reached

## Files

- `run.xs` - Run job configuration
- `function/translate_text.xs` - Translation logic

## API Documentation

For more details on the DeepL API, visit:
https://www.deepl.com/docs-api