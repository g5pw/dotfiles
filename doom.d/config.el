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

(setq doom-theme 'doom-vibrant)

(setq doom-localleader-key ",")

(setq display-line-numbers-type 'visual)

(setq ibuffer-group-buffers-by "projects")

(setq ispell-dictionary "italiano")

; Lets me type special combining characters
(setq mac-right-option-modifier nil)

(after! tex
  (setq-default TeX-master nil)
  (setq TeX-global-PDF-mode t
        TeX-auto-save t
        TeX-parse-self t
        TeX-source-correlate-mode t)
  (add-to-list 'TeX-view-program-selection
             '(output-pdf "Zathura")))

(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/views/.*\\.php\\'" . web-mode))

(setq calendar-week-start-day 1)

(after! org
  (map! :mode org-mode :localleader
        :desc "Toggle fragment preview" :n "V" #'org-toggle-latex-fragment
        :desc "Export to PDF" :n "P" #'org-beamer-export-to-pdf
        :desc "Export to PDF and open" :n "O" #'(lambda () (interactive) (org-open-file (org-beamer-export-to-pdf))))
  (map! :mode org-beamer-mode :localleader
        :desc "Select environment" :n "E" #'org-beamer-select-environment)
  (map! :desc "Org Agenda" :leader "A" #'org-agenda-list)
  (add-to-list 'org-file-apps '("\\.pdf" . "zathura %s"))
  (setq org-cycle-separator-lines 0
        org-catch-invisible-edits 'show-and-error
        org-list-indent-offset 1
        org-agenda-start-on-weekday 1
        org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷")
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

(map! :map flyspell-mouse-map
      "RET"    nil
      [return] nil)

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups
        '((:name "Next actions"  ; Optionally specify section name
                 :time-grid t  ; Items that appear on the time grid
                 :todo "NEXT")  ; Items that have this TODO keyword
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

(use-package! magit-todos
  :after magit
  :config
  (magit-todos-mode)
  (map! :leader :desc "Search TODOs keywords" :nve "st" #'ivy-magit-todos))

;; Set keys
(map! :nv "~" 'evil-invert-case
      :nv "C-a" 'evil-numbers/inc-at-pt
      :nv "C-x" 'evil-numbers/dec-at-pt)

(map! :n "-" 'dired-jump)

(map! :mode prog-mode :desc "Open header file" :localleader :nve "f" #'ff-find-other-file)

(map! :mode with-editor-mode
      :desc "Confirm commit" :localleader :nve "," #'with-editor-finish
      :desc "Abort commit"   :localleader :nve "." #'with-editor-cancel)

(map! :map ivy-minibuffer-map
      "M-RET" #'ivy-immediate-done)

(map! :leader :prefix "TAB"
      :desc "Switch to last workspace" "TAB" #'+workspace/other
      :desc "Display tab bar"          "`"   #'+workspace/display)

(after! forge
  '(add-to-list 'forge-alist
                '("git-ssh.mittelab.org" "git.mittelab.org/api/v4" "git.mittelab.org" forge-gitlab-repository)))

(after! dired
  (map! :map dired-mode-map
        :nv "h" 'dired-up-directory
        :nv "l" 'dired-find-file))
;; source: https://github.com/alphapapa/unpackaged.el#smerge-mode
(use-package! smerge-mode
  :after hydra
  :config
  (defhydra unpackaged/smerge-hydra
    (:color pink :hint nil :post (smerge-auto-leave))
    "
^Move^       ^Keep^               ^Diff^                 ^Other^
^^-----------^^-------------------^^---------------------^^-------
_n_ext       _b_ase               _<_: upper/base        _C_ombine
_p_rev       _u_pper              _=_: upper/lower       _r_esolve
^^           _l_ower              _>_: base/lower        _k_ill current
^^           _a_ll                _R_efine
^^           _RET_: current       _E_diff
"
    ("n" smerge-next)
    ("p" smerge-prev)
    ("b" smerge-keep-base)
    ("u" smerge-keep-upper)
    ("l" smerge-keep-lower)
    ("a" smerge-keep-all)
    ("RET" smerge-keep-current)
    ("\C-m" smerge-keep-current)
    ("<" smerge-diff-base-upper)
    ("=" smerge-diff-upper-lower)
    (">" smerge-diff-base-lower)
    ("R" smerge-refine)
    ("E" smerge-ediff)
    ("C" smerge-combine-with-next)
    ("r" smerge-resolve)
    ("k" smerge-kill-current)
    ("ZZ" (lambda ()
            (interactive)
            (save-buffer)
            (bury-buffer))
     "Save and bury buffer" :color blue)
    ("q" nil "cancel" :color blue))
  :hook (magit-diff-visit-file . (lambda ()
                                   (when smerge-mode
                                     (unpackaged/smerge-hydra/body)))))


(load-file "~/.emacs.private.el")
