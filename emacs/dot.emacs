;; Tell emacs to look in our emacs directory for extensions
(setq load-path (cons "~/emacs" load-path))

;;
;; Ampl mode (GNU Math Prog too)
;;

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

;(setq ampl-auto-close-parenthesis nil)
;(setq ampl-auto-close-brackets nil)
;(setq ampl-auto-close-curlies nil)
;(setq ampl-auto-close-double-quote nil)
;(setq ampl-auto-close-single-quote nil)

