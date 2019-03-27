;;; 快速打开配置
;; (defun open-init-file()
  ;; "open init file quickly"
  ;; (interactive)
;; (find-file "~/.emacs.d/init.el"))
;; ============================ defun start ===============================
;; 在下边的窗口打开eshell
(defun open-eshell-below-window()
  "open eshell below window"
  (interactive)
  (split-window-below)
  (windmove-down)
  (eshell))

(defun random-true()
  "return random true or false"
  (interactive)
  (if (= (random 2) 0)
      t
    nil))

(golden-ratio-mode 1)
;;godef jump new window
(defun godef-jump-new-window()
  "godef jump to new window"
  (interactive)
  (let ((r (random-true))
       (p (point)))
    (if r
        (progn (split-window-below) (windmove-down))
       (progn (split-window-right) (windmove-right)))
    (godef-jump p))
  (golden-ratio))

;; recentf-open-files-new-window
(defun recentf-open-files-new-window()
  "recentf new window"
  (interactive)
  (split-window-right)
  (windmove-right)
  (recentf-open-files))

;; find-file-new-window
(defun find-file-new-window(filename &optional wildcards)
  "find file to new window"
  (interactive
   (find-file-read-args "Find file in new window: "
                        (confirm-nonexistent-file-or-buffer)))
  (let ((r (random-true))
       (p (point)))
    (if r
        (progn (split-window-below) (windmove-down))
       (progn (split-window-right) (windmove-right)))
    (find-file filename wildcards))
  (golden-ratio))

;; neotree-enter random
(defun neotree-enter-random()
  "find file to new window"
  (interactive)
  (if (random-true)
      (neotree-enter-horizontal-split)
    (neotree-enter-vertical-split))
  (golden-ratio))

;; ============================ defun end  ===============================

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
;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

(autoload 'dired "dired" t)

;; 延迟加载
;; (with-eval-after-load 'dired
    ;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;; (autoload 'smex "smex" t)
;; (smex-initialize)

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
;; (setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
;; (electric-pair-mode 1)
(require 'autopair)
(autopair-global-mode)

;; 关闭自动保存
(setq auto-save-default nil)
;; 不产生备份文件
(setq make-backup-files nil);
(setq backup-inhibited t)
(setq auto-save-list-file-prefix nil)


;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; 显示时间
;; (display-time-mode 1)  
;; (setq display-time-24hr-format t)  
;; (setq display-time-day-and-date t)

;; 高亮当前行
(global-hl-line-mode t)

;; 自动补全路径, 自动代码补全，自动关键字补全等
;; (setq company-backends '(company-files
;;                          company-dabbrev-code
;;                          company-dabbrev
;; ))

;; 设置默认补全长度
(setq company-minimum-prefix-length 1)
;; company延长时间
(setq company-idle-delay 0.1)

;; go-mode
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
(setq org-log-done 'time) ;; 任务完成后自动显示时间戳
;; (setq org-log-done 'note) ;; 任务完成后可显示附加信息
;; 设置优先级显示符号
(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
                           (?B . (:foreground "yellow"))
                           (?C . (:foreground "green"))))
;; 设置capture位置
;; (setq org-default-notes-file "~/.emacs.d/org/capture.org")
;; 设置capture 模板
;; (setq org-capture-templates
;;    '(("l" "灵感" entry (file+headline "~/.emacs.d/org/写作创意.org" "创意")
;;           "* %?\n  %i\n  %a")
;;      ("j" "Journal" entry (file+datetree "~/.emacs.d/org/journal.org")
;;           "* %?\n输入于： %U\n  %i\n  %a")))

;; 子任务完成后，父任务自动标记为完成
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(add-hook 'org-mode-hook 'org-bullets-mode)
;; org语法高亮
(setq org-src-fontify-natively t)
;; 设置org层级显示符号
;; (setq org-bullets-bullet-list '("☰" "☷" "☯" "☭"))
;; "○" "☉" "◎" "◉" "○" "◌" "◎" "●" "◦" "◯" "⚪" "⚫" "⚬" "❍" "￮" "⊙" "⊚" "⊛" "∙" "∘"
;; "◐" "◑" "◒" "◓" "◴" "◵" "◶" "◷" "⚆" "⚇" "⚈" "⚉" "♁" "⊖" "⊗" "⊘"
;; "☀" "♼" "☼" "☾" "☽" "☣" "§" "¶" "‡" "※" "✕" "△" "◇" "▶" "◀" "◈"
;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶   "◉" "○" "✸" "✿"
;; ❥
(setq org-bullets-bullet-list '("❥" "➽" "➤" "☛" "♞" "✒" "♨"))

;; 设置编码格式
(setq default-buffer-file-coding-system 'utf-8-unix)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

;;缩进
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent nil)

;; recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; which key
(require 'which-key)
(which-key-mode)
;; message buffer height
(setq max-mini-window-height 1.00)

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;hungry-delete
(require 'hungry-delete)
(global-hungry-delete-mode)

(provide 'init-config)
;;; init-config.el ends here
