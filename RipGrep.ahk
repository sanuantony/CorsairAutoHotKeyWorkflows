#Requires AutoHotkey v2.0
#SingleInstance Force
#Include CoreLibrary.ahk

; =========================================================================
; RIPGREP (RG) SEARCH AUTOMATION LAYER
; Context: Terminal/PowerShell/CMD (rg.exe operations)
; Intercepts: F13 + Key (context-dependent)
; =========================================================================

/**
 * RG_SearchCurrentDir
 * Launches ripgrep search in the current directory with optional query.
 * @param {String} [searchQuery] - Optional search query to pre-fill.
 */
RG_SearchCurrentDir(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search: " . currentDir, 500)
    LaunchApp("powershell.exe -NoExit -Command rg `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchCaseInsensitive
 * Performs case-insensitive search in current directory.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchCaseInsensitive(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Case-Insensitive Search", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -i `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchWithContext
 * Performs search with 2 lines of context before and after matches.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchWithContext(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search with Context", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -C 2 `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchOnlyFilenames
 * Searches and displays only matching filenames (no content).
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchOnlyFilenames(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Filenames Only", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -l `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchWithLineNumbers
 * Performs search showing line numbers for all matches.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchWithLineNumbers(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG with Line Numbers", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -n `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchWordMatch
 * Performs search matching whole words only.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchWordMatch(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Whole Word Match", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -w `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchRegex
 * Performs regex pattern search.
 * @param {String} [searchQuery] - Optional regex pattern.
 */
RG_SearchRegex(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Regex Search", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -e `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchInType
 * Searches only in specific file types (e.g., .ts, .js, .ahk).
 * @param {String} [fileType] - File extension to search (e.g., "ts", "js", "ahk").
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchInType(fileType := "ts", searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search in ." . fileType . " files", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -g `"*." . fileType . "`" `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchInAllTypes
 * Searches in multiple file types.
 * @param {String} [fileTypes] - Comma-separated file extensions (e.g., "ts,js,tsx").
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchInAllTypes(fileTypes := "ts,js,tsx", searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search in " . fileTypes . " files", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -g `"*.{ts,js,tsx}`" `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchSelectedText
 * Searches for the currently selected text in the clipboard.
 */
RG_SearchSelectedText() {
    selectedText := GetSelectedData()
    if (selectedText == "") {
        ShowTooltip("No text selected", 1000)
        return
    }
    RG_SearchCurrentDir(selectedText)
}

/**
 * RG_SearchInHidden
 * Searches including hidden files and directories.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchInHidden(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search (Include Hidden)", 500)
    LaunchApp("powershell.exe -NoExit -Command rg --hidden `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchWithStats
 * Performs search and displays statistics (matches per file).
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchWithStats(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search with Stats", 500)
    LaunchApp("powershell.exe -NoExit -Command rg --stats `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchReplace
 * Performs search and replace (dry run, shows what would change).
 * @param {String} [searchQuery] - Search pattern.
 * @param {String} [replaceText] - Replacement text.
 */
RG_SearchReplace(searchQuery := "", replaceText := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search-Replace (Dry Run)", 500)
    LaunchApp("powershell.exe -NoExit -Command rg `"" . searchQuery . "`" -r `"" . replaceText . "`"", currentDir)
}

/**
 * RG_SearchJSON
 * Searches and outputs results in JSON format.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchJSON(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG JSON Output", 500)
    LaunchApp("powershell.exe -NoExit -Command rg --json `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchCount
 * Counts matching lines per file.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchCount(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Count Matches", 500)
    LaunchApp("powershell.exe -NoExit -Command rg -c `"" . searchQuery . "`"", currentDir)
}

/**
 * RG_SearchInGitIgnored
 * Searches including files ignored by git.
 * @param {String} [searchQuery] - Optional search query.
 */
RG_SearchInGitIgnored(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    ShowTooltip("RG Search (Include Git Ignored)", 500)
    LaunchApp("powershell.exe -NoExit -Command rg --no-ignore `"" . searchQuery . "`"", currentDir)
}
