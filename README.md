# Corsair AutoHotKey Workflows

A personal AutoHotkey v2 utility pack for a Corsair keyboard profile that remaps keys to F13-based chords and routes those chords to application-specific actions.

The workflow is organized around a single central script, [functions.ahk](functions.ahk), which includes reusable modules for:

- shared desktop and Explorer helpers
- Visual Studio Code shortcuts
- Git Bash commands
- SQL Server Management Studio helpers
- Visual Studio actions
- ripgrep-powered search flows

---

## Project structure

- [functions.ahk](functions.ahk) — main F13 remap layer and app-specific hotkey routing
- [CoreLibrary.ahk](CoreLibrary.ahk) — reusable helper functions for Explorer, app launching, clipboard capture, and tooltips
- [VSCode.ahk](VSCode.ahk) — VS Code-specific keyboard automation
- [Git.ahk](Git.ahk) — Git Bash command shortcuts
- [MSSQL.ahk](MSSQL.ahk) — SSMS query and object explorer shortcuts
- [VisualStudio.ahk](VisualStudio.ahk) — Visual Studio build/debug/navigation shortcuts
- [RipGrep.ahk](RipGrep.ahk) — ripgrep search helpers and search variant commands
- [config.ini](config.ini) — SQL connection settings used by the SSMS helper scripts
- [F13 Profile.cueprofile](F13%20Profile.cueprofile) — exported Corsair iCUE profile that emits F13+key combinations
- [LICENSE](LICENSE) — GNU GPL v3 license

---

## What the project does

This project uses the keyboard profile to convert ordinary keys into F13 + key combinations so AutoHotkey can intercept them without disturbing normal typing until the profile is enabled.

The actual behavior is split into two layers:

1. Global F13 key handling
   - Most keys show a tooltip for quick confirmation.
   - Some keys are mapped to utility actions such as ripgrep search variants.

2. Context-aware application automation
   - When the active window is VS Code, F13 shortcuts trigger VS Code commands.
   - When the active window is Git Bash, F13 shortcuts trigger Git commands.
   - When the active window is SSMS, F13 shortcuts trigger query management helpers.
   - When the active window is Visual Studio, F13 shortcuts trigger build/debug shortcuts.

This makes the same keyboard layer usable across multiple developer tools while keeping the hotkeys centralized.

---

## Requirements

- Windows
- AutoHotkey v2
- Corsair iCUE with a compatible Corsair keyboard
- PowerShell (for launch helper commands and SQL execution)
- ripgrep installed and available on PATH for the RG helpers
- SQL Server access for the `sqlcmd`-based helpers, configured via [config.ini](config.ini)

---

## Setup

1. Import the profile from [F13 Profile.cueprofile](F13%20Profile.cueprofile) in Corsair iCUE.
2. Assign it to the intended keyboard.
3. Update [config.ini](config.ini) with the appropriate SQL Server connection values if you plan to use the SSMS/sqlcmd helpers.
4. Run [functions.ahk](functions.ahk) with AutoHotkey v2.
5. Make sure the script is placed alongside the included files so the module includes resolve correctly.
6. Test a few F13 chords in the target app.

> Back up any existing keyboard profile before loading this one. The remap changes key output and should be tested carefully.

Example SQL section for [config.ini](config.ini):

```ini
[SQL]
Server=YOUR_SQL_SERVER
Username=YOUR_USERNAME
Password=YOUR_PASSWORD
Database=YOUR_DATABASE
```

---

## Core library helpers

Defined in [CoreLibrary.ahk](CoreLibrary.ahk):

- GetActiveExplorerPath()
  - Returns the active Windows Explorer directory, if any.

- GetActiveExplorerOrDesktopPath()
  - Returns the active Explorer path, then Desktop, then the script working directory as fallback.

- CreateFolderInPath(targetPath, folderName)
  - Creates a folder in a target directory and avoids name collisions by auto-incrementing duplicates.

- CreateFolderInActiveExplorer(folderName)
  - Creates a folder in the active Explorer or desktop context.

- LaunchApp(appTarget, workingDir := "")
  - Runs an app or command with an optional working directory and returns the process ID.

- LaunchAppInCurrentDir(appTarget)
  - Launches an app in the active Explorer directory.

- RunElevated(appTarget, workingDir := "")
  - Runs the app with Administrator privileges.

- OpenBrowser(url := "https://google.com")
  - Opens the default browser to the specified URL.

- OpenExplorer(dirPath := A_WorkingDir)
  - Opens Windows Explorer to a directory.

- OpenDirectory(folderPath)
  - Alias for opening a directory in Explorer.

- OpenVSCode(dirPath := A_WorkingDir)
  - Opens VS Code in a specific directory.

