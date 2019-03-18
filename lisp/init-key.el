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

;; evil leader set
(evil-leader/set-leader ",")
(evil-leader/set-key
  "f" 'find-file-other-window
  "q" 'evil-quit
  "w" 'save-buffer
  "cc" 'evilnc-comment-or-uncomment-lines
  "v" 'split-window-below
  "s" 'split-window-right
  "RET" 'imenu-list-smart-toggle
  "n" 'neotree-toggle
  "b" 'ivy-switch-buffer
  "j" 'ace-jump-char-mode)
;; evil neotree
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

;; 设置company C-n 选择
(with-eval-after-load 'company
  (setq company-show-numbers nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(provide 'init-key)
;;; init-key.el ends here
