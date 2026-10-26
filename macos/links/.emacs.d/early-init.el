;;; early-init.el -*- lexical-binding: t; -*-

;; Work around libgccjit guessing an invalid macOS version (e.g. 18.0)
(setenv "MACOSX_DEPLOYMENT_TARGET" "15.0")
(setq native-comp-driver-options '("-mmacosx-version-min=15.0"))
