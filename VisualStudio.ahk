#Requires AutoHotkey v2.0
#SingleInstance Force
#Include CoreLibrary.ahk

; =========================================================================
; VISUAL STUDIO AUTOMATION LAYER
; Context: Visual Studio (ahk_exe devenv.exe)
; Intercepts: F13 + Key (only when Visual Studio is active)
; =========================================================================

/**
 * VS_BuildSolution
 * Builds the current solution.
 */
VS_BuildSolution() {
    ShowTooltip("Building Solution", 500)
    Send("^+b")
}

/**
 * VS_RebuildSolution
 * Rebuilds the current solution.
 */
VS_RebuildSolution() {
    ShowTooltip("Rebuilding Solution", 500)
    Send("^+{F7}")
}

/**
 * VS_StartDebugging
 * Starts debugging the current project.
 */
VS_StartDebugging() {
    ShowTooltip("Start Debugging", 500)
    Send("{F5}")
}

/**
 * VS_StopDebugging
 * Stops the current debugging session.
 */
VS_StopDebugging() {
    ShowTooltip("Stop Debugging", 500)
    Send("^+{F5}")
}

/**
 * VS_StepInto
 * Steps into the current function call.
 */
VS_StepInto() {
    ShowTooltip("Step Into", 500)
    Send("{F11}")
}

/**
 * VS_StepOver
 * Steps over the current line.
 */
VS_StepOver() {
    ShowTooltip("Step Over", 500)
    Send("{F10}")
}

/**
 * VS_StepOut
 * Steps out of the current function.
 */
VS_StepOut() {
    ShowTooltip("Step Out", 500)
    Send("^+{F11}")
}

/**
 * VS_ToggleBreakpoint
 * Toggles a breakpoint at the current line.
 */
VS_ToggleBreakpoint() {
    ShowTooltip("Toggle Breakpoint", 500)
    Send("{F9}")
}

/**
 * VS_GoToDefinition
 * Navigates to the definition of the symbol under cursor.
 */
VS_GoToDefinition() {
    ShowTooltip("Go to Definition", 500)
    Send("{F12}")
}

/**
 * VS_PeekDefinition
 * Shows peek definition for the symbol under cursor.
 */
VS_PeekDefinition() {
    ShowTooltip("Peek Definition", 500)
    Send("^k")
    Sleep(50)
    Send("^d")
}

/**
 * VS_FindAllReferences
 * Finds all references to the symbol under cursor.
 */
VS_FindAllReferences() {
    ShowTooltip("Find All References", 500)
    Send("^+f")
}

/**
 * VS_GoToLine
 * Prompts to go to a specific line number.
 */
VS_GoToLine() {
    ShowTooltip("Go to Line", 500)
    Send("^g")
}

/**
 * VS_FindInFiles
 * Opens the find in files dialog.
 */
VS_FindInFiles() {
    ShowTooltip("Find in Files", 500)
    Send("^+f")
}

/**
 * VS_QuickLaunch
 * Opens the Visual Studio quick launch dialog.
 */
VS_QuickLaunch() {
    ShowTooltip("Quick Launch", 500)
    Send("^q")
}

/**
 * VS_SolutionExplorer
 * Focuses the Solution Explorer pane.
 */
VS_SolutionExplorer() {
    ShowTooltip("Solution Explorer", 500)
    Send("^+l")
}

/**
 * VS_OutputWindow
 * Focuses the Output window.
 */
VS_OutputWindow() {
    ShowTooltip("Output Window", 500)
    Send("^+o")
}

/**
 * VS_ErrorList
 * Focuses the Error List pane.
 */
VS_ErrorList() {
    ShowTooltip("Error List", 500)
    Send("^+e")
}

/**
 * VS_SaveAll
 * Saves all open files.
 */
VS_SaveAll() {
    ShowTooltip("Save All", 500)
    Send("^+s")
}

/**
 * VS_CommentSelection
 * Comments out selected lines.
 */
VS_CommentSelection() {
    ShowTooltip("Comment Selection", 500)
    Send("^k")
    Sleep(50)
    Send("^c")
}

/**
 * VS_UncommentSelection
 * Uncomments selected lines.
 */
VS_UncommentSelection() {
    ShowTooltip("Uncomment Selection", 500)
    Send("^k")
    Sleep(50)
    Send("^u")
}

/**
 * VS_FormatDocument
 * Formats the current document.
 */
VS_FormatDocument() {
    ShowTooltip("Format Document", 500)
    Send("^k")
    Sleep(50)
    Send("^d")
}
