;;快速打开配置绑定到F2
(global-set-key (kbd "<f2>") 'open-init-file)
;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; windmove set
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)

;; set C-x C-f to find-file-other-window
(global-set-key (kbd "C-x C-f") 'find-file-other-window)
(global-set-key (kbd "C-c C-o") 'company-files)

;; set minor mode to override source key
(defvar my-keys-minor-mode-map (make-sparse-keymap) "my-keys-minor-mode keymap")
;; evil leader set
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'open-eshell-below-window
  "f" 'find-file-other-window
  "q" 'evil-quit
  "w" 'save-buffer
  "cc" 'evilnc-comment-or-uncomment-lines
  "v" 'split-window-right
  "s" 'split-window-below
  "b" 'ivy-switch-buffer
  "d" 'dired-other-window
  "1" 'delete-other-windows
  "j" 'ace-jump-char-mode)

;; evil neotree
(evil-define-key 'normal my-keys-minor-mode-map (kbd "C-n") 'neotree-toggle)
(evil-define-key 'normal my-keys-minor-mode-map (kbd "RET") 'imenu-list-smart-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal go-mode-map (kbd "gd") 'godef-jump-other-window)
(evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
(define-minor-mode my-keys-minor-mode "minor mode of key-binding" :init-value t :lighter "")
(my-keys-minor-mode 1)
;; 设置company C-n 选择
(with-eval-after-load 'company
  (setq company-show-numbers nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(provide 'init-key)
;;; init-key.el ends here
