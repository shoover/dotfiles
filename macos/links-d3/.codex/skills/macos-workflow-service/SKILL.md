---
name: macos-workflow-service
description: >
  Create macOS Automator Quick Action / Service workflows (.workflow bundles)
  by directly editing the bundle contents. Use when the user wants a
  service that appears in the Services menu or System Settings > Keyboard >
  Keyboard Shortcuts > Services.
---

# macOS Workflow Service (Quick Action)

## Overview

Create macOS Service/Quick Action workflows as `.workflow` bundles in
`~/Library/Services/`. These appear in the app Services menu and can be
assigned keyboard shortcuts.

## Bundle Structure

```
My Service.workflow/
  Contents/
    Info.plist              # Bundle metadata + NSServices declaration
    version.plist           # Version info
    Resources/
      document.wflow        # The workflow XML (contains embedded AppleScript)
```

**Notable differences from Automator `.app` bundles:**

- No `MacOS/` directory (no executable stub needed)
- `document.wflow` lives in `Contents/Resources/`, not `Contents/`
- Must be placed in `~/Library/Services/` to be discovered by the system
- Uses `com.apple.Automator.servicesMenu` workflow type (not `application`)

## Workflow

### 1. Start from a known-working system service

Copy a system service as a template rather than creating from scratch:

```bash
cp -R "/System/Library/Services/Show Map.workflow" \
      ~/Library/Services/"My Service.workflow"
```

This guarantees the correct bundle structure, code signing, and metadata
format. Then modify Info.plist and document.wflow.

### 2. Modify `Info.plist`

Required keys:

```xml
<key>NSServices</key>
<array>
  <dict>
    <key>NSMenuItem</key>
    <dict>
      <key>default</key>
      <string>My Service</string>
    </dict>
    <key>NSMessage</key>
    <string>runWorkflowAsService</string>
    <key>NSSendTypes</key>
    <array>
      <string>public.utf8-plain-text</string>
    </array>
  </dict>
</array>
<key>CFBundleIdentifier</key>
<string>com.example.My-Service</string>
<key>CFBundleName</key>
<string>My Service</string>
```

- `NSMessage` must be `runWorkflowAsService`
- `NSSendTypes` declares what input the service accepts.
  `public.utf8-plain-text` for text, or omit for no-input services
- Remove `NSRequiredContext` unless you need to restrict the service to
  specific contexts

### 3. Modify `document.wflow`

The workflow metadata at the bottom must use the service type identifiers:

```xml
<key>workflowMetaData</key>
<dict>
  <key>serviceApplicationBundleID</key>
  <string></string>
  <key>serviceApplicationPath</key>
  <string></string>
  <key>serviceInputTypeIdentifier</key>
  <string>com.apple.Automator.nothing</string>
  <key>serviceOutputTypeIdentifier</key>
  <string>com.apple.Automator.nothing</string>
  <key>serviceProcessesInput</key>
  <integer>0</integer>
  <key>workflowTypeIdentifier</key>
  <string>com.apple.Automator.servicesMenu</string>
</dict>
```

**Critical:** `workflowTypeIdentifier` must be
`com.apple.Automator.servicesMenu`. Using
`com.apple.Automator.servicesMenuWorkflow` or any other variant will
cause the service to not register.

For input types:
- No input: `serviceInputTypeIdentifier` =
  `com.apple.Automator.nothing`, `serviceProcessesInput` = `0`
- Text input: `serviceInputTypeIdentifier` =
  `com.apple.Automator.text`, `serviceProcessesInput` = `1`

The action's `AMAccepts` > `Types` should use
`com.apple.cocoa.string` (not `com.apple.applescript.object`) for
services that handle text input. For example, inside the action dict:

```xml
<key>AMAccepts</key>
<dict>
    <key>Types</key>
    <array>
        <string>com.apple.cocoa.string</string>
    </array>
</dict>
```

### 4. Flush the services cache

```bash
/System/Library/CoreServices/pbs -flush
```

Verify registration:

```bash
/System/Library/CoreServices/pbs -dump | grep -i "My Service"
```

The service should appear in the output with its `NSBundlePath`. If it
doesn't, the bundle structure or metadata is wrong.

Services appear in the app menu under **App > Services**. They can be
assigned keyboard shortcuts in **System Settings > Keyboard > Keyboard
Shortcuts > Services**.

## Common Pitfalls

### Service doesn't appear after creation

1. Run `/System/Library/CoreServices/pbs -flush`
2. Check pbs dump for the bundle path
3. If missing, verify `CFBundleIdentifier` and `NSServices` in Info.plist
4. Some apps cache their services menu — relaunch the target app

### Shell quoting in AppleScript

`quoted form of` wraps a string in single quotes. Nesting `quoted form
of` inside another `quoted form of` produces `''path''` which breaks the
shell:

```applescript
# BROKEN: produces ''path'' inside outer single quotes
do shell script cmd & " -e " & quoted form of ("(insert " & quoted form of somePath & ")")

# WORKS: embed the path with escaped double-quote delimiters
do shell script cmd & " -e " & quoted form of ("(insert \"" & somePath & "\")")
```

### `path to temporary items` is sandboxed

`(POSIX path of (path to temporary items))` resolves to a per-process
sandbox directory. Other processes cannot read files there. Use `/tmp/`
for files shared with other processes:

```applescript
set tempPath to "/tmp/my_temp_file.txt"
```

### XML entity encoding in document.wflow

The AppleScript source inside `document.wflow` is XML text content. XML
entities apply:

| Literal | XML in document.wflow |
|---|---|
| `&` | `&amp;` |
| `<` | `&lt;` |
| `>` | `&gt;` |

Write the entire file when making changes — partial search-and-replace is
fragile due to entity encoding.
