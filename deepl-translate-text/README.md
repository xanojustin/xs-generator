# DeepL Translate Text - Xano Run Job

This Xano Run Job translates text using the [DeepL](https://www.deepl.com) Translation API and logs translations to a database table.

## What It Does

1. Accepts text and target language parameters
2. Optionally accepts source language (auto-detects if not provided)
3. Calls the DeepL API to translate the text
4. Logs the translation to the `translation_log` table
5. Returns the translated text and detected source language

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `DEEPL_API_KEY` | Your DeepL API key (get from https://www.deepl.com/pro-api) |

### API Key Types
- **Free plan**: Use the free API key (ends with `:fx`)
- **Pro plan**: Use the pro API key

The run job automatically detects which API endpoint to use based on your key format.

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "DeepL Translate Text"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "DeepL Translate Text" {
  main = {
    name: "translate_text"
    input: {
      text: "Hello, how are you today?"
      target_lang: "DE"
      source_lang: "EN"
    }
  }
  env = ["DEEPL_API_KEY"]
}
```

### Function Inputs

The `translate_text` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `text` | text | Yes | - | The text to translate |
| `target_lang` | text | Yes | - | Target language code (e.g., ES, DE, FR, JA, ZH) |
| `source_lang` | text | No | "AUTO" | Source language code or "AUTO" for auto-detection |

### Supported Language Codes

Common target languages:
- `BG` - Bulgarian
- `CS` - Czech
- `DA` - Danish
- `DE` - German
- `EL` - Greek
- `EN-GB` - English (British)
- `EN-US` - English (American)
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
- `PT-BR` - Portuguese (Brazilian)
- `PT-PT` - Portuguese (European)
- `RO` - Romanian
- `RU` - Russian
- `SK` - Slovak
- `SL` - Slovenian
- `SV` - Swedish
- `TR` - Turkish
- `UK` - Ukrainian
- `ZH` - Chinese (simplified)

See [DeepL API docs](https://www.deepl.com/docs-api/translate-text) for complete list.

### Response

```json
{
  "success": true,
  "original_text": "Hello, world!",
  "translated_text": "¡Hola, mundo!",
  "detected_source_language": "EN",
  "target_language": "ES",
  "log_id": 1
}
```

### Error Response

If the DeepL API returns an error:

```json
{
  "name": "DeepLError",
  "value": "DeepL API error: Bad request"
}
```

## Files

- `run.xs` - Run job configuration
- `function/translate_text.xs` - Translation logic and API integration
- `table/translation_log.xs` - Database table for logging translations

## Notes

- All translations are logged to `translation_log` including failed attempts
- Source language auto-detection works well for most common languages
- The free DeepL API has usage limits (500,000 characters/month)
- Character count includes both source and target text
