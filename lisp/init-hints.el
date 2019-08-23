(defun hints-show (hints)
  "show hints"
  (interactive)
  (setq maphints (mapcar
    (lambda(x)
      (if (stringp x)
        (format (propertize (concat "================== " x " ==================\n") 'face '(:foreground "#f6d705")))
      (format (concat "[%s] → %s" (car (nthcdr 2 x))) (propertize (car x) 'face '(:foreground "#ed6c67")) (car (cdr x)) x))
      ) hints))
   (setq result "")
   (dolist (n maphints) (setq result (concat result n)))
   (message result)
  )

;; org mode tips
(defun hints-org()
  "org 的相关提示"
   (interactive)
   (setq hints ["TAB相关"
                ("TAB" "展开层级" "\t") ("S-TAB" "全展开" "\n")
                "表格"
                ("C-c |" "创建表格" "\t") ("| TAB" "插入模式，创建表格" "\t") ("M-↑" "移动表格" "\t") ("M-S-↑" "插入表格" "\n")
                ("C-cc" "表格自动对齐" "\t") ("S-TAB/RET" "表格方向跳转" "\t") ("C-c -" "当前行下边插入新的表格分隔符" "\n")
                ("C-c ^" "对表格进行排序" "\n")
                "TAG及状态"
                ("C-ct" "TODO DONE nil等状态转换" "\n")
                ("C-cq" "为标题添加标签" "\n")
                ("C-ck" "显示所有子树标题" "\n")
                ("C-cx o" "打开/关闭事项ORDERED属性" "\n")
                ("C-c ," "设置当前事项优先级" "\n")
                ("S-↑" "提升/降低当前任务优先级" "\n")
                ("[/]/[百分号]" "标题后增加该符号，可显示进度" "\n")
                "移动"
                ("C-cn/p" "下/上一个标题" "\t") ("C-cf/b" "同级的下/上一级标题" "\t") ("C-cu" "回到上一级标题" "\n")
                "编辑"
                ("M-RET" "同级增加新标题" "\t") ("TAB" "*后标题级别切换" "\t") ("C-c ^" "同级标题排序" "\n")
                ("C-c *" "把正文转换为标题" "\n")
                "时间及规划"
                ("C-c ." "插入时间戳" "\t")
                ("S-up/down" "更改光标所在的部分" "\t")
                ("S-left/right" "光标时间+/-1day" "\n")
                ("C-cd" "插入deadline" "\n")
                ("C-cs" "插入scheduled 在时间的后边加上 +1m即表示每月重复一次，再-3d表示deadline" "\n")
                "显示"
                ("C-c /" "根据输入，显示特定的树内容" "\n")
                ("C-c / r" "输入正则，显示匹配的树" "\n")
                ("C-c / m" "生成带标签的树" "\n")
                ("C-c / t" "展示所有Todo事项" "\n")
                ("C-c / d" "展示已/快超期的任务列表" "\t")
                ("C-c / b" "展示before-date的任务列表" "\t")
                ("C-c / a" "展示after-date的任务列表" "\n")
                "字体"
                ("*bold*" "粗体" "\t") ("/italic/" "斜体" "\t") ("_underline_" "下划线" "\n")
                ("=code=" "代码体" "\t") ("~verbatime~" "unknown" "\t") ("+strike-through+" "unknown" "\n")
                "其他"
                ("[fn:n]" "脚注" "\t") ("S-TAB" "全展开" "\t") ("[[link][content]]" "插入链接" "\t") ("[[file:~/path]]" "插入图片" "\n")
                ])
   (hints-show hints))

(provide 'init-hints)
;;; init-hints.el ends here
