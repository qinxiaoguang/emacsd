(if (display-graphic-p)
    (progn
      ;; 关闭工具栏
      (tool-bar-mode -1)
      ;;关闭文件滑动控件
      (scroll-bar-mode -1)))
(menu-bar-mode 0)
;; 显示行号
(global-linum-mode 1)
(setq linum-format "%3d ")
(set-face-background 'linum "#303030")
(set-face-foreground 'linum "#bcbcbc")
;; 更改光标样式
(setq-default cursor-type 'bar)
;; 关闭启动帮助动画
(setq inhibit-splash-screen 1)
;; 关闭缩进
;; (electric-indent-mode -1)

;; 更改显示字体大小
(set-face-attribute 'default nil :height 160)

;; 启动monokai主题
(load-theme 'monokai 1)

(provide 'init-ui)
