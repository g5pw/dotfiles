;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! evil-terminal-cursor-changer)

(package! org-ql)
(package! org-sidebar)
(package! org-super-agenda)
(package! org-projectile)

;; Tools
(package! magit-lfs)
(package! magit-delta)

;; Languages
(package! json-navigator)
(package! platformio-mode)
(package! dokuwiki-mode)
(package! hcl-mode)

(package! gitlab-ci-mode)

(when (package! org)
  (package! doct)
  (package! ox-ssh)
  (package! ox-moderncv :recipe (:host github :repo "Titan-C/org-cv"))
  (package! edraw-org :recipe (:host github :repo "misohena/el-easydraw"))
  (package! ox-typst :recipe (:host github :repo "jmpunkt/ox-typst"))
)

(package! sql-indent)

(package! mermaid-mode)
(package! ob-mermaid)

(package! uv-mode)

(package! typst-ts-mode
  :recipe (:type git :host sourcehut :repo "meow_king/typst-ts-mode" :files (:defaults "*.el")))
