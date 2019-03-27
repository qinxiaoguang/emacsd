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
;; 加载hints信息
(require 'init-hints)
;; 加载键绑定内容
(require 'init-key)
;; 自动生成文件路径
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)
;;; init.el ends here
