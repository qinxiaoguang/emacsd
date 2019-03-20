;;; package --- Summary
;;; Commentary:
;;; Code:
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
;; 加载init-packagess
(require 'init-packages)
;; 加载配置信息
(require 'init-config)
;; 加载ui配置
(require 'init-ui)
;; 加载键绑定内容
(require 'init-key)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
