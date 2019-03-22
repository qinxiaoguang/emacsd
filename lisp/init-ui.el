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
;; 启动不出现闪屏
(setq inhibit-startup-message t)
;; 关闭缩进
;; (electric-indent-mode -1)

(column-number-mode t) ;状态栏显示行列信息
(show-paren-mode t) ;括号匹配高亮

;; 启动monokai主题
(load-theme 'monokai 1)
;; (load-theme 'atom-one-dark t)

;; ==========================  mode-line 美化 start ==============================
;; mode-line 右侧填充
(defun mode-line-fill (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to
                                (- (+ right right-fringe right-margin) ,reserve)))
              'face face))

(defun get-point-string()
  "return point string"
  (int-to-string (point)))

(setq-default mode-line-format
              (list
               '(:eval evil-mode-line-tag)
               '(:eval (propertize "⮀" 'face (cond ((evil-normal-state-p) '(:background "#6927ff" :foreground "#afd700" :weight bold))
                                                   ((evil-emacs-state-p) '(:background "#6927ff" :foreground "#afd700" :weight bold))
                                                   ((evil-insert-state-p) '(:background "#6927ff" :foreground "#ffffff" :weight bold))
                                                   ((evil-motion-state-p) '(:background "#6927ff" :foreground "#afd700" :weight bold))
                                                   ((evil-visual-state-p) '(:background "#6927ff" :foreground "#ef8606" :weight bold))
                                                   ((evil-operator-state-p) '(:background "#6927ff" :foreground "#ff2600" :weight bold)))))
               '(:propertize " %p/%I " face (:background "#6927ff" :foreground "#ffffff"))
               '(:eval (propertize "⮀" 'face (if (buffer-modified-p) '(:background "#d33682" :foreground "#6927ff" :weight bold)
                                                  '(:background "#268bd2" :foreground "#6927ff" :weight normal))))
               '(:eval (propertize " %b " 'face (if (buffer-modified-p) '(:background "#d33682" :foreground "#fdf6e3" :weight bold)
                                                  '(:background "#268bd2" :foreground "#fdf6e3" :weight normal))))
               '(:eval (propertize "⮀" 'face (if (buffer-modified-p) '(:background "#f7de1c" :foreground "#d33682" :weight bold)
                                                  '(:background "#f7de1c" :foreground "#268bd2" :weight normal))))
               '(:eval (propertize (concat "" vc-mode " " ) 'face '(:inherit font-lock-keyword-face :weight bold :background "#f7de1c")))
               '(:propertize "⮀" face (:background "#585858" :foreground "#f7de1c"))
               '(:propertize " [%m] " face (:weight bold :background "#585858" :foreground "#d7d75f"))
               '(:propertize "⮀" face (:background "#303030" :foreground "#585858"))
               '(:propertize  minor-mode-alist face (:background "#303030" :foreground "#9e9e9e"))
               '(:propertize " ⮁" face (:background "#303030" :foreground "#9e9e9e"))
               (mode-line-fill '(:background "#303030" :foreground "#ffffff") 17)
               '(:propertize "⮂" face (:background "#303030" :foreground "#585858"))
               '(:propertize " (%l,%c) " face (:inherit font-lock-type-face :background "#585858" :foreground "#ffffff"))
               '(:propertize "⮂" face (:background "#585858" :foreground "#d0d0d0"))
               '(:eval (propertize (concat " " (get-point-string) "") 'face '(:inherit font-lock-keyword-face :weight bold :background "#d0d0d0" :foreground "#626262")))
               '(:propertize "%-" face (:background "#d0d0d0" :foreground "#d0d0d0"))
               ))

;; ;;;Move evil tag to beginning of mode line
(setq evil-mode-line-format '(before . mode-line-front-space))
;;; modify evil-state-tag
(setq evil-normal-state-tag   (propertize " NORMAL " 'face '(:background "#afd700" :foreground "#246200" :weight bold))
      evil-emacs-state-tag    (propertize "[EMACS]" 'face '(:background "#afd700" :foreground "#fdf6e3" :weight bold))
      evil-insert-state-tag   (propertize " INSERT " 'face '(:background "#ffffff" :foreground "#265f5f" :weight bold))
      evil-motion-state-tag   (propertize "[MOTION]" 'face '(:background "#afd700" :foreground "#fdf6e3" :weight bold))
      evil-visual-state-tag   (propertize " VISUAL " 'face '(:background "#ef8606" :foreground "#881300" :weight bold))
      evil-operator-state-tag (propertize "[OPERATOR]" 'face '(:background "#ff2600" :foreground "#fdf6e3" :weight bold)))

;; ==========================  mode-line 美化 end ==============================

(provide 'init-ui)
