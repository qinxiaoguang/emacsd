;; 配置插件源
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; cl - Common Lisp Extension
(require 'cl)

;; 设置自动安装插件源
(defvar qxg-packages
  '(
    ;; auto-complete
    ;; auto-complete-clang
    company
    ;; better editor
    hungry-delete
    swiper
    counsel
    smartparens
    ;; major-mode
    js2-mode
    ;; minor mode
    nodejs-repl
    exec-path-from-shell
    ;;theme
    monokai-theme
    popwin
    smex
    ;; helm
    ace-jump-mode
    neotree
    flycheck
    flycheck-pos-tip
    evil
    evil-leader
    evil-nerd-commenter
    ivy
    imenu-list
    go-mode
    go-eldoc
    company-go
    ) "default packages")

(setq package-selected-packages qxg-packages)

(defun qxg-packages-installed-p ()
  "check qxg packages installed"
  (loop for pkg in qxg-packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (qxg-packages-installed-p)
  (message "%s" "refresh")
  (package-refresh-contents)
  (dolist (pkg qxg-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

; 与require的名字对应
(provide 'init-packages)
