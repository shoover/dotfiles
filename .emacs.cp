;; Slim .emacs to set local overrides and bootstrap emacs/init.el.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(load "~/emacs/bootstrap.el")

;;(setq org-directory (expand-file-name "~/Dropbox/action"))

;;(setq my-dev-dir "~/dev/one/one")

(setq custom-file (expand-file-name "~/emacs/init.el"))
(load custom-file)

;; Override personal email from custom-file
;;(setq user-mail-address ---)

(put 'narrow-to-region 'disabled nil)

