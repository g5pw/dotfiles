;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;
(if (window-system)
    (progn
      (tool-bar-mode -1) ; Disable toolbar
      (scroll-bar-mode -1) ; Disable scrollbar
      (setq default-frame-alist ; set default window size
            '((width . 140)
              (height . 40)))))

(setq doom-font (font-spec :family "Iosevka" :size 13))

(setq ibuffer-group-buffers-by "projects")

(setq ispell-dictionary "italiano")

; Lets me type special combining characters
(setq mac-right-option-modifier nil)

(after! tex
  (setq-default TeX-master nil)
  (setq TeX-global-PDF-mode t
        TeX-auto-save t
        TeX-parse-self t
        TeX-view-program-list '(("Skim" "/usr/bin/open -a Skim.app %o"))
        TeX-view-program-selection '((output-pdf "Skim"))
        TeX-source-correlate-mode t))

;(add-hook! org-mode
;           '(setcdr (assoc "\\.pdf\\'" org-file-apps) "open -a Skim %s"))

(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/views/.*\\.php\\'" . web-mode))

(setq calendar-week-start-day 1)

(after! org
  (map! :mode org-mode :map org-mode-map :localleader :desc "Toggle fragment preview" :n "v" #'org-toggle-latex-fragment)
  (map! :mode org-beamer-mode :localleader
        :desc "Export to PDF" :n "e p" #'org-beamer-export-to-pdf
        :desc "Export to PDF and open" :n "e o" #'(lambda () (interactive) (org-open-file (org-beamer-export-to-pdf)))
        :desc "Select environment" :n "s e" #'org-beamer-select-environment)
  (setq org-cycle-separator-lines 0
        org-catch-invisible-edits 'show-and-error
        org-list-indent-offset 1
        org-agenda-start-on-weekday 1
        org-bullets-bullet-list '("■" "◆" "✦" "✸" "✱")
        org-ellipsis "↴"
        org-return-follows-link t
        org-enforce-todo-dependencies t
        org-enforce-todo-checkbox-dependencies t
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)"
                                      "|"
                                      "DONE(d)" "DELEGATED(l)" "CANCELED(c)"))
        org-latex-create-formula-image-program 'dvipng
        org-latex-packages-alist '(("" "siunitx" t))
        org-refile-targets (quote ((nil :maxlevel . 2)
                                   (org-agenda-files :maxlevel . 2)))))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups
        '((:name "Next actions"  ; Optionally specify section name
                 :time-grid t  ; Items that appear on the time grid
                 :todo "NEXT")  ; Items that have this TODO keyword
          (:name "test"
                 :deadline "today")
          (:name "Important"
                 :priority "A")))
  :config
  (org-super-agenda-mode))

(use-package! evil-terminal-cursor-changer
  :unless window-system
  :config (evil-terminal-cursor-changer-activate))

(use-package! org-sidebar
  :after org
  :config
  (map! :mode org-mode :leader :desc "Toggle sidebar" :nve "tS" #'org-sidebar-toggle))

;; Set keys

; tildeop
(map! :nv "~" 'evil-invert-case)

(map! :nv "C-a" 'evil-numbers/inc-at-pt)
(map! :nv "C-x" 'evil-numbers/dec-at-pt)

(map! :n "-" 'dired-jump)

(after! forge
  '(add-to-list 'forge-alist
                '("git-ssh.mittelab.org" "git.mittelab.org/api/v4" "git.mittelab.org" forge-gitlab-repository)))

(load-file "~/.emacs.private.el")
