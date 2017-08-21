;; Gerado por:
;; https://github.com/guaracy/.emacs.d
;;
;; tema
(load-theme 'misterioso)
;; texto da barra de título
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
;; tamanho da janela
(setq initial-frame-alist
      '((width . 130)
        (height . 40)))
;; elementos visuais
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; apresentação/entrada do texto
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq truncate-lines t)
(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-linum-mode t)
(global-hl-line-mode 1)
(ido-mode t)
;; modeline
(line-number-mode 1)
(column-number-mode 1)
(setq initial-scratch-message
      ";; Nada neste buffer será salvo. Use:\n;; Ctrl+x Ctrl+r / Ctrl+x Ctrl+f para ler um arquivo.\n")

(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idlw-delay 0.5))

(use-package smex
  :ensure t
  :bind (("M-x" . smex)
         ("M-X" . smex-major-mode-commands)))

(use-package iedit
  :ensure t
  :bind (("C-;" . iedit-mode)
         ("C-RET" . iedit-rectangle-mode)))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)))

(use-package htmlize
  :ensure t
  :defer t)

(use-package ido-grid-mode
  :ensure t
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode t)
  (ido-grid-mode t))

(use-package ido-select-window
  :ensure t
  :bind ("C-x o" . ido-select-window))

(use-package ido-yes-or-no
  :ensure t
  :config
  (ido-yes-or-no-mode t))

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default))

(use-package red
  :load-path "~/github/guaracy/red.el"
  :config
  (autoload 'red-mode "red.el" "Major mode for Red development" t)
  (add-to-list 'auto-mode-alist '("\\.red$" . red-mode))
  )

(use-package hlinum
  :ensure t
  :config
  (hlinum-activate))

(use-package linum-off
  :ensure t)

(use-package indent-guide
  :ensure t
  :config
  (indent-guide-global-mode))

(use-package less-css-mode
  :ensure t)

(use-package neotree
  :ensure t
  :bind ("C-\\" . neotree-toggle))

(use-package paradox
  :ensure t
  :config
  (paradox-enable))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  (require 'color)
  (defvar my-paren-dual-colors    
    '((face-attribute 'font-lock-string-face :foreground)
      (face-attribute 'font-lock-keyword-face :foreground)))
  (setq rainbow-delimiters-outermost-only-face-count 0)
  (setq rainbow-delimiters-max-face-count 2)
  (set-face-foreground 'rainbow-delimiters-depth-1-face
                       (eval (elt my-paren-dual-colors 1)))
  (set-face-foreground 'rainbow-delimiters-depth-2-face
                       (eval (elt my-paren-dual-colors 0))) 
                       )

(use-package ox-gfm
  :ensure t)
(use-package el2org
  :ensure t)

(use-package org-webpage
  :ensure t
  :defer t)
(org2web-add-project
 '("cadafalso"
   :repository-directory "~/projetos/org2blog"
   :remote (git "https://github.com/guaracy/guaracy.github.com.git" "master")
   :site-domain "http://guaracy.github.io/"
   :site-main-title "Cadafalso"
   :site-sub-title "Apenas mais um blog"
   :default-category "blog"
   :theme (org)
   :source-browse-url ("Github" "https://github.com/guaracy/guaracy.github.com")
   :web-server-port 7654))

(setq org-confirm-babel-evaluate nil)
(setq org-support-shift-select t)
(setq org-support-shift-select 'always)
(setq org-html-htmlize-output-type 'css)
(setq org-src-fontify-natively t)
(setq org-export-default-language "pt_BR")
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'toggle-word-wrap)
(add-to-list 'org-structure-template-alist '("t" "#+begin_tip ?\n\n#+end_tip"))
(add-to-list 'org-structure-template-alist '("n" "#+begin_note ?\n\n#+end_note"))
;; linguagens utilizadas por org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (red . t)
   (python . t)
   (ruby . t)
   (R . t)
   (C . t)
   (ditaa . t)
   (shell . t)))

(defvar my-term-shell "/usr/bin/zsh")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items 25)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(global-set-key (kbd "C-x C-r") 'recentf-ido-find-file)

;; ------  fim do arquivo de configuração
