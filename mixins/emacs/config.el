
;;; -*- lexical-binding: t -*-
 
;; Activate evil mode
(setq evil-want-keybinding nil) 
(require 'evil) 

(require 'evil-collection ) 

(evil-collection-init) 
(evil-mode 1) 

;; Display line numbers
(global-display-line-numbers-mode 1)