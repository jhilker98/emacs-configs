(setq org-agenda-files (quote ("~/Dropbox/agendas/school.org")))

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package undo-tree
:ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package imenu-list
:ensure t
:config
(setq-default imenu-list-position "left"))
;(imenu-list-minor-mode t)

(use-package which-key
:ensure t
:config
(which-key-mode 1))

(use-package magit
:ensure t)

(use-package all-the-icons
:ensure t)

(use-package projectile
:ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package general
:ensure t)

(use-package unfill
:ensure t)

(use-package yasnippet
:ensure t)
(use-package yasnippet-snippets
:ensure t)

(use-package restart-emacs
:ensure t)

(use-package doom-themes
:ensure t)

(use-package color-theme-solarized
:ensure t)
(use-package solarized-theme
:ensure t)

(use-package doom-modeline
:ensure t)

(use-package wc-mode
:ensure t
:config
(setq-default wc-modeline-format "%tw"))

(use-package writegood-mode
:ensure t)

(use-package writeroom-mode
:ensure t)

(use-package wordsmith-mode
:ensure t)

(use-package decide
:ensure t)

(use-package ivy
:ensure t
:config
(ivy-mode 1))

;(use-package counsel-projectile)
(use-package counsel
:ensure t)

(use-package swiper
  :commands (swiper swiper-all))

(use-package auto-complete
:ensure t)

(use-package elpy
:ensure t)

(use-package bbcode-mode
:ensure t)

(use-package org-bullets
:after org
:ensure t)

(use-package toc-org
  :after org
  :init (add-hook 'org-mode-hook #'toc-org-enable))

(use-package org-super-agenda
:ensure t)

