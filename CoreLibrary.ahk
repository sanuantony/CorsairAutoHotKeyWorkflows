#Requires AutoHotkey v2.0
#SingleInstance Force

; ==============================================================================
; SECTION 1: DIRECTORY & CONTEXT AWARENESS FUNCTIONS
; ==============================================================================

/**
 * GetActiveExplorerPath
 * Silently retrieves the file system path of the active Windows Explorer window.
 * @returns {String} Absolute directory path, or an empty string if not found.
 */
GetActiveExplorerPath() {
    if (explorerHwnd := WinActive("ahk_class CabinetWClass")) {
        for window in ComObject("Shell.Application").Windows {
            try {
                if (window && window.hwnd && window.hwnd == explorerHwnd)
                    return window.Document.Folder.Self.Path
            }
        }
    }
    return ""
}

/**
 * GetActiveExplorerOrDesktopPath
 * Retrieves the path of the active Explorer window. Falls back to the Desktop path 
 * if Explorer isn't active, or the Script Working Directory if both fail.
 * @returns {String} Absolute directory path.
 */
GetActiveExplorerOrDesktopPath() {
    currentPath := GetActiveExplorerPath()
    if (currentPath == "") {
        if WinActive("ahk_class Progman") || WinActive("ahk_class WorkerW")
            return A_Desktop
        return A_WorkingDir
    }
    return currentPath
}

/**
 * CreateFolderInPath
 * Programmatically creates a subfolder inside a targeted path. Resolves conflicts automatically.
 * @param {String} targetPath - The parent folder directory.
 * @param {String} folderName - Desired name for the new folder.
 * @returns {String} The full absolute path of the successfully created folder.
 */
CreateFolderInPath(targetPath, folderName) {
    if !DirExist(targetPath)
        DirCreate(targetPath)
        
    basePath := targetPath . "\" . folderName
    finalPath := basePath
    
    ; Auto-increment counter if the folder already exists (e.g., New Folder (2))
    counter := 2
    while DirExist(finalPath) {
        finalPath := basePath . " (" . counter . ")"
        counter++
    }
    
    DirCreate(finalPath)
    return finalPath
}

/**
 * CreateFolderInActiveExplorer
 * Creates a new folder inside the currently active File Explorer directory or fallback space.
 * @param {String} folderName - Desired name for the new folder.
 * @returns {String} The full absolute path of the successfully created folder.
 */
CreateFolderInActiveExplorer(folderName) {
    targetDir := GetActiveExplorerOrDesktopPath()
    return CreateFolderInPath(targetDir, folderName)
}


; ==============================================================================
; SECTION 2: APPLICATION LAUNCHING & MANAGEMENT
; ==============================================================================

/**
 * LaunchApp
 * Safely executes a program or opens a path, returning the Process ID (PID).
 * @param {String} appTarget - Executable alias, full path, or document URL.
 * @param {String} [workingDir] - Optional initial working directory.
 * @returns {Integer} The Process ID (PID) of the launched application.
 * @throws {Error} Throws an error upstream if the target cannot be launched.
 */
LaunchApp(appTarget, workingDir := "") {
    pid := 0
    Run(appTarget, workingDir, , &pid)
    return pid
}

/**
 * LaunchAppInCurrentDir
 * Automatically grabs the current active Explorer path and boots an application there.
 * @param {String} appTarget - The application to launch.
 * @returns {Integer} The Process ID (PID) of the application.
 */
LaunchAppInCurrentDir(appTarget) {
    currentDir := GetActiveExplorerOrDesktopPath()
    return LaunchApp(appTarget, currentDir)
}

/**
 * RunElevated
 * Forces any application or script block to execute with full Administrator rights.
 * @param {String} appTarget - Target application path or execution string.
 * @param {String} [workingDir] - Target working directory context.
 */
