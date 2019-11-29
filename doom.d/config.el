;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-font (font-spec :family "Iosevka" :size 13))

(setq ibuffer-group-buffers-by "projects")

(setq ispell-dictionary "italiano")

;; Lets me type special combining characters
(setq mac-right-option-modifier nil)

(setq-default TeX-master nil)
(setq TeX-global-PDF-mode t
      TeX-auto-save t
      TeX-parse-self t
      TeX-view-program-list '(("Skim" "/usr/bin/open -a Skim.app %o"))
      TeX-view-program-selection '((output-pdf "Skim"))
      TeX-source-correlate-mode t)

(add-hook! org-mode
           '(add-to-list 'org-modules 'org-habit)
           '(setcdr (assoc "\\.pdf\\'" org-file-apps) "open -a Skim %s"))

(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/views/.*\\.php\\'" . web-mode))

;; Set keys
;;(spacemacs/set-leader-keys-for-major-mode 'org-mode "v" 'org-toggle-latex-fragment)
;;(spacemacs/set-leader-keys-for-major-mode 'org-mode "S" 'org-sidebar)
;;(spacemacs/set-leader-keys-for-minor-mode 'org-beamer-mode "ep" 'org-beamer-export-to-pdf)
;;(spacemacs/set-leader-keys-for-minor-mode 'org-beamer-mode "eo" '(lambda () (interactive) (org-open-file (org-beamer-export-to-pdf))))
;;(spacemacs/set-leader-keys-for-minor-mode 'org-beamer-mode "se" 'org-beamer-select-environment)

(setq calendar-week-start-day 1)

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
                                 (org-agenda-files :maxlevel . 2))))

(setq org-super-agenda-groups
      '((:name "Next actions"  ; Optionally specify section name
               :time-grid t  ; Items that appear on the time grid
               :todo "NEXT")  ; Items that have this TODO keyword
        (:name "test"
               :deadline "today")
        (:name "Important"
               :priority "A")))

(define-key evil-normal-state-map "~" 'evil-invert-case)
(define-key evil-visual-state-map "~" 'evil-invert-case)

(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate)
  )

(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
(define-key evil-visual-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)

(tool-bar-mode -1)

;; Set normal emacs window size
(if (display-graphic-p)
    (setq default-frame-alist
          '((width . 140)
            (height . 40))))

(after! forge
  '(add-to-list 'forge-alist
                '("git-ssh.mittelab.org" "git.mittelab.org/api/v4" "git.mittelab.org" forge-gitlab-repository)))

(load-file "~/.emacs.private.el")
