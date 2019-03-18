;;; 快速打开配置
;; (defun open-init-file()
  ;; "open init file quickly"
  ;; (interactive)
  ;; (find-file "~/.emacs.d/init.el"))

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

(autoload 'smex "smex" t)
(smex-initialize)

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

;; ivy fuzzy match
(with-eval-after-load 'ivy
  (push (cons #'swiper (cdr (assq t ivy-re-builders-alist)))
        ivy-re-builders-alist)
  (push (cons t #'ivy--regex-fuzzy) ivy-re-builders-alist))

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
(setq-default mode-line-format (list '(:propertize " %l " face (:weight bold))
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

;; 自动补全路径
(setq company-backends '(company-files))

;; 设置默认补全长度
(setq company-minimum-prefix-length 1)
;; company延长时间
(setq company-idle-delay 0.1)

;; go-mode
;;(require 'go-mode-autoloads)
;; go fmt before save
(require 'go-mode)
(require 'go-eldoc)
(require 'company-go)
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook
      (lambda ()
        (set (make-local-variable 'company-backends) '(company-go))
        (company-mode)))

;; org setting
(setq org-startup-indented t) ;;设置org显示方式


(provide 'init-config)
;;; init-config.el ends here