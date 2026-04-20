---
name: macos-automator-app
description: >
  Create or modify macOS Automator application bundles (.app) by directly
  editing the bundle contents. Use when the user wants to build an Automator
  app (a standalone .app bundle, not a .workflow Service) without using the
  Automator GUI editor.
---

# macOS Automator App

## Overview

Create and modify macOS Automator application bundles (`.app`) by directly
editing the bundle contents. This is useful for scripting, version control, or
when the Automator GUI is unavailable.

## Bundle Structure

```
My Workflow.app/
  Contents/
    Info.plist           # Bundle metadata (identifier, name, version)
    document.wflow       # The workflow XML (contains embedded AppleScript)
    MacOS/
      Automator Application Stub   # Launch binary (do not modify)
    Resources/
      ApplicationStub.icns
      *.lproj/                     # Localized strings
    QuickLook/
      Preview.png
    _CodeSignature/                # Removed/replaced after modification
```

## Workflow

### 1. Start from an existing bundle when possible

Copy an existing `.app` bundle rather than creating from scratch. The
`document.wflow` plist structure is complex and the Automator stub binary must
be present.

```bash
cp -R "Source.app" "Destination.app"
```

### 2. Modify `document.wflow`

The workflow is a plist XML file. The AppleScript source lives inside
`/plist/dict/actions/array/dict[0]/action/ActionParameters/source/string`.

The AppleScript is stored as XML text content inside the `<string>` element.
XML entity encoding applies:

| Literal | XML in document.wflow |
|---|---|
| `&` | `&amp;` |
| `<` | `&lt;` |
| `>` | `&gt;` |

**Write the entire file** rather than trying to search-and-replace on the
embedded AppleScript — XML entity encoding makes partial matches fragile.

### 3. Update `Info.plist`

Change at minimum:
- `CFBundleIdentifier` — unique reverse-DNS identifier
- `CFBundleName` — display name

### 4. Re-sign the bundle

After any modification, the code signature is invalid. Clean extended
attributes and re-sign:

```bash
find "My Workflow.app" -type f -exec xattr -c {} \;
codesign --force --sign - --deep "My Workflow.app"
```

Ad-hoc signing (`-`) is sufficient for local use. If `codesign` complains about
"resource fork, Finder information, or similar detritus not allowed", run
`xattr -c` again and retry.

## Common Pitfalls

AppleScript shell quoting and sandboxing pitfalls are the same as for
`.workflow` services. See `macos-workflow-service` Common Pitfalls for
`path to temporary items` and `do shell script` quoting guidance.