(defun edit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/jmacs.org"))

(defalias 'yes-or-no-p 'y-or-n-p)

(defun wordCount (&optional begin end)
  "count words between BEGIN and END (region); if no region defined, count words in buffer"
  (interactive "r")
  (let ((b (if mark-active begin (point-min)))
      (e (if mark-active end (point-max))))
    (message "%s words" (how-many "\\w+" b e))))

(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT
 aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.nvl\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.chrs\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.cmp\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.chr\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.aar\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.otl\\'" . org-mode))

(add-hook 'org-mode-hook 'visual-line-mode)

(setq-default org-bullets-mode 1)
(add-hook 'org-mode-hook 'org-bullets-mode)
(add-hook 'org-mode-hook 'org-super-agenda-mode)
(add-hook 'org-mode-hook 'flyspell-mode)

(add-hook 'org-mode-hook 'wc-mode)
(add-hook 'org-mode-hook 'decide-mode)

(global-auto-complete-mode 1)
(setq-default auto-complete-mode 1)
(setq-default yas-minor-mode 1)

(setq-default doom-modeline-mode 1)

;(rich-minority-mode 1)
;(ivy-rich-mode 1)

(add-hook 'python-mode 'elpy-mode)
(add-to-list 'auto-mode-alist '("\\.bbc\\'" . bbcode-mode))



(general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; Specific Keybinding Replacements
    "SPC" (general-simulate-key "M-x")
    "c"   (general-simulate-key "C-c")
    "h"   (general-simulate-key "C-h")
    "u"   (general-simulate-key "C-u")
    "x"   (general-simulate-key "C-x")
    
   ;; quit commands  
   "q" '(:ignore t :which-key "quit emacs")
   "qq"  'kill-emacs
   "qz"  'delete-frame
   "qr"  'restart-emacs
   ;; Buffer commands 
    "b"   '(:ignore t :which-key "buffers")
    "bb"  'mode-line-other-buffer
    "bd"  'kill-this-buffer
    "bn"  'next-buffer
    "bp"  'previous-buffer
    "bq"  'kill-buffer-and-window
    "bR"  'rename-file-and-buffer
    "br"  'revert-buffer
    "bw"  'wordCount
;; Window commands
   "w"  '(:ignore t :which-key "Windows")
   "w-" 'split-window-right
   "w|" 'split-window-below
   "wn" 'other-window
   "wd"  'delete-window
   "wD"  'delete-other-windows
   "wm" 'maximize-window

;; Files
   "f" '(:ignore t :which-key "Files")
   "fe" '(:ignore t :which-key "Edit file")
   "feD" 'edit-emacs-config
   "ff"  'counsel-find-file
   "fs"  'save-buffer
   "f" '(:ignore t :which-key "Files")
   "fe" '(:ignore t :which-key "Edit file")
   "feD" 'edit-emacs-config
   "fE" '(:ignore t :which-key "Eval file")
   "fEr" 'eval-region
   "fEb" 'eval-buffer
   "fEd" 'eval-defun
   "ff"  'counsel-find-file
   "fs"  'save-buffer

   ;; Packages
   "p" '(:ignore t :which-key "Packages")
   "pl" 'package-list-packages
   "pr" 'package-refresh-contents
   "pi" 'package-install
   "pI" 'package-initialize
   "pd" 'package-delete

   ;; Org-Mode
   "o" '(:ignore t :which-key "Org Menu")
   "os" 'org-schedule
   "oS" 'org-save-all-org-buffers
   "oa" 'org-agenda
   "on" 'org-shiftright
   "op" 'org-shiftleft
   "od" 'org-deadline
   "oc" 'org-cycle-agenda-files
   ;; Magit
   "g" '(:ignore t :which-key "Magit")
   "gs" 'magit-status
   "gS" 'magit-stage-file
   "gc" 'magit-commit
   "gp" 'magit-push
   "gP" 'magit-push-to-remote
   "gd" 'magit-diff 

;; IMenu-List toggle
   "m" '(:ignore t :which-key "Imenu-list") 
   "mt" 'imenu-list-smart-toggle
   "me" 'imenu-list-goto-entry
;; Writer Commands
   "r"  '(:ignore t :which-key "Writeroom Mode")
   "rt" 'writeroom-mode
   "rm" 'writeroom-toggle-mode-line
   "rw" 'wordsmith-mode
;; Toggles
   "t" '(:ignore t :which-key "Toggle")
   "tw" 'toggle-word-wrap
   "tf" 'unfill-toggle
   "tn" 'display-line-numbers-mode

;; General Mode Toggles
   "M" '(:ignore t :which-key "Mode Toggles")
   "Ma" 'auto-complete-mode
   "Mi" 'org-indent-mode
   "Mw" 'wc-mode
   "Md" 'decide-mode
   "My" 'yas-minor-mode 
   "MW" 'writegood-mode
   "Mf" 'flyspell-mode

;; YaSnippet Shortcuts
"y" '(:ignore t :which-key "Yasnippet")
"yn" 'yas-new-snippet
"yi" 'yas-insert-snippet
"yy" 'yas-minor-mode

;; Spell-check
"s" '(:ignore t :which-key "Spell Check")
"sn" 'flyspell-goto-next-error
"sb" 'flyspell-buffer
"sc" 'flyspell-correct-word-before-point  
"st" 'ispell-minor-mode


)

(general-define-key
:states 'normal
"TAB" 'evil-toggle-fold)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

(setq-default org-hide-leading-stars t)
;(setq-default org-ellipsis "⤵")
(setq org-src-fontify-natively t)  
(setq org-hide-emphasis-markers t)


(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(setq-default org-bullets-bullet-list 
'("⚫" "○"))

(set-face-attribute 'default t :font "Source Code Pro-12")
; (setq solarized-use-variable-pitch nil)

 ;   (setq solarized-scale-org-headlines nil)

  ;  (setq solarized-height-minus-1 1)
   ; (setq solarized-height-plus-1 1)
    ;(setq solarized-height-plus-2 1)
    ;(setq solarized-height-plus-3 1)
    ;(setq solarized-height-plus-4 1)

;(load-theme 'solarized t)
(load-theme 'doom-solarized-dark t)
;(load-theme 'doom-solarized-light t)
;(load-theme 'doom-one t)
;(load-theme 'doom-gruvbox t)
;(load-theme 'doom-material t)
;(load-theme 'doom-nord t)
;(setq solarized-termcolors 256)
;(load-theme 'solarized-dark t)

(setq-default header-line-format
'(:eval (propertize (format-time-string " %d %b  %I:%M %p ")
                                   'face 'font-lock-builtin-face))
)

;(setq rm-blacklist
 ;     (format "^ \\(%s\\)$"
  ;            (mapconcat #'identity
   ;                      '("Fly.*" "Projectile.*" "PgLn" "Undo-Tree" "yas" "WK" "Ivy" "Decide" "$")
    ;                     "\\|")))
;(defun prose-setup ()
;(setq mode-line-format
;'((:eval (simple-mode-line-render
                ;; left
;               (format-mode-line "%b [%*]"))))
                ;; right
 ;             (format-mode-line "%m  %M" )))
 ; (add-hook 'org-mode-hook 'prose-setup)

;  (use-package all-the-icons
 ; :ensure t)
  (defvar doom-modeline-icon (display-graphic-p) )
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))
  (setq doom-modeline-icon t) 
  (doom-modeline-def-modeline 'prose-modeline
  '(bar word-count buffer-info-simple)
  '(major-mode battery))

  (defun set-prose-modeline ()
    (doom-modeline-set-modeline 'prose-modeline))
  (add-hook 'org-mode-hook 'set-prose-modeline)

;(setq-default sml/no-confirm-load-theme t)
;(sml/setup)
;(sml/apply-theme 'respectful)
