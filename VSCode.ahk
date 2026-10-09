#Requires AutoHotkey v2.0
#SingleInstance Force
#Include CoreLibrary.ahk

; =========================================================================
; VISUAL STUDIO CODE AUTOMATION LAYER
; Context: VS Code (ahk_exe Code.exe)
; Intercepts: F13 + Key (only when VS Code is active)
; =========================================================================

/**
 * VSCode_SpawnTerminal
 * Spawns an integrated terminal in VS Code at the current file path context.
 */
VSCode_SpawnTerminal() {
    ShowTooltip("Opening Integrated Terminal", 500)
    Send("^+``") ; VS Code shortcut to split terminal
}

/**
 * VSCode_FormatDocument
 * Triggers document formatting in VS Code.
 */
VSCode_FormatDocument() {
    ShowTooltip("Formatting Document", 500)
    Send("^+i") ; Format document
}

/**
 * VSCode_ToggleSidebar
 * Toggles the VS Code sidebar visibility.
 */
VSCode_ToggleSidebar() {
    ShowTooltip("Toggle Sidebar", 500)
    Send("^b")
}

/**
 * VSCode_ToggleTerminal
 * Toggles the integrated terminal panel.
 */
VSCode_ToggleTerminal() {
    ShowTooltip("Toggle Terminal", 500)
    Send("^``")
}

/**
 * VSCode_GoToDefinition
 * Navigates to the definition of the symbol under cursor.
 */
VSCode_GoToDefinition() {
    ShowTooltip("Go to Definition", 500)
    Send("^{F12}")
}

/**
 * VSCode_PeekReferences
 * Shows references to the symbol under cursor.
 */
VSCode_PeekReferences() {
    ShowTooltip("Peek References", 500)
    Send("^+{F12}")
}

/**
 * VSCode_CommandPalette
 * Opens the VS Code command palette.
 */
VSCode_CommandPalette() {
    ShowTooltip("Command Palette", 500)
    Send("^+p")
}

/**
 * VSCode_SearchInFiles
 * Opens the search in files panel.
 */
VSCode_SearchInFiles() {
    ShowTooltip("Search in Files", 500)
    Send("^+f")
}

/**
 * VSCode_GoToLine
 * Prompts to go to a specific line number.
 */
VSCode_GoToLine() {
    ShowTooltip("Go to Line", 500)
    Send("^g")
}

/**
 * VSCode_SaveAll
 * Saves all open files.
 */
VSCode_SaveAll() {
    ShowTooltip("Save All", 500)
    Send("^k s")
}

/**
 * VSCode_CloseEditor
 * Closes the current editor tab.
 */
VSCode_CloseEditor() {
    ShowTooltip("Close Editor", 500)
    Send("^w")
}

/**
 * VSCode_NewFile
 * Creates a new untitled file.
 */
VSCode_NewFile() {
    ShowTooltip("New File", 500)
    Send("^n")
}

/**
 * VSCode_OpenFile
 * Opens a file from the file explorer.
 */
VSCode_OpenFile() {
    ShowTooltip("Open File", 500)
    Send("^o")
}

/**
 * VSCode_ToggleComment
 * Toggles line comment for current line or selection.
 */
VSCode_ToggleComment() {
    ShowTooltip("Toggle Comment", 500)
    Send("^/")
}

/**
 * VSCode_ZenMode
 * Toggles Zen mode for distraction-free editing.
 */
VSCode_ZenMode() {
    ShowTooltip("Zen Mode", 500)
    Send("^k z")
}
