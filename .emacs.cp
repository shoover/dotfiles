;; Slim .emacs to set local overrides and bootstrap emacs/init.el.

(load "~/emacs/bootstrap.el")

;;(setq org-directory (expand-file-name "~/Dropbox/action"))

;;(setq my-dev-dir "~/dev/one/one")

(setq custom-file (expand-file-name "~/emacs/init.el"))
(load custom-file)

;; Override personal email from custom-file
;;(setq user-mail-address ---)

(put 'narrow-to-region 'disabled nil)

