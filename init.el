;;; package --- Summary
;;; Commentary:
;;; Code:
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

(unless package-archive-contents
  (package-refresh-contents))

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Always load newest byte code
(setq load-prefer-newer t)
;; install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; disable blink
(blink-cursor-mode -1)

;; set initial scratch message nil
(setq initial-scratch-message ";; initial done")

;; disable startup screen
(setq inhibit-splash-screen 1)
(setq inhibit-startup-screen t)
(setq-default cursor-type 'bar)

;; 开机最大屏幕
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
(toggle-frame-fullscreen)

;; 设置meta按键等,目前不需要
;; (setq mac-command-modifier 'meta)
;; (setq mac-control-modifier 'control)
;; (setq mac-option-modifier 'alt)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;;缩进
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)

;; Newline at end of file
(setq require-final-newline t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(menu-bar-mode 0)

;; 关闭自动保存
(setq auto-save-default nil)
;; 不产生备份文件
(setq make-backup-files nil);
(setq backup-inhibited t)
(setq auto-save-list-file-prefix nil)

;; message buffer height
(setq max-mini-window-height 1.00)

(defun self-font()
  (interactive)
  (set-frame-font (format "%s:pixelsize=%d" "Monaco" 13) t)
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family "Hiragino Sans GB W3" :size 16))))

(if window-system (self-font))

(setenv "RUST_SRC_PATH" "/Users/qinxiaoguang01/.rust/src")

(require 'use-package)

;; 加载init-packagess
(require 'init-packages)
;; 加载hints信息
(require 'init-hints)
;; 自动生成文件路径
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)
;;; init.el ends here
