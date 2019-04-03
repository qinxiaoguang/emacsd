;; =======   my defun
(defun split-window-htv ()
  "horizontal to vertical 左右两屏切换为上下"
  (interactive)
  (let ((buf (current-buffer)))
    ;; 选中左侧 window
    (select-window (frame-first-window))
    ;; 删掉右侧 window
    (delete-other-windows)
    (select-window (split-window-below))
    ;; 切换至最近 buffer
    (switch-to-buffer (other-buffer))
    ;; 选中原来 buffer 所在的 window
    (select-window (get-buffer-window buf))))

(defun split-window-vth ()
  "vertical to horizontal"
  (interactive)
  (let ((buf (current-buffer)))
    ;; 选中上侧 window
    (select-window (frame-first-window))
    ;; 删掉下侧 window
    (delete-other-windows)
    ;; 分屏、选中下边 window
    (select-window (split-window-right))
    ;; 切换至最近 buffer
    (switch-to-buffer (other-buffer))
    ;; 选中原来 buffer 所在的 window
    (select-window (get-buffer-window buf))))

(defun random-true()
  "return random true or false"
  (interactive)
  (if (= (random 2) 0)
      t
    nil))

(defun right-or-below()
  "when split, right or below
  nil: right , t :below"
  (interactive)
  (cond
   ((= (count-windows) 1) nil)
   ((= (count-windows) 2) (progn (split-window-vth) t))
   ((>= (count-windows) 3)
    (if (> (window-height) 35) t
      (random-true)))))

;; 在下边的窗口打开eshell
(defun open-eshell-below-window()
  "open eshell below window"
  (interactive)
  (split-window-below)
  (windmove-down)
  (eshell)
  (company-mode -1))
;; =======   my defun

(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package golden-ratio
  :defer 0.3
  :ensure t
  :commands (golden-ratio)
  :config
  (golden-ratio-mode 1))

(use-package js2-mode
  :defer 1
  :ensure t
  :init
  (setq auto-mode-alist
        (append
         '(("\\.js\\'" . js2-mode))
         auto-mode-alist)))

(use-package popwin
  :defer 1
  :ensure t
  :config
  (popwin-mode 1))

(use-package ace-jump-mode
  :defer 1
  :ensure t)