- CloseActiveWindow()
  - Closes the active window.

- rpGrepInCurrentDir(searchQuery := "")
  - Runs ripgrep in the current directory context.

- FocusAndSearchWindow(queryText)
  - Uses the browser/editor/Explorer search bar depending on the active window.

- SearchInActiveExplorer(searchQuery)
  - Searches inside Windows Explorer.

- GetSelectedData()
  - Copies the currently selected text to the clipboard and restores the previous clipboard state.

- GetConfigValue(section, key, configPath := "config.ini")
  - Reads an INI value from the project configuration file.

- ShowTooltip(message, duration := 1000)
  - Displays a temporary tooltip.

---

## Main F13 mapping overview

The general F13 layer is defined in [functions.ahk](functions.ahk). Most base keys simply show a tooltip so the active key can be identified while the profile is being tested or customized.

Examples include:

- F13 + 1 opens VS Code in the current working directory
- F13 + 0 injects placeholder lorem ipsum text via paste
- F13 + keypad keys trigger ripgrep search functions for current-directory search, case-insensitive search, context view, filename-only search, regex search, JSON output, hidden-file search, and statistics

The default keys are intentionally easy to extend or repurpose.

---

## App-specific hotkeys

### VS Code

Defined in [VSCode.ahk](VSCode.ahk):

- F13 + t: spawn terminal
- F13 + f: format document
- F13 + b: toggle sidebar
- F13 + `: toggle terminal
- F13 + d: go to definition
- F13 + r: peek references
- F13 + p: command palette
- F13 + s: search in files
- F13 + g: go to line
- F13 + a: save all
- F13 + w: close editor
- F13 + n: new file
- F13 + o: open file
- F13 + /: toggle comment
- F13 + z: zen mode

### Git Bash

Defined in [Git.ahk](Git.ahk):

- F13 + s: git status
- F13 + p: git pull
- F13 + u: git push
- F13 + a: git add .
- F13 + c: git commit
- F13 + l: git log --oneline -10
- F13 + b: git branch -a
- F13 + o: git checkout
- F13 + t: git stash
- F13 + r: git stash pop
- F13 + d: git diff
- F13 + h: git reset --hard HEAD
- F13 + f: git fetch --all
- F13 + m: git merge

### SSMS / SQL Server Management Studio

Defined in [MSSQL.ahk](MSSQL.ahk):

- F13 + t: build SELECT TOP 10 * FROM <selection> WITH (NOLOCK)
- F13 + c: build SELECT COUNT(*) FROM <selection> WITH (NOLOCK)
- F13 + e: execute query
- F13 + n: new query
- F13 + p: parse results
- F13 + /: comment selection
- F13 + \: uncomment selection
- F13 + r: refresh object explorer
- F13 + g: go to line
- F13 + f: find and replace
- F13 + `: toggle results pane
- F13 + s: save query
- F13 + y: format SQL
- SQL helper functions also support `sqlcmd` execution using the credentials in [config.ini](config.ini), including interactive query entry

### Visual Studio

Defined in [VisualStudio.ahk](VisualStudio.ahk):

- F13 + b: build solution
- F13 + r: rebuild solution
- F13 + d: start debugging
- F13 + s: stop debugging
- F13 + i: step into
- F13 + o: step over
- F13 + u: step out
- F13 + t: toggle breakpoint
- F13 + g: go to definition
- F13 + p: peek definition
- F13 + f: find all references
- F13 + l: go to line
- F13 + a: find in files
- F13 + q: quick launch
- F13 + e: solution explorer
- F13 + w: output window
- F13 + `: error list
- F13 + k: save all
- F13 + /: comment selection
- F13 + \: uncomment selection
- F13 + y: format document

---

## ripgrep shortcuts

Defined in [RipGrep.ahk](RipGrep.ahk), these helpers launch rg in PowerShell using the active Explorer directory context or script directory fallback.

Actions include:

- basic search
- case-insensitive search
- context search
- filename-only search
- line-number search
- whole-word search
- regex search
- search in a single type such as .ts
- search in multiple types
- hidden-file search
- stats output
- dry-run replace preview
- JSON output
- count matches
- search including gitignored files
- search selected clipboard text

These are mapped to the keypad region in [functions.ahk](functions.ahk) as a quick search cluster.

---

## Notes and customization

- The repo is a personal productivity setup, so the layout is intentionally opinionated and app-specific.
- Most hotkeys are intentionally simple and easy to personalize.
- Several general-purpose F13 + key handlers are still scaffolded as tooltip-only actions and can be replaced with real commands as needed.
- The project is designed for developer workflows on Windows and is not a general-purpose keyboard manager.

---

## License

Licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE).
