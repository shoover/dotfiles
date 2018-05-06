;; init.el is my real ".emacs". It loads libraries, helper functions, and
;; settings. It is synced across machines through dropbox. Literal .emacs is
;; for private and per-machine overrides.


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

;;(set-face-attribute 'default nil :height 109 :family "Monaco")
;;(set-face-attribute 'outline-1 nil :height 116 :family "Monaco" :weight 'bold)
;;(set-face-attribute 'outline-2 nil :height 110 :family "Monaco" :weight 'bold)
;;(set-face-attribute 'outline-3 nil :height 109 :family "Monaco" :weight 'bold)
;;(set-face-attribute 'outline-4 nil :height 109 :family "Monaco")
;;(set-face-attribute 'outline-5 nil :height 109 :family "Monaco")
;;(set-face-attribute 'outline-6 nil :height 109 :family "Monaco")

;;(setq inferior-lisp-program "java -jar c:/users/shawn/dev/clojure/clojure.jar")

;;(setq inferior-fsharp-program "\"c:\\Program Files (x86)\\Microsoft SDKs\\F#\\4.0\\Framework\\v4.0\\Fsi.exe\"")
;;(setq fsharp-compiler "\"c:\\Program Files (x86)\\Microsoft SDKs\\F#\\4.0\\Framework\\v4.0\\Fsc.exe\"")

;; Override personal email from custom-file
;;(setq user-mail-address ---)

;;(setq scpaste-http-destination "http://internal.xia.com/paste"
;;      scpaste-scp-destination "internal.xia.com:/var/www/paste")

(put 'narrow-to-region 'disabled nil)

