;;;; EMACS CONFIGURATION FILE
;;; Dave Coleman <dave@dav.ee>

; F2 - rename file and buffer
; F4 - refresh file
; F5 - auto compile
; F6 - auto compile just current package
; F7 - kill emacs


;;; INCLUDES ---------------------------------------------------------------------
;; Tell emacs to look in our emacs directory for extensions
(add-to-list 'load-path "~/emacs")

;;; GENERAL ----------------------------------------------------------------------
;disable lock files in emacs 24.3
(setq create-lockfiles nil) 
; no slash screen (is there one?)
(setq inhibit-splash-screen t)
; show column number
(setq column-number-mode t)
; pretty print shortcut
(global-set-key "\M-p" `indent-all)
; goto line
(global-set-key "\M-g" 'goto-line)
; disable menu bar
(menu-bar-mode 0)
; Automatically update a file when it changes on disk (unless buffer has not been saved)
(global-auto-revert-mode t)
; Reload file
(global-set-key [f4] 'refresh-file)
; compile command using F5 key
(global-set-key [f5] 'compile)
(global-set-key [f6] `ros-pkg-compile-command)
; kill emacs server
(setq confirm-kill-emacs 'yes-or-no-p)
(global-set-key [f7] 'save-buffers-kill-emacs)
; make switch bufferer reversible with SHIFT key
(global-set-key (kbd "C-x O") 'previous-multiframe-window)
; no word wrap
(setq truncate-lines t)
(set-default 'truncate-lines t)
; word wrap for compilation buffer
(defun my-compilation-mode-hook ()
  (setq truncate-lines nil) ;; automatically becomes buffer local
  (set (make-local-variable 'truncate-partial-width-windows) nil))
(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)
; word wrap for all text documents
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
; use system copy and paste
;(setq x-select-enable-clipboard t) 
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
; highlight line
;(global-hl-line-mode 1)
;(set-face-background 'hl-line "#333333")
;(set-face-background hl-line-face "gray13")
;(require 'highlight-current-line)
;(highlight-current-line-on t) 
;(highlight-current-line-whole-line-on nil)
;(highlight-current-line-set-bg-color "Black" )
;(highlight-current-line-set-bg-color "MediumPurple4" )

;;; CHANGE ACTIVE WINDOW ----------------------------------------------------------
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

;;; RELOAD FILE -------------------------------------------------------------------
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
)

;;; BACKUP AND AUTOSAVE ---------------------------------------------------------
;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))
;; emacs will create the backup dir automatically, but not the autosave dir.
(make-directory "~/.emacs.d/autosaves/" t)

;;; WARN OF LINES THAT ARE TOO LONG ------------------------------------------------
;(setq default-fill-column 120)
;(require 'fill-column-indicator)
;(setq fci-rule-width 1)
;(setq fci-rule-color "darkblue")
;;(fci-mode 1)
;;(add-hook 'c-mode-hook 'fci-mode) ; only for c files
;(add-hook 'after-change-major-mode-hook 'fci-mode) ; for all files

;;; COMPILATION WINDOW COLORING ---------------------------------------------------------------
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;;; COMPILATION WINDOW AUTO SCROLL ----------------------------------------------------------------
(setq compilation-scroll-output 'first-error)

;;; BETTER INDENT 
;(setq template-args-cont 2) 
(defun indent-all ()
    "Indent entire buffer."
    (interactive)
    (delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
;    (untabify (point-min) (point-max))
)

;;; NO EASY KEYS ------------------------------------------------------------------
(defvar no-easy-keys-minor-mode-map (make-keymap) 
  "no-easy-keys-minor-mode keymap.")
(let ((f (lambda (m)
           `(lambda () (interactive) 
              (message (concat "No! use " ,m " instead."))))))
  (dolist (l '(("<left>" . "C-b") ("<right>" . "C-f") ("<up>" . "C-p")
               ("<down>" . "C-n")
               ("<C-left>" . "M-b") ("<C-right>" . "M-f") ("<C-up>" . "M-{")
               ("<C-down>" . "M-}")
               ("<M-left>" . "M-b") ("<M-right>" . "M-f") ("<M-up>" . "M-{")
               ("<M-down>" . "M-}")
               ("<delete>" . "C-d") ("<C-delete>" . "M-d")
               ("<M-delete>" . "M-d") ("<next>" . "C-v") ("<C-next>" . "M-x <")
               ("<prior>" . "M-v") ("<C-prior>" . "M-x >") 
               ("<home>" . "C-a") ("<C-home>" . "M->")
               ("<C-home>" . "M-<") ("<end>" . "C-e") ("<C-end>" . "M->")))
    (define-key no-easy-keys-minor-mode-map
      (read-kbd-macro (car l)) (funcall f (cdr l)))))
(define-minor-mode no-easy-keys-minor-mode
  "A minor mode that disables the arrow-keys, pg-up/down, delete
  and backspace."  t " no-easy-keys"
  'no-easy-keys-minor-mode-map :global t)
(no-easy-keys-minor-mode 0)

;;; CREATING NEW WINDOW PANES------------------------------------------------------
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))

;;; SHELL MODE --------------------------------------------------------------------

; better contrast colors
(setq ansi-color-names-vector 
      ["black" "red4" "green4" "yellow4"
       "blue" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; turn off word wrap (good?)
(add-hook 'shell-mode-hook 
     '(lambda () (toggle-truncate-lines 1)))

; make prompt read-only
(setq comint-prompt-read-only t)

;; Add color to a shell running in emacs ‘M-x shell’
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; Then set the colors:

(custom-set-faces
;; custom-set-faces was added by Custom — don’t edit or cut/paste it!
;; Your init file should contain only one such instance.
'(comint-highlight-prompt ((t (:foreground "white")))))


;;; --------------------------------------------------------------------------------
;;; C Styles ------------------------------------------------------------------------
;;; ---------------------------------------------------------------------------------

;;; C++ Visual Studio Support ------------------------------------------------------

; http://stackoverflow.com/questions/663588/emacs-c-mode-incorrect-indentation
(defun vs-c-mode-common-hook ()
 ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
 (c-set-offset 'substatement-open 0)
 ;; other customizations can go here

 (setq c++-tab-always-indent t)
 (setq c-basic-offset 4)                  ;; Default is 2
 (setq c-indent-level 4)                  ;; Default is 2

 (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
 (setq tab-width 4)
 (setq indent-tabs-mode t)  ; use spaces only if nil

 (local-set-key (kbd "RET") 'newline-and-indent) ; have the next line auto-indent with return key

 ;; set pre-processor directives
 (c-set-offset (quote cpp-macro) 0 nil) 

 ; In order to get namespace indentation correct, .h files must be opened in C++ mode
 (add-to-list 'auto-mode-alist '("\\.h$" . c++-mode)) 
)
;(add-hook 'c-mode-common-hook 'vs-c-mode-common-hook)




; In order to get namespace indentation correct, .h files must be opened in C++ mode					
;(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;;; C++ PCL Style -------------------------------------------------------------------

(defun pcl-c-mode-common-hook ()
 ; fast riffling
 (fset 'c-indent-riffle [tab down])
 (define-key global-map "\C-z" 'c-indent-riffle)
 (setq c-basic-offset 4)
 ;(setq c-auto-newline t)
 (setq indent-tabs-mode nil)
 (setq c-hanging-braces-alist (quote ((before after))))
 (setq c-offsets-alist (quote ((substatement-open . 0))))
 (setq c-syntactic-indentation t)
 (setq c-tab-always-indent t)

 ; In order to get namespace indentation correct, .h files must be opened in C++ mode
 ;(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
)
;(add-hook 'c-mode-common-hook 'pcl-c-mode-common-hook)

;;; C++ ROS Style ----------------------------------------------------------------
(defun ROS-c-mode-common-hook()
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'innamespace 0)

  ;;Make multiline function arguments start to the left instead of with opening ( of function:
  ;(c-set-offset 'arglist-close 0)
  ;(c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
  ;(c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values

  ; Added by Dave
  ;things i added after emacs indentation was broken after precise upgrade:
  ;(setq c-default-style "linux" c-basic-offset 4)
  ;(c-set-offset 'substatement-open 0)
  
  ; Indent the case word in switch statements
  (c-set-offset 'case-label '+)

)
(add-hook 'c-mode-common-hook 'ROS-c-mode-common-hook)
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.inl$" . c++-mode))

;;; C++ OMPL Style ----------------------------------------------------------------
(defun OMPL-c-mode-common-hook()
  (setq c-basic-offset 4)
  (setq indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'innamespace 4)

  (c-set-offset 'arglist-close 0)
  (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
  (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values

  ; Indent the case word in switch statements
  (c-set-offset 'case-label '+)
)
;(add-hook 'c-mode-common-hook 'OMPL-c-mode-common-hook)


;;; C++ PCL Style ----------------------------------------------------------------
;(load "pcl-c-style.el")
;(add-hook 'c-mode-common-hook 'pcl-set-c-style)

;;; Latex stuff ------------------------------------------------------------------
(custom-set-variables
 '(TeX-PDF-mode t))

(defun vst-needs-auctex-evince ()
  (interactive)
  (setq TeX-output-view-style
	(cons '("^pdf$" "." "evince %o")
	      TeX-output-view-style)))


;;; XML Support ------------------------------------------------------------------
(add-to-list 'auto-mode-alist
              (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss" "launch") t) "\\'")
                    'nxml-mode))


;;; AMPL Support -----------------------------------------------------------------
;; Ampl mode (GNU Math Prog too)

(setq auto-mode-alist
      (cons '("\\.mod$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.dat$" . ampl-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.ampl$" . ampl-mode) auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("ampl" . ampl-mode)
            interpreter-mode-alist))

(load "ampl-mode")


;; Enable syntax coloring
(add-hook 'ampl-mode-hook 'turn-on-font-lock)

;; If you find parenthesis matching a nuisance, turn it off by
;; removing the leading semi-colons on the following lines:

(setq ampl-auto-close-parenthesis nil)
(setq ampl-auto-close-brackets nil)
(setq ampl-auto-close-curlies nil)
(setq ampl-auto-close-double-quote nil)
(setq ampl-auto-close-single-quote nil)


;;; CMAKELISTS -------------------------------------------------------------------
  (require 'cmake-mode)
  (setq auto-mode-alist
        (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                  ("\\.cmake\\'" . cmake-mode))
                auto-mode-alist))

;;; MARKDOWN --------------------------------------------------------------------
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; MATLAB --------------------------------------------------------------------
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)


;;; ROS EMACS --------------------------------------------------------------------
; Only load it if on appropriate machine
(cond ( (string= (getenv "BASHRC_ENV") "ros_monsterz")

	(add-to-list 'load-path "/opt/ros/indigo/share/emacs/site-lisp")
	;; or whatever your install space is + "/share/emacs/site-lisp"
	(require 'rosemacs-config)
	(ido-mode nil)  ;It's just the ido mode, I always found it very useful and there was a feature of roslisp_repl actually that relied on that, so I thought it would make things only better if it was enabled per default. 

	; Keyboard shortcuts. \C-x\C-r means control-x control-r:
	(global-set-key "\C-x\C-r" ros-keymap)
))

;;; YAML -------------------------------------------------------------------------
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))


;;; LAUNCH FILE ------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))


;;; GET CLOSEST MAKEFILE (or other) ---------------------------------------------
; "To do this, you’ll need to extract the closest makefile in the parent directory and above:"

(require 'cl) ; If you don't have it already

(defun* get-closest-pathname (&optional (file "Makefile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.
   This may not do the correct thing in presence of links. If it does not find FILE, then it shall return the name
   of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
    (expand-file-name file
		            (loop 
			     for d = default-directory then (expand-file-name ".." d)
			     if (file-exists-p (expand-file-name file d))
			     return d 
			     if (equal d root)
			     return nil))))

;;; DEFAULT COMPILE COMMAND ------------------------------------------------------
(defun ros-compile-command ()
  (set (make-local-variable 'compile-command) 
       (if (string-equal (file-name-directory (get-closest-pathname ".catkin_workspace")) default-directory)
	 (format "cd %s && catkin b" (file-name-directory (get-closest-pathname ".catkin_workspace_install")))
;	 (format "cd %s && catkin bo moveit_whole_body_ik" (file-name-directory (get-closest-pathname ".catkin_workspace")))
	 (format "cd %s && catkin bd" (file-name-directory (get-closest-pathname ".catkin_workspace")))
       )
  )
)
(add-hook 'c-mode-common-hook 'ros-compile-command)
(add-hook 'cmake-mode-hook 'ros-compile-command)

;;; DEFAULT COMPILE COMMAND FOR ONE PACKAGE ------------------------------------------------------
(defun ros-pkg-compile-command ()
  "Only build Catkin pkg, not whole workspace"
  (interactive)
  (set (make-local-variable 'compile-command)  "catkin bot")
       ;(format "cd %s && catkin bo %s" 
       ;       (file-name-directory (get-closest-pathname ".catkin_workspace"))
       ;       (nth 0 (last (split-string (directory-file-name (file-name-directory (get-closest-pathname "package.xml"))) "/")))
       ;))
  (call-interactively 'compile)
)

;;; COMPILE NOTIFICATION WHEN DONE ------------------------------------------------------
;;; keywords: bell door bell horn compile
(defun notify-compilation-result(buffer msg)
  "Notify that the compilation is finished"
  (if (string-match "^finished" msg)
      (progn 
	(shell-command "play -q ~/unix_settings/emacs/success.wav"))
      (shell-command "play -q ~/unix_settings/emacs/failure.wav"))
  )

(add-to-list 'compilation-finish-functions
	     'notify-compilation-result)

;;; DOXYGEN ---------------------------------------------------------------------
;(add-hook 'c-mode-common-hook
;  (lambda ()
;    (require 'doxymacs)
;    (Doxymacs-mode t)
;    (doxymacs-font-lock)))

;;; RENAME FILE -----------------------------------------------------

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
(global-set-key [f2] 'rename-file-and-buffer)

;;; SNIPPETS --------------------------------------------------------------------
; To reload with emacs still open: M-x yas-reload-all
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/emacs.d/yasnippet/snippets/cc-mode"))
                        ; "~/emacs.d/interesting-snippets"))
(setq yas-snippet-dirs '("~/.emacs.d/snippets" "~/.emacs.d/plugins/yasnippet/snippets"))
(yas-global-mode 1)

;;; Remove white space on save for C files --------------------------------------
;(add-hook 'c-mode-common-hook
;  (lambda()
;    (add-hook 'write-contents-functions
;      (lambda()
;        (save-excursion
;          (delete-trailing-whitespace))))))

;;; Tab completion in shell mode -----------------------------------------------

(require 'bash-completion)
(bash-completion-setup)

;;; Keyboard Shortcut Change offset command -----------------------------------------------

(defun set-c-basic-offset-2-command ()
  (interactive)
  (setq c-basic-offset 2))

(defun set-c-basic-offset-4-command ()
  (interactive)
  (setq c-basic-offset 4))

(global-set-key (kbd "M-2") 'set-c-basic-offset-2-command)
(global-set-key (kbd "M-4") 'set-c-basic-offset-4-command)

;;; Create direcotry if necessary when creating new file --------------------------------------------------------------

(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

;;; EMACS Handling --------------------------------------------------------------

;;; Byte Compile Emacs to speed stuff up
; C-u 0 M-x byte-recompile-directory

; will compile all the .el files in the directory and in all subdirectories below.
; The C-u 0 part is to make it not ask about every .el file that does not have a .elc counterpart.


;;; COMMAND TO RELOAD .emacs FILE -----------------------------------------------
; M-x load-file ENTER
; ~/unix_settings/.emacs
; ENTER

;; To reload snippets from yas with emacs still open: 
; M-x yas-reload-all



