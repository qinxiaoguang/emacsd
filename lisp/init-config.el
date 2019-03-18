;;; 快速打开配置
(defun open-init-file()
  "open init file quickly"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;禁止生成自动备份文件
(setq make-backup-files nil)

;; 快速打开最近编辑的软件
;; (autoload 'recentf "recent file mode" t)
;; (recentf-mode 1)
;; (setq recentf-max-menu-item 10)

;; 选中后可直接编辑 并删除
(delete-selection-mode 1)

;; set js mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; 弹出窗口时，自动将光标移动过去
(require  'popwin)
(popwin-mode 1)

;; 将yes-or-no 换为y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; 减少dired模式的缓冲区数目
(put 'dired-find-alternate-file 'disabled nil)

;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

;; 延迟加载
;; (with-eval-after-load 'dired
    ;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; ido mode
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-filename-at-point 'guess)
;; (setq ido-everywhere t)          
;; (ido-mode 1)

(autoload 'smex "smex" t)
(smex-initialize)

;; 启动auto-complete
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (global-auto-complete-mode t)

;; 输入3个字符才开始补全
;; (setq ac-auto-start 2)

;; 设置helm功能
;;(require 'helm-config)

;; 设置ace-jump
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

;; add hook company
(add-hook 'after-init-hook 'global-company-mode)
;; add hook flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)

(autoload 'windmove "windmove" t)

;; 设置flycheck pop显示
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

;; init evil leader
(require 'evil-leader)
(global-evil-leader-mode)

;; evil
(require 'evil)
(evil-mode 1)

;; ivy
(ivy-mode 1)

;; 自动括号
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(electric-pair-mode 1)

;; 关闭自动保存
(setq auto-save-default nil)
;; 不产生备份文件
(setq make-backup-files nil);
(setq backup-inhibited t)
(setq auto-save-list-file-prefix nil)

;; mode-line 美化
(setq-default mode-line-format
              (list '(:propertize " %l " face (:weight bold))
                    'mode-line-mule-info
                    'mode-line-modified
                    'mode-line-remote " "
                    '(:eval (propertize " %b " 'face (if (buffer-modified-p) '(:background "#d33682" :foreground "#fdf6e3" :weight bold)
                                                       '(:background "#268bd2" :foreground "#fdf6e3" :weight normal))))
                    '(:propertize " %p/%I " face (:background "gray60" :foreground "#fdf6e3"))
                    '(:eval (propertize (concat " " (eyebrowse-mode-line-indicator) " ")))
                    '(:eval (propertize (format-time-string "%p·%H:%M ") 'help-echo (format-time-string "%F %a") 'face '(:inherit 'font-lock-doc-face)))
                    '(:propertize vc-mode face (:inherit font-lock-keyword-face :weight bold))
                    " {%m} " "-%-"))

;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; 显示时间
(display-time-mode 1)  
(setq display-time-24hr-format t)  
(setq display-time-day-and-date t)

;; 高亮当前行
(global-hl-line-mode t)

(provide 'init-config)
;;; init-config.el ends here