RunElevated(appTarget, workingDir := "") {
    try {
        Run('*RunAs "' . A_ComSpec . '" /c ' . appTarget, workingDir)
    } catch Error as err {
        ShowTooltip("Launch failed: " . err.Message, 2000)
    }
}

/**
 * OpenBrowser
 * Opens the default web browser to a specified URL.
 * @param {String} url - The web address to open.
 */
OpenBrowser(url := "https://google.com") {
    Run(url)
}

/**
 * OpenExplorer
 * Opens Windows Explorer to a specified directory.
 * @param {String} dirPath - Target folder path.
 */
OpenExplorer(dirPath := A_WorkingDir) {
    Run("explorer.exe " . dirPath)
}

/**
 * OpenDirectory
 * Alias for OpenExplorer to safely maintain compatibility with directory-building macros.
 * @param {String} folderPath - Target folder path to open.
 */
OpenDirectory(folderPath) {
    OpenExplorer(folderPath)
}

/**
 * OpenVSCode
 * Opens VS Code in a given directory, defaulting to the current context path.
 * @param {String} dirPath - The directory to open in VS Code.
 */
OpenVSCode(dirPath := A_WorkingDir) {
    Run("code `"" . dirPath . "`"")
}

/**
 * CloseActiveWindow
 * Gracefully shuts down the current active window instance using its unique hardware ID (HWND).
 */
CloseActiveWindow() {
    if (activeHwnd := WinExist("A")) {
        WinClose("ahk_id " . activeHwnd)
    }
}


; ==============================================================================
; SECTION 3: SYSTEM SEARCH & DATA INTERACTION
; ==============================================================================

/**
 * rpGrepInCurrentDir
 * Launches an external ripGrep (rg) process or search UI targeting the current directory.
 * @param {String} [searchQuery] - Optional initial query text to pass into grep.
 */
rpGrepInCurrentDir(searchQuery := "") {
    currentDir := GetActiveExplorerOrDesktopPath()
    LaunchApp("powershell.exe -NoExit -Command rg `"" . searchQuery . "`"", currentDir)    
}

/**
 * FocusAndSearchWindow
 * Universal focus handler to search for elements inside active text containers or Windows Explorer.
 * @param {String} queryText - The text string to search for.
 */
FocusAndSearchWindow(queryText) {
    if WinActive("ahk_class CabinetWClass") {
        Send("^e") ; Focus Windows Explorer Search bar
        Sleep(150)
        SendInput(queryText . "{Enter}")
    } else {
        Send("^f") ; Universal search shortcut for browsers, editors, and documents
        Sleep(100)
        SendInput(queryText)
    }
}

/**
 * SearchInActiveExplorer
 * Explicit handler wrapper to pass queries directly into the structural search window.
 * @param {String} searchQuery - The phrase or item name to query.
 */
SearchInActiveExplorer(searchQuery) {
    FocusAndSearchWindow(searchQuery)
}

/**
 * GetSelectedData
 * A highly resilient fallback mechanism to get whatever the user is highlighting.
 * Works across browsers, text editors, and pulls absolute paths if files are selected in Explorer.
 * @returns {String} The captured string data or newline-separated file paths.
 */
GetSelectedData() {
    clipSaved := ClipboardAll()
    A_Clipboard := ""
    
    Send("^c")
    if ClipWait(0.4, 1) { 
        selection := A_Clipboard
        A_Clipboard := clipSaved 
        return selection
    }
    
    A_Clipboard := clipSaved 
    return ""
}


; ==============================================================================
; SECTION 4: USER INTERFACE & NOTIFICATIONS
; ==============================================================================

/**
 * ShowTooltip
 * Create and show a tooltip with a message for a specified duration.
 * @param {String} message - The message to display in the tooltip.
 * @param {Integer} duration - How long (in ms) to keep the tooltip alive.
 */
ShowTooltip(message, duration := 1000) {
    ToolTip(message)
    Sleep(duration)
    ToolTip() 
}
