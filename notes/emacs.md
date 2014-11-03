Emacs Notes
=========

Keyboard shortcuts (custom) -------------------------------------

F2 - rename file and buffer
F4 - refresh file
F5 - auto compile
F6 - auto compile just current package
F7 - kill emacs

Formatting --------------------------------------------------------

Comment region
  M-x comment-region
      uncomment-region

Delete trailing whitespace
  M-x delete-trailing-whitespace

Make buffer writeable
  M-x toggle-read-only

Word wrap
  M-x visual-line-mode
  or
  toggle-truncate-lines

Indent Region in C-Mode
  C-x TAB

Indent Region in Any Mode
  C-u -2 C-x <TAB>  # indents backwards to spaces

Do command X times:
  C-u X

Window Management --------------------------------------------------------

Make three column windows equal size (equally size all windows)
  C-x + 

File Handling --------------------------------------------------------

Revert unsaved changes to a file
  M-x revert-buffer

Python Only --------------------------------------------------------

Emacs bulk indent for Python
  C-c >   shifts region 4 spaces to the right
  C-c <   shifts region 4 spaces to the left

