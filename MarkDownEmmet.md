# Add emmet completion at Markdown *.md files in VSC

1. Open settings.json: CTRL+SHIFT+P
2. ADD

```json
    "emmet.excludeLanguages": [],
    "emmet.includeLanguages": {
        "javascript": "javascriptreact",
        "markdown": "html"
    },
    "[markdown]": {
        "editor.quickSuggestions": {
            "other": "on",
            "comments": "off",
            "strings": "off"
        }
    },
```

