#Requires AutoHotkey v2.0
#SingleInstance Force
#Include CoreLibrary.ahk

; =========================================================================
; GIT SOURCE CONTROL AUTOMATION LAYER
; Context: Git Bash (ahk_exe mintty.exe)
; Intercepts: F13 + Key (only when Git Bash is active)
; =========================================================================

/**
 * Git_Status
 * Runs git status in the current repository.
 */
Git_Status() {
    ShowTooltip("Git Status", 500)
    Send("git status{Enter}")
}

/**
 * Git_Pull
 * Pulls latest changes from the current branch.
 */
Git_Pull() {
    ShowTooltip("Git Pull", 500)
    Send("git pull{Enter}")
}

/**
 * Git_Push
 * Pushes current branch to remote.
 */
Git_Push() {
    ShowTooltip("Git Push", 500)
    Send("git push{Enter}")
}

/**
 * Git_AddAll
 * Stages all changes in the repository.
 */
Git_AddAll() {
    ShowTooltip("Git Add All", 500)
    Send("git add .{Enter}")
}

/**
 * Git_Commit
 * Opens the default editor to write a commit message for staged changes.
 */
Git_Commit() {
    ShowTooltip("Git Commit", 500)
    Send("git commit{Enter}")
}

/**
 * Git_Log
 * Shows commit history.
 */
Git_Log() {
    ShowTooltip("Git Log", 500)
    Send("git log --oneline -10{Enter}")
}

/**
 * Git_Branch
 * Shows current branch and lists all branches.
 */
Git_Branch() {
    ShowTooltip("Git Branch", 500)
    Send("git branch -a{Enter}")
}

/**
 * Git_Checkout
 * Prompts to checkout a branch.
 */
Git_Checkout() {
    ShowTooltip("Git Checkout", 500)
    Send("git checkout {Enter}")
}

/**
 * Git_Stash
 * Stashes current changes.
 */
Git_Stash() {
    ShowTooltip("Git Stash", 500)
    Send("git stash{Enter}")
}

/**
 * Git_StashPop
 * Applies most recent stash.
 */
Git_StashPop() {
    ShowTooltip("Git Stash Pop", 500)
    Send("git stash pop{Enter}")
}

/**
 * Git_Diff
 * Shows unstaged changes.
 */
Git_Diff() {
    ShowTooltip("Git Diff", 500)
    Send("git diff{Enter}")
}

/**
 * Git_ResetHard
 * Resets current branch to match remote (destructive).
 */
Git_ResetHard() {
    ShowTooltip("Git Reset Hard", 500)
    Send("git reset --hard HEAD{Enter}")
}

/**
 * Git_Fetch
 * Fetches all remote changes without merging.
 */
Git_Fetch() {
    ShowTooltip("Git Fetch", 500)
    Send("git fetch --all{Enter}")
}

/**
 * Git_Merge
 * Prompts to merge a branch into current branch.
 */
Git_Merge() {
    ShowTooltip("Git Merge", 500)
    Send("git merge {Enter}")
}
