;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


(load-file "~/.emacs.private.el")
(load-file "~/.doom.d/hydras.el")
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

(after! ibuffer
  (setq ibuffer-group-buffers-by "projects"))

(setq ispell-dictionary "italiano")

; Lets me type special combining characters
(if IS-MAC
    (undefine-key! doom-leader-open-map "l" "L")  ; I don't have LaunchBar
    (setq mac-right-option-modifier nil))

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

; Starts week on Monday
(setq calendar-week-start-day 1)


(after! org
  (map! :map org-beamer-mode-map :localleader
        :desc "Export to PDF" :n "P" #'org-beamer-export-to-pdf
        :desc "Select environment" :n "sE" #'org-beamer-select-environment)
  (map! :mode org-mode :localleader
        :desc "Export to PDF and open" :n "O" #'(lambda () (interactive) (org-open-file (org-beamer-export-to-pdf))))
  (map! :leader :prefix ("O" . "Org mode")
        :desc "TODOs" :nve "t" #'org-todo-list
        :desc "Search" :nve "s" #'org-search-view)
  (add-to-list 'org-file-apps '("\\.pdf" . "zathura %s"))
  (setq org-archive-location "./archive/%s_archive::"
        org-cycle-separator-lines 0
        org-catch-invisible-edits 'show-and-error
        org-list-indent-offset 1
        org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+"))
        org-superstar-headline-bullets-list '("☰" "☱" "☲" "☳" "☴" "☵" "☶" "☷" "☷" "☷" "☷")
        org-startup-folded 'content
        org-ellipsis "↴"
        org-return-follows-link t
        org-enforce-todo-dependencies t
        org-enforce-todo-checkbox-dependencies t
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w)"
                                      "|"
                                      "DONE(d)" "DELEGATED(l)" "CANCELED(c)" "DEFERRED(f)"))
        org-latex-create-formula-image-program 'dvipng
        org-latex-packages-alist '(("binary-units" "siunitx" t))
        org-refile-targets (quote ((nil :maxlevel . 2)
                                   (org-agenda-files :maxlevel . 2)))))

(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

(use-package! doct
  :after org
  :config
  (setq org-capture-templates
        (doct '(("TODO (personal)" :keys "t"
                 :file "inbox.org"
                 :prepend t
                 :template ("* TODO %?\n%i\n%a"))
                ("Note (personal)" :keys "n"
                 :file "notes.org"
                 :headline "Inbox"
                 :prepend t
                 :template ("* %?\n%i\n%a"))
                ("Habit" :keys "h"
                 :file "habits.org"
                 :headline "Inbox"
                 :prepend t
                 :template ("* %?\n%i\n%a"))
                ))))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (map! :desc "Org Agenda" :leader "A" #'org-agenda-list)
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-start-day nil ;; i.e. today
        org-agenda-span 2
        org-agenda-start-on-weekday 1)
  (setq org-super-agenda-groups
        '((:name "Next actions"  ; Optionally specify section name
                 :time-grid t  ; Items that appear on the time grid
                 :todo "NEXT")  ; Items that have this TODO keyword
          (:name "Important"
                 :priority "A")))
  :config
  (setq org-super-agenda-header-map (copy-keymap evil-normal-state-map))
  (org-super-agenda-mode))

(use-package! org-projectile
  :config
  (map! :leader :desc "Add project todo" :nve "pT" #'org-projectile-project-todo-completing-read)
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "project.org"
        org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
  (add-to-list 'org-capture-templates (org-projectile-project-todo-entry) t)
  )

(use-package! org-ql
  :config
  (map! :leader :prefix "O"
        :desc "org-ql search" :nve "q" #'org-ql-search
        :desc "org-ql views" :nve "w" #'org-ql-view)
  (setq org-ql-views '(("Current projects" :buffer-files org-directory :query
                        (and
                         (todo "STARTED")
                         (category "PROJECT")))
                       ("Project ideas" :buffer-files org-org-directory :query
                        (and
                         (todo "IDEA")
                         (category "PROJECT"))))))

(use-package! org-sidebar
  :after org
  :config
  (map! :mode org-mode :leader :desc "Toggle sidebar" :nve "tS" #'org-sidebar-toggle))

(use-package! magit-todos
  :after magit
  :config
  (magit-todos-mode)
  (map! :leader :desc "Search TODOs keywords" :nve "st" #'ivy-magit-todos))

(use-package! magit-delta
  :after magit
  :hook (magit-mode . magit-delta-mode))

;; Set keys
(map! :nv "~" #'evil-invert-case
      :nv "C-a" #'evil-numbers/inc-at-pt
      :nv "C-x" #'evil-numbers/dec-at-pt)

(map! :n "-" #'dired-jump)

(map! :mode prog-mode :desc "Open header file" :localleader :nve "f" #'ff-find-other-file)

(map! :mode with-editor-mode
      :desc "Confirm commit" :localleader :nve "," #'with-editor-finish
      :desc "Abort commit"   :localleader :nve "." #'with-editor-cancel)

(map! :map ivy-minibuffer-map
      "M-RET" #'ivy-immediate-done)

(map! :leader :prefix "TAB"
      :desc "Switch to last workspace" "TAB" #'+workspace/other
      :desc "Display tab bar"          "`"   #'+workspace/display)

(map! :desc "Minimize/suspend frame" :leader :nv "qm" #'suspend-frame)

(after! dired
  (map! :map dired-mode-map
        :nv "h" 'dired-up-directory
        :nv "l" 'dired-find-file))

(use-package! gitlab-ci-mode
  :mode "\\.gitlab-ci\\.yml$")

(use-package! ox-ssh 
	      :ensure t
	      :after org
              :config
              (setq org-ssh-header "IgnoreUnknown AddKeysToAgent,UseKeychain
Match host * exec \"gpg-connect-agent UPDATESTARTUPTTY /bye\"

Host *
  AddKeysToAgent yes
  UseKeychain yes
"))

(use-package! ssh-tunnels
  :config
  (map! :leader :prefix ("os" . "ssh-tunnel")
        :desc "Kill SSH tunnel" "k" #'ssh-tunnels-kill-tunnel
        :desc "Run SSH tunnel"  "r" #'ssh-tunnels-run-tunnel))

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (use-package! ox-awesomecv
;; 	      :after org)

;; source: https://github.com/alphapapa/unpackaged.el#smerge-mode
(use-package! smerge-mode
  :after hydra
  :config

  :hook (magit-diff-visit-file . (lambda ()
                                   (when smerge-mode
                                     (unpackaged/smerge-hydra/body)))))
