#Requires AutoHotkey v2.0
#SingleInstance Force
#Include CoreLibrary.ahk

; =========================================================================
; MSSQL MANAGEMENT STUDIO AUTOMATION LAYER
; Context: SSMS (ahk_exe Ssms.exe)
; Intercepts: F13 + Key (only when SSMS is active)
; =========================================================================

/**
 * MSSQL_SelectTop10
 * Extracts selected token and builds SELECT TOP 10 ... WITH (NOLOCK) query.
 */
MSSQL_SelectTop10() {
    ShowTooltip("Building SELECT TOP 10", 500)
    selectedText := GetSelectedData()
    
    if (selectedText == "") {
        ShowTooltip("No text selected", 1000)
        return
    }
    
    query := "SELECT TOP 10 * FROM " . selectedText . " WITH (NOLOCK)"
    A_Clipboard := query
    Send("^v")
}

/**
 * MSSQL_SelectCount
 * Extracts selected token and builds SELECT COUNT(*) query.
 */
MSSQL_SelectCount() {
    ShowTooltip("Building SELECT COUNT", 500)
    selectedText := GetSelectedData()
    
    if (selectedText == "") {
        ShowTooltip("No text selected", 1000)
        return
    }
    
    query := "SELECT COUNT(*) FROM " . selectedText . " WITH (NOLOCK)"
    A_Clipboard := query
    Send("^v")
}

/**
 * MSSQL_ExecuteQuery
 * Executes the current query or selected text.
 */
MSSQL_ExecuteQuery() {
    ShowTooltip("Executing Query", 500)
    Send("{F5}")
}

/**
 * MSSQL_NewQuery
 * Opens a new query window.
 */
MSSQL_NewQuery() {
    ShowTooltip("New Query", 500)
    Send("^n")
}

/**
 * MSSQL_ParseResults
 * Formats and cleans query results for export.
 */
MSSQL_ParseResults() {
    ShowTooltip("Parsing Results", 500)
    Send("^a")
    Sleep(100)
    Send("^c")
    Sleep(100)
    ; Add result parsing logic here if needed
}

/**
 * MSSQL_CommentSelection
 * Comments out selected lines in SQL.
 */
MSSQL_CommentSelection() {
    ShowTooltip("Comment Selection", 500)
    Send("^k")
    Sleep(50)
    Send("^c")
}

/**
 * MSSQL_UncommentSelection
 * Uncomments selected lines in SQL.
 */
MSSQL_UncommentSelection() {
    ShowTooltip("Uncomment Selection", 500)
    Send("^k")
    Sleep(50)
    Send("^u")
}

/**
 * MSSQL_RefreshObjectExplorer
 * Refreshes the Object Explorer pane.
 */
MSSQL_RefreshObjectExplorer() {
    ShowTooltip("Refresh Object Explorer", 500)
    Send("{F5}")
}

/**
 * MSSQL_GoToLine
 * Prompts to go to a specific line in the query.
 */
MSSQL_GoToLine() {
    ShowTooltip("Go to Line", 500)
    Send("^g")
}

/**
 * MSSQL_FindAndReplace
 * Opens find and replace dialog.
 */
MSSQL_FindAndReplace() {
    ShowTooltip("Find and Replace", 500)
    Send("^h")
}

/**
 * MSSQL_ToggleResultsPane
 * Toggles the results pane visibility.
 */
MSSQL_ToggleResultsPane() {
    ShowTooltip("Toggle Results Pane", 500)
    Send("^r")
}

/**
 * MSSQL_SaveQuery
 * Saves the current query file.
 */
MSSQL_SaveQuery() {
    ShowTooltip("Save Query", 500)
    Send("^s")
}

/**
 * MSSQL_FormatSQL
 * Formats the selected SQL code (requires SQL Prompt or similar).
 */
MSSQL_FormatSQL() {
    ShowTooltip("Format SQL", 500)
    Send("^k")
    Sleep(50)
    Send("^y")
}

/**
 * MSSQL_ExecuteQueryWithConfig
 * Executes a SQL query using sqlcmd with credentials from config.ini.
 * @param {String} query - The SQL query to execute.
 */
MSSQL_ExecuteQueryWithConfig(query := "") {
    if (query == "") {
        query := GetSelectedData()
        if (query == "") {
            ShowTooltip("No query provided or selected", 2000)
            return
        }
    }

    ; Read credentials from config.ini
    server := GetConfigValue("SQL", "Server")
    username := GetConfigValue("SQL", "Username")
    password := GetConfigValue("SQL", "Password")
    database := GetConfigValue("SQL", "Database")

    if (server == "" || username == "" || password == "" || database == "") {
        ShowTooltip("Missing SQL credentials in config.ini", 2000)
        return
    }

    ; Build sqlcmd command
    sqlcmdCmd := 'sqlcmd -S "' . server . '" -U ' . username . ' -P ' . password . ' -d ' . database . ' -Q "' . query . '"'

    ShowTooltip("Executing SQL Query...", 1000)

    ; Execute in PowerShell to handle the command properly
    Run('powershell.exe -NoExit -Command "' . sqlcmdCmd . '"')
}

/**
 * MSSQL_ExecuteQueryInteractive
 * Prompts for a SQL query and executes it using sqlcmd with config credentials.
 */
MSSQL_ExecuteQueryInteractive() {
    query := InputBox("Enter your SQL query:", "Execute SQL Query", "w400 h200", "")

    if (query.Result == "Cancel" || query.Value == "")
        return

    MSSQL_ExecuteQueryWithConfig(query.Value)
}
