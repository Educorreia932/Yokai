
;;; -*- lexical-binding: t -*-
 
;; Activate evil mode
(setq evil-want-keybinding nil) 
(require 'evil) 

(require 'evil-collection ) 

(evil-collection-init) 
(evil-mode 1) 

;; Display line numbers
(global-display-line-numbers-mode 1)

(global-font-lock-mode 1)             ;; Turn on for all buffers
(setq font-lock-maximum-decoration t) ;; Use maximum decoration for syntax highlighting

;; Basic associations for built-in and installed modes
(setq auto-mode-alist
      (append
       '(("\\.py\\'"      . python-mode)
         ("\\.js\\'"      . js-mode)
         ("\\.ts\\'"      . typescript-mode)
         ("\\.jsx\\'"     . js-jsx-mode)
         ("\\.c\\'"       . c-mode)
         ("\\.cpp\\'"     . c++-mode)
         ("\\.java\\'"    . java-mode)
         ("\\.go\\'"      . go-mode)
         ("\\.rs\\'"      . rust-mode)
         ("\\.md\\'"      . markdown-mode)
         ("\\.yaml\\'"    . yaml-mode)
         ("\\.yml\\'"     . yaml-mode)
         ("\\.html?\\'"   . html-mode)
         ("\\.css\\'"     . css-mode)
         ("\\.json\\'"    . json-mode)
         ("\\.sh\\'"      . sh-mode))
       auto-mode-alist))