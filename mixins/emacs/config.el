(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (lsp-register-client
    (make-lsp-client
    :new-connection (lsp-stdio-connection '("nil"))
    :major-modes '(nix-mode)
    :server-id 'nix-lsp)))

;; Enable LSP in nix-mode
(add-hook 'nix-mode-hook #'lsp)

;; Set formatter (choose one)
(setq lsp-nix-nil-formatter ["nixpkgs-fmt"])

;; Enable LSP UI
(use-package lsp-ui)

;; Display line numbers
(global-display-line-numbers-mode 1)
