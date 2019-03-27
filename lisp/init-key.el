;;快速打开配置绑定到F2

(global-set-key (kbd "M-x") 'counsel-M-x)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; windmove set
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)

;; set minor mode to override source key
(defvar my-keys-minor-mode-map (make-sparse-keymap) "my-keys-minor-mode keymap")

;; evil neotree
(evil-define-key 'normal my-keys-minor-mode-map (kbd "C-n") 'neotree-toggle)
(evil-define-key 'normal my-keys-minor-mode-map (kbd "C-u") 'evil-scroll-up)
(evil-define-key 'normal my-keys-minor-mode-map (kbd "C-s") 'swiper)
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter-random)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal go-mode-map (kbd "gd") 'godef-jump-new-window)
(evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
(define-minor-mode my-keys-minor-mode "minor mode of key-binding" :init-value t :lighter "")
(define-key my-keys-minor-mode-map (kbd "C-s") 'swiper)
(my-keys-minor-mode 1)
;; 设置company C-n 选择
(with-eval-after-load 'company
  (setq company-show-numbers nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; 设置recentf dialog q为退出
(with-eval-after-load 'recentf
  (define-key recentf-dialog-mode-map (kbd "q") #'delete-window))

;; hydra key
(with-eval-after-load 'dired
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
 (define-key dired-mode-map "." 'hydra-dired/body))

;;; hydra window move
(defhydra hydra-window ()
   "
Movement^^        ^Split^         ^Switch^		^Resize^
----------------------------------------------------------------
^_h_ ←       	_v_ertical    	_b_uffer		_q_ X←
_j_ ↓        	_x_ horizontal	_f_ind files	_w_ X↓
_k_ ↑        	_z_ undo      	_a_ce 1		_e_ X↑
_l_ →        	_Z_ reset      	_s_wap		_r_ X→
_F_ollow		_D_lt Other   	_S_ave		max_i_mize
_SPC_ cancel	_o_nly this   	_d_elete	
"
   ("h" windmove-left )
   ("j" windmove-down )
   ("k" windmove-up )
   ("l" windmove-right )
   ("q" hydra-move-splitter-left)
   ("w" hydra-move-splitter-down)
   ("e" hydra-move-splitter-up)
   ("r" hydra-move-splitter-right)
   ("b" helm-mini)
   ("f" helm-find-files)
   ("F" follow-mode)
   ("a" (lambda ()
          (interactive)
          (ace-window 1)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body))
       )
   ("v" (lambda ()
          (interactive)
          (split-window-right)
          (windmove-right))
       )
   ("x" (lambda ()
          (interactive)
          (split-window-below)
          (windmove-down))
       )
   ("s" (lambda ()
          (interactive)
          (ace-window 4)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body)))
   ("S" save-buffer)
   ("d" delete-window)
   ("D" (lambda ()
          (interactive)
          (ace-window 16)
          (add-hook 'ace-window-end-once-hook
                    'hydra-window/body))
       )
   ("o" delete-other-windows)
   ("i" ace-maximize-window)
   ("z" (progn
          (winner-undo)
          (setq this-command 'winner-undo))
   )
   ("Z" winner-redo)
   ("SPC" nil)
   )

;; evil leader set
(evil-leader/set-leader ",")
(evil-leader/set-key
  "e" 'open-eshell-below-window
  "f" 'find-file-new-window
  "q" 'evil-quit
  "w" 'save-buffer
  "x" 'evil-save-and-quit
  "cc" 'evilnc-comment-or-uncomment-lines
  "v" 'split-window-right
  "s" 'split-window-below
  ;; ================ h prefix hydra or hint set start ==============
  "hw" 'hydra-window/body
  "ho" 'hints-org
  ;; ================ h prefix hydra or hint set end ==============
  ;; ================ y prefix yasnippet set start ==============
  "yn" 'yas-new-snippet ;;创建yas
  "yd" 'yas-describe-tables ;; 显示当前的yas
  "yc" 'ivy-yasnippet
  ;; ================ y prefix yasnippet set end ==============
  "b" 'ivy-switch-buffer
  "d" 'dired-other-window
  "1" 'delete-other-windows
  "go" 'golden-ratio
  "p" 'previous-buffer
  "r" 'recentf-open-files-new-window
  "RET" 'imenu-list-smart-toggle
  "j" 'ace-jump-char-mode)


(provide 'init-key)
;;; init-key.el ends here