(use-package company
  :defer t
  :ensure t
  :bind (:map company-active-map
              ("C-n" . #'company-select-next)
              ("C-p" . #'company-select-previous))
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-minimum-prefix-length 1)
  (setq company-idle-delay 0.1))

(use-package flycheck
  :defer 1
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))

(use-package flycheck-pos-tip
  :defer 1
  :ensure t
  :after (flycheck)
  :config
  (flycheck-pos-tip-mode))

(use-package dired
  :defer 1
  :config
  ;; 减少dired模式的缓冲区数目
  (put 'dired-find-alternate-file 'disabled nil)
  :config
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(use-package evil
  :defer t
  :ensure t
  :commands (evil-mode evil-define-key)
  :init
  ;;godef jump new window
  (defun godef-jump-new-window()
    "godef jump to new window"
    (interactive)
    (let ((r (right-or-below))
          (p (point)))
      (if r
          (progn (split-window-below) (windmove-down))
        (progn (split-window-right) (windmove-right)))
      (godef-jump p))
    (golden-ratio))
  
  ;; find-file-new-window
  (defun find-file-new-window(filename &optional wildcards)
    "find file to new window"
    (interactive
     (find-file-read-args "Find file in new window: "
                          (confirm-nonexistent-file-or-buffer)))
    (let ((r (right-or-below))
          (p (point)))
      (if r
          (progn (split-window-below) (windmove-down))
        (progn (split-window-right) (windmove-right)))
      (find-file filename wildcards))
    (golden-ratio))
  
  (defun qxg-leader/set-leader (key)
    "设置自己的leader"
    (setq-default qxg-leader key))
  (setq-default qxg-leader "SPC ") ;; 默认设置为 SPC
  (defun qxg-leader/set-key (key def &rest bindings)
    "自定义leader-set-key"
    (while key
      (setq key (concat qxg-leader key))
      (evil-define-key 'normal 'global (kbd key) def)
      (setq key (pop bindings))
      (setq def (pop bindings))))
  :bind
  (("C-s" . swiper)
   ("C-u" . evil-scroll-up))
  :config
  (evil-mode 1)
  (evil-define-key 'normal go-mode-map (kbd "gd") 'godef-jump-new-window)
  (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
  (evil-define-key 'normal org-mode-map (kbd "M-h") 'windmove-left)
  ;; (evil-define-key 'normal 'global (kbd "SPC f") 'find-function)
  (qxg-leader/set-key
   "f" 'find-function
   ;;  ===  b buffer setting
   "bk" 'previous-buffer
   "bj" 'next-buffer))

(use-package evil-nerd-commenter
  :defer 1
  :ensure t)

(use-package imenu-list
  :defer 1
  :ensure t)

(use-package evil-leader
  :ensure t
  :init
  ;; 全局自动缩进
  (defun indent-buffer()
    "buffer indent"
    (interactive)
    (indent-region (point-min) (point-max)))
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader ",")
  (evil-leader/set-key
    "ee" 'open-eshell-below-window
    "f" 'find-file-new-window
    "q" 'evil-quit
    "w" 'save-buffer
    "x" 'evil-save-and-quit
    "cc" 'evilnc-comment-or-uncomment-lines
    "s" 'split-window-below
    ;; === h prefix : hydra, hints ===
    "hw" 'hydra-window/body
    "ho" 'hints-org
    "hv" 'hydra-visual/body
    ;; === y prefix : yasnippet ===
    "yn" 'yas-new-snippet ;;创建yas
    "yd" 'yas-describe-tables ;; 显示当前的yas
    "yc" 'ivy-yasnippet
    ;; === i prefix : indent ===
    "ir" 'indent-region
    "ib" 'indent-buffer
    ;; === o prefix : org ===
    "os" 'org-sort-entries
    "oc" 'org-capture
    "oa" 'org-agenda
    ;;=== v prefix : visual,vertical ===
    "ve" 'er/expand-region
    "vc" 'er/contract-region
    "vs" 'split-window-right
    "vh" 'split-window-vth
    ;; === h prefix : horizontal ===
    "hv" 'split-window-htv
    ;; === m prefix : multiedit ===
    "mm" 'evil-multiedit-toggle-marker-here
    "ma" 'evil-multiedit-match-all
    "mn" 'evil-multiedit-match-and-next
    "mwn" 'evil-multiedit-match-symbol-and-next
    "b" 'ivy-switch-buffer
    "d" 'dired-other-window
    "1" 'delete-other-windows
    ;; === g prefix : git,golden ===
    "gg" 'magit
    "go" 'golden-ratio
    "p" 'previous-buffer
    "r" 'recentf-open-files-new-window
    "RET" 'imenu-list-smart-toggle
    ",j" 'ace-jump-line-mode
    "j" 'ace-jump-char-mode))

(use-package ivy
  :defer 1
  :ensure t
  :config
  (ivy-mode 1)
  (push (cons #'swiper (cdr (assq t ivy-re-builders-alist)))
        ivy-re-builders-alist)
  (push (cons t #'ivy--regex-fuzzy) ivy-re-builders-alist))

(use-package autopair
  :ensure t
  :config
  (autopair-global-mode))

(use-package go-mode
  :defer 1
  :ensure t
  :init
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package go-eldoc
  :defer 1
  :ensure t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package company-go
  :defer 1
  :ensure t
  :init
  (add-hook 'go-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '((company-go company-dabbrev-code)))
              (company-mode))))

(use-package org
  :defer 1
  :ensure t
  :init
  ;; org setting
  (setq org-startup-indented t) ;;设置org显示方式
  (setq org-log-done 'time) ;; 任务完成后自动显示时间戳
  ;; 设置优先级显示符号
  (setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
                             (?B . (:foreground "yellow"))
                             (?C . (:foreground "green"))))
  ;; 子任务完成后，父任务自动标记为完成
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  (add-hook 'org-mode-hook 'org-bullets-mode)
  ;; org code语法高亮
  (setq org-src-fontify-natively t)
  (setq org-bullets-bullet-list '("❥" "➽" "➤" "☛" "♞" "✒" "♨"))
  (setq org-agenda-files (list "~/.emacs.d/org"))
  ;; Org capture
  (setq org-capture-templates
        '(
          ("w" "Work" entry
           (file+headline "~/.emacs.d/org/work.org" "Work")
           "* TODO %^{任务}\nDEADLINE: %^t\nCreateAt: %u\n")
          ("s" "study" entry
           (file+headline "~/.emacs.d/org/study.org" "Study")
           "* TODO %^{描述}\n CreateAt: %u\n")
          ("f" "film" entry
           (file+headline "~/.emacs.d/org/file,.org" "Film")
           "* TODO %^{电影名}\n CreateAt: %u\n")
          ("l" "life 加班记录" entry
           (file+olp "~/.emacs.d/org/life.org" "Life" "加班记录")
           "* %u 未加班\n")
          ("t" "心得" entry
           (file+olp "~/.emacs.d/org/think.org" "心得")
           "* %^{心得}\n CreateAt: %u\n")
          ("c" "创意" entry
           (file+olp "~/.emacs.d/org/creature.org" "创意")
           "* %^{创意}\n CreateAt: %u\n")
          ))
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
  ;; org todo颜色
  (setf org-todo-keyword-faces '(("TODO" . (:foreground "#ffde7d"  :weight bold))
                                 ("WAIT" . (:foreground "#ff2600"   :weight bold))
                                 ("CANCELED" . (:foreground "#00b8a9"  :weight bold))
                                 ("DONE" . (:foreground "#268bd2"  :weight bold)))))

(use-package org-bullets
  :after (org)
  :ensure t)

(use-package recentf
  :defer 0.5
  :ensure t
  :init
  (setq recentf-auto-cleanup 'never)
  ;; recentf-open-files-new-window
  (defun recentf-open-files-new-window()
    "recentf new window"
    (interactive)
    (split-window-right)
    (windmove-right)
    (recentf-open-files))
  :bind (:map recentf-dialog-mode-map
              ("q" . #'delete-window))
  :config
  (recentf-mode 1))

(use-package which-key
  :defer 0.5
  :ensure t
  :config
  (which-key-mode))

(use-package yasnippet
  :defer 1
  :ensure t
  :config
  (use-package ivy-yasnippet :ensure t)
  (yas-global-mode 1))

(use-package hungry-delete
  :defer 1
  :ensure t
  :config
  (global-hungry-delete-mode))


(use-package evil-surround
  :defer 1
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package window-numbering
  :defer 1
  :ensure t
  :init
  (define-advice select-window-by-number (:around (orig-fun num &rest r) golden)
    (apply orig-fun num r)
    (golden-ratio))
  :bind(
        ("M-k" . windmove-up)
        ("M-j" . windmove-down)
        ("M-h" . windmove-left)
        ("M-l" . windmove-right)
        )
  :config
  (window-numbering-mode 1))

(use-package counsel
  :defer 0.2
  :ensure t
  :bind
  ("M-x" . counsel-M-x))

(use-package hydra
  :defer 1
  :ensure t
  :after dired
  :init
  (defhydra hydra-dired (:hint nil :color pink)
    "
  _+_ mkdir          _v_iew           _m_ark             _(_ details        _i_nsert-subdir    wdired
  _C_opy             _O_ view other   _U_nmark all       _)_ omit-mode      _$_ hide-subdir    C-x C-q : edit
  _D_elete           _o_pen other     _u_nmark           _l_ redisplay      _w_ kill-subdir    C-c C-c : commit
  _R_ename           _M_ chmod        _t_oggle           _g_ revert buf     _e_ ediff          C-c ESC : abort
  _Y_ rel symlink    _G_ chgrp        _E_xtension mark   _s_ort             _=_ pdiff
  _S_ymlink          ^ ^              _F_ind marked      _._ toggle hydra   \\ flyspell
  _r_sync            ^ ^              ^ ^                ^ ^                _?_ summary
  _z_ compress-file  _A_ find regexp
  _Z_ compress       _Q_ repl regexp

  T - tag prefix
  "
    ("\\" dired-do-ispell)
    ("(" dired-hide-details-mode)
    (")" dired-omit-mode)
    ("+" dired-create-directory)
    ("=" diredp-ediff)         ;; smart diff
    ("?" dired-summary)
    ("$" diredp-hide-subdir-nomove)
    ("A" dired-do-find-regexp)
    ("C" dired-do-copy)        ;; Copy all marked files
    ("D" dired-do-delete)
    ("E" dired-mark-extension)
    ("e" dired-ediff-files)
    ("F" dired-do-find-marked-files)
    ("G" dired-do-chgrp)
    ("g" revert-buffer)        ;; read all directories again (refresh)
    ("i" dired-maybe-insert-subdir)
    ("l" dired-do-redisplay)   ;; relist the marked or singel directory
    ("M" dired-do-chmod)
    ("m" dired-mark)
    ("O" dired-display-file)
    ("o" dired-find-file-other-window)
    ("Q" dired-do-find-regexp-and-replace)
    ("R" dired-do-rename)
    ("r" dired-do-rsynch)
    ("S" dired-do-symlink)
    ("s" dired-sort-toggle-or-edit)
    ("t" dired-toggle-marks)
    ("U" dired-unmark-all-marks)
    ("u" dired-unmark)
    ("v" dired-view-file)      ;; q to exit, s to search, = gets line #
    ("w" dired-kill-subdir)
    ("Y" dired-do-relsymlink)
    ("z" diredp-compress-this-file)
    ("Z" dired-do-compress)
    ("q" nil)
    ("." nil :color blue))
  :bind (:map dired-mode-map ("." . hydra-dired/body)))

(use-package expand-region
  :defer 1
  :ensure t)

(use-package linum
  :defer t
  :commands (global-linum-mode)
  :config
  (global-linum-mode 1)
  (setq linum-format "%3d ")
  (set-face-background 'linum "#303030")
  (set-face-foreground 'linum "#bcbcbc"))

(use-package monokai-theme
  :ensure t
  :init
  ;; ==========================  mode-line 美化 start ==============================
  ;; mode-line 右侧填充
  (use-package window-numbering)
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
  ;; 显示窗格号
  (defun spaceline--unicode-number (str)
    "Return a nice unicode representation of a single-digit number STR."
    (cond
     ((string= "1" str) " 1 ")
     ((string= "2" str) " 2 ")
     ((string= "3" str) " 3 ")
     ((string= "4" str) " 4 ")
     ((string= "5" str) " 5 ")
     ((string= "6" str) " 6 ")
     ((string= "7" str) " 7 ")
     ((string= "8" str) " 8 ")
     ((string= "9" str) " 9 ")
     ((string= "0" str) " 10 ")))
  (defun window-number-mode-line ()
    "The current window number. Requires `window-numbering-mode' to be enabled."
    (when (bound-and-true-p window-numbering-mode)
      (let* ((num (window-numbering-get-number))
             (str (when num (int-to-string num))))
        (spaceline--unicode-number str))))
  :config
  (load-theme 'monokai 1)
  (setq-default mode-line-format
                (list
                 '(:eval (propertize (window-number-mode-line) 'face '(:inherit font-lock-keyword-face :weight bold :background "#1c1c1c" :foreground "#f7de1c")))
                 '(:eval (propertize "⮀" 'face (cond ((evil-normal-state-p) '(:foreground "#1c1c1c" :background "#afd700" :weight bold))
                                                     ((evil-emacs-state-p) '(:foreground "#1c1c1c" :background "#afd700" :weight bold))
                                                     ((evil-insert-state-p) '(:foreground "#1c1c1c" :background "#ffffff" :weight bold))
                                                     ((evil-motion-state-p) '(:foreground "#1c1c1c" :background "#afd700" :weight bold))
                                                     ((evil-visual-state-p) '(:foreground "#1c1c1c" :background "#ef8606" :weight bold))
                                                     ((evil-operator-state-p) '(:foreground "#1c1c1c" :background "#ff2600" :weight bold)))))

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
        evil-operator-state-tag (propertize " OPERATOR " 'face '(:background "#ff2600" :foreground "#fdf6e3" :weight bold)))

  ;; select region color
  (set-face-attribute 'region nil :background "#ffd700" :foreground "#000000")
  ;; lazy highlight
  (set-face-attribute 'lazy-highlight nil :background "#ffc15e" :foreground "#000000"))

(use-package hlinum
  :ensure t
  :init
  ;; 当前行号颜色
  (global-hl-line-mode t)
  (defface linum-highlight-face
    '((t (:inherit default :foreground "#f7de1c"
                   :background "#232222" :weight bold)))
    "Face for highlighting current line"
    :group 'linum)
  :config
  (hlinum-activate)
  (set-face-background hl-line-face "#232222"))

(use-package paren
  :defer t
  :commands (show-paren-function show-paren-mode)
  :init
  ;; color
  (custom-set-faces
   '(show-paren-match ((t (:background "#000000" :foreground "#ff8700" :weight normal)))))
  :config
  (show-paren-mode))

(use-package json-mode
  :ensure t
  :defer 1)

(use-package smex
  :ensure t)

(use-package evil-multiedit
  :ensure t
  :defer 1
  :init
  (defun turn-off-hungry-delete-mode()
    (interactive)
    (hungry-delete-mode -1))
  (add-hook 'evil-multiedit-state-entry-hook 'turn-off-hungry-delete-mode)
  (add-hook 'evil-multiedit-insert-state-entry-hook 'turn-off-hungry-delete-mode)
  (add-hook 'evil-multiedit-state-exit-hook 'hungry-delete-mode)
  (add-hook 'evil-multiedit-state-exit-hook 'hungry-delete-mode))

(use-package magit
  :defer 1
  :ensure t)

(use-package evil-magit
  :defer 1
  :ensure t
  :init
  (setq evil-magit-state 'normal)
  (setq evil-magit-use-y-for-yank t))

(use-package anaconda-mode
  :defer 1
  :ensure
  :config
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package company-anaconda
  :defer 1
  :ensure
  :config
  (add-hook 'python-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '(company-anaconda))
              (company-mode))))

(provide 'init-packages)
