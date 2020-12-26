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

;; Tools
(package! magit-lfs)
(package! magit-todos)

;; Languages
(package! json-navigator)
(package! platformio-mode)
(package! dokuwiki-mode)

(package! gitlab-ci-mode)

(when (package! org)
  (package! ox-ssh))
