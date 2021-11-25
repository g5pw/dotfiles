;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! evil-terminal-cursor-changer)

(package! org-super-agenda)
(package! org-ql)
(package! org-sidebar)
(package! org-projectile)

;; Tools
(package! magit-lfs)
(package! magit-todos)
(package! magit-delta)

;; Languages
(package! json-navigator)
(package! platformio-mode)
(package! dokuwiki-mode)

(package! gitlab-ci-mode)

(when (package! org)
  (package! ox-ssh))

(package! tree-sitter)
(package! tree-sitter-langs)

(package! ssh-tunnels :recipe (:host github :repo "death/ssh-tunnels"))
