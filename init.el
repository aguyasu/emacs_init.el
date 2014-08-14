; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; -----------------------------------
;; @ load-path

;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))


;; load-pathに追加するフォルダ
;; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp" "elpa" "auto-install" )


(require 'package)
; Add package-archives
(package-initialize)
(setq package-archives
      '(("ELPA"      . "http://tromey.com/elpa/")
        ("melpa"     . "http://melpa.milkbox.net/packages/")
        ("gnu"       . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")))
;; ; melpa.el
;; (require 'melpa)



; -----------------------------------
; auto-install
; http://www.emacswiki.org/emacs/download/auto-install.el
; -----------------------------------
(when(require 'auto-install nil t)
  ;;インストールディレクトリを設定。.emacs.d/elispに入れる。
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;;EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;;必要であればプロキシの設定を行う
  ;;(setq url-proxy-services '(("http" . "hogehoge")))
  ;;install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))


; -----------------------------------
; @ language
; -----------------------------------
(setenv "LANG" "ja_JP.UTF-8")
(setenv "LANG" "ja_JP.UTF-8")
(set-language-environment "Japanese")
(setq locale-coding-system 'utf-8)

(set-face-attribute 'default nil
                    :family "ricty"
                    ;; font
                    :height 170
                    ;; font size
                    )

;; 日本語
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; うわっ私のEmacs
(let ((ws window-system))
  (cond ((eq ws 'w32)
         (set-face-attribute 'default nil
                             :family "Meiryo"  ;; 英数
                             :height 100)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo")))  ;; 日本語
        ((eq ws 'ns)
         (set-face-attribute 'default nil
                             :family "Ricty"  ;; 英数
                             :height 140)
         (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Ricty"))))) 


; -----------------------------------
; @ general
; -----------------------------------

;自動セーブを無効化
(setq auto-save-default nil)


;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; タブ幅
(custom-set-variables '(tab-width 4))


;; 最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)

;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; 行間
(setq-default line-spacing 0)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
 ;; shell-mode
(setq comint-scroll-show-maximum-output t)

;;全角スペースとタブを可視化
(setq whitespace-style
      '(tab tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000[?\□])
                    (tab-mark ?\t [?\xBB ?\t])
                     ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; インデントはタブにする
(setq indent-tabs-mode t)

;; インデント幅
(setq c-basic-offset 4)

;; タブ幅
;(custom-set-variables '(tab-width 4))

;; yes or no -> y or n
(fset 'yes-or-no-p' y-or-n-p)

;;最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)

;; 最近使ったファイルの保存数を増やす
(setq recentf-max-saved-items 3000)

;; ミニバッファの履歴を保存する
(savehist-mode 1)

;; ミニバッファの履歴の保存数を増やす
(setq history-length 3000)

;; 行間設定
(setq-default line-spacing 0)

;;file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)
;; バッファー名の問い合わせで大文字小文字の区別をしない
(setq read-buffer-completion-ignore-case t)
;; ファイル名の問い合わせで大文字小文字の区別をしない
(setq read-file-name-completion-ignore-case t)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 4)

;; C-Ret で矩形選択
;; 詳しいキーバインド操作：http://dev.ariel-networks.com/articles/emacs/part5/
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; ファイルのフルパスを表示
(add-hook 'find-file-hooks
          '(lambda ()
              (setq mode-line-buffer-identification 'buffer-file-truename)))

;;C-c C-z押したときにemacsを終了していいか確認をする関数
(defun my-save-buffers-kill-emacs ()
  (interactive)
  (if (y-or-n-p "quit emacs? ")
      (save-buffers-kill-emacs)))
(global-set-key "\C-x\C-z" 'my-save-buffers-kill-emacs)
(global-set-key "\C-x\C-c" 'my-save-buffers-kill-emacs)

;;カラム番号の表示
(column-number-mode t)

;;ファイルサイズを表示
(size-indication-mode t)


;;リージョンないの行数と文字数をモードラインに表示する
(defun count-lines-and-chars()
  (if mark-active
      (format "%d lines,%d chars"
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ;;これだとエコーエリアがちらつく
    ;;(count-lines-region (region-beginning) (region-end))
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))


;; タイトルバーにファイル名表示
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))



;; -----------------------------------
;; @ modeline
;; -----------------------------------

;; モードラインの割合表示を総行数表示
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
        ((eq column-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))


; -----------------------------------
; @ key bind
; -----------------------------------

;; ウィンドウサイズ変更
(define-key global-map (kbd "M-9") 'enlarge-window-horizontally)
(define-key global-map (kbd "M-8") 'shrink-window-horizontally)
(define-key global-map (kbd "M-7") 'enlarge-window)
(define-key global-map (kbd "M-6") 'shrink-window)

;; 指定行へ移動
(define-key global-map (kbd "C-x C-g") 'goto-line)

;; C-hで一文字削除
(define-key global-map (kbd "C-h") 'backward-delete-char-untabify)

;; カーソル位置から行頭まで削除する
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0))
(define-key global-map (kbd "C-u") 'backward-kill-line)

;;折り返し表示ON/OFF
(defun toggle-truncate-lines()
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))

;; 折り返し表示ON/OFF
(define-key global-map (kbd "C-x l") 'toggle-truncate-lines)

;; Undo
(define-key global-map (kbd "C-z") 'undo)

;; Redo
(define-key global-map (kbd "C-/") 'redo)

;; ウィンドウ切り替え
(define-key global-map (kbd "C-t") 'other-window)

;; 改行と同時にインデントする
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; コメントアウトor 解除
(define-key global-map (kbd "M-;") 'comment-or-uncomment-region)
;; BOX型コメント
(define-key global-map (kbd "M-'") 'comment-box)

;; バックスラッシュ
(define-key global-map (kbd "M-¥") "\\")

;;1行スクロール
(define-key global-map (kbd "M-n") '(lambda (arg) (interactive "p") (scroll-up arg)))
(define-key global-map (kbd "M-p") '(lambda (arg) (interactive "p") (scroll-down arg)))

;;置換
(define-key global-map (kbd "C-q") 'query-replace)

;;開き括弧へ移動
(define-key global-map (kbd "C-x C-p") 'backward-list)

;;綴じ括弧へ移動
(define-key global-map (kbd "C-x C-n") 'forward-list)


;; ブロックの折り畳み，展開のトグル
(define-key global-map (kbd "C-x C-l") 'fold-dwim-toggle)
;; ;; ブロックの折り畳み
;; (define-key global-map (kbd "C-x C-n") 'fold-dwim-show-all)
;; ;; ブロックの展開
;; (define-key global-map (kbd "C-x C-n") 'fold-dwim-hide-all)

(require 'cl)


; -----------------------------------
; @ js2-mode.el
; -----------------------------------

;; ;; JavaScriptのメジャーモード
;; ;; https://raw.github.com/mooz/js2-mode/master/js2-mode.el
;; (when (autoload-if-found 'js2-mode "js2-mode" nil t)
;;   (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))


; -----------------------------------
; @ yasnippet
; -----------------------------------
;; yasnippetを置いているフォルダにパスを通す
;; (add-to-list 'load-path
;;              (expand-file-name "~/.emacs.d/elisp/yasnippet"))
(require 'yasnippet)

;; ~/.emacs.d/にsnippetsというフォルダを作っておきましょう
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;; 作成するスニペットはここに入る
        "~/.emacs.d/elisp/yasnippet/snippets" ;; 最初から入っていたスニペット(省略可能)
        ))
(yas-global-mode 1)

;; 単語展開キーバインド (ver8.0から明記しないと機能しない)
;; (setqだとtermなどで干渉問題ありでした)
;; もちろんTAB以外でもOK 例えば "C-;"とか
(custom-set-variables '(yas-trigger-key "TAB"))

;; 既存スニペットを挿入する
(define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;; 既存スニペットを閲覧・編集する
(define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)


; -----------------------------------
; @ helm
; -----------------------------------

(require 'helm-config)
(helm-mode 1)
;; (helm-descbinds-mode)
;; (require 'helm-migemo)
;; (setq helm-use-migemo t)

;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; ミニバッファでC-hをバックスペースに割り当て
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
;; TABで補完
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
;; Command+f で helm-for-files
(define-key global-map (kbd "s-f") 'helm-for-files)
;; C-x b で helm-for-files
(define-key global-map (kbd "C-x b") 'helm-for-files)
;; Command+y で anything-show-kill-ring
(define-key global-map (kbd "s-y") 'helm-show-kill-ring)
;; Command+r で anything-resume
(define-key global-map (kbd "s-r") 'helm-resume)

;; (when (require 'popwin)
;;   (setq helm-samewindow nil)
;;   (setq display-buffer-function 'popwin:display-buffer)
;;   (setq popwin:special-display-config '(("*compilatoin*" :noselect t)
;;                                         ("helm" :regexp t :height 0.4)
;;                                         )))

; -----------------------------------
; @ auto complete
; -----------------------------------
;; (require 'auto-complete)
;; ;; (require 'auto-complete-config)    ; 必須ではないですが一応
;; (global-auto-complete-mode t)

;; ;;; 適用するメジャーモードを足す
;; (add-to-list 'ac-modes 'scss-mode)
;; (add-to-list 'ac-modes 'web-mode)
;; (add-to-list 'ac-modes 'coffee-mode)

;; ;;; ベースとなるソースを指定
;; (defvar my-ac-sources
;;               '(ac-source-yasnippet
;;                 ac-source-abbrev
;;                 ac-source-dictionary
;;                 ac-source-words-in-same-mode-buffers))

;; ;;; 個別にソースを指定
;; (defun ac-scss-mode-setup ()
;;   (setq-default ac-sources (append '(ac-source-css-property) my-ac-sources)))
;; (defun ac-web-mode-setup ()
;;   (setq-default ac-sources my-ac-sources))
;; (defun ac-coffee-mode-setup ()
;;   (setq-default ac-sources my-ac-sources))
;; (add-hook 'scss-mode-hook 'ac-scss-mode-setup)
;; (add-hook 'web-mode-hook 'ac-web-mode-setup)
;; (add-hook 'coffee-mode-hook 'ac-coffee-mode-setup)

;; (global-auto-complete-mode t)

;; ;;; C-n / C-p で選択
;; (setq ac-use-menu-map t)


;; ;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
;; (setf (symbol-function 'yas-active-keys)
;;       (lambda ()
;;         (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))


; -----------------------------------
; @ Frame
; -----------------------------------


;; 起動時にウィンドウ最大化
;; http://www.emacswiki.org/emacs/FullScreen#toc12
;; (defun jbr-init ()
;;   "Called from term-setup-hook after the default
;;    terminal setup is
;;    done or directly from startup if term-setup-hook not
;;    used.  The value
;;    0xF030 is the command for maximizing a window."
;;   (interactive)
;;   (w32-send-sys-command #xf030)
;;   (ecb-redraw-layout)
;;   (calendar))

;; (let ((ws window-system))
;;   (cond ((eq ws 'w32)
;;          (set-frame-position (selected-frame) 0 0)
;;          (setq term-setup-hook 'jbr-init)
;;          (setq window-setup-hook 'jbr-init))
;;         ((eq ws 'ns)
;;          ;; for MacBook Air(Late2010) 11inch display
;;          (set-frame-position (selected-frame) 0 0)
;;          (set-frame-size (selected-frame) 95 47))))

(setq initial-frame-alist
      (append (list
               ;; 表示位置
               '(top . 0)
               '(left . 0)
               ;; サイズ
               '(width . 120)  ;横
               '(height . 34) ;縦
              initial-frame-alist)))
(setq default-frame-alist initial-frame-alist)

; -----------------------------------
; @ color theme
; -----------------------------------

(load-theme 'misterioso t)

(if window-system (progn
                    ;; (set-background-color "#ffffff")
                    ;; (set-background-color "#000000")
                    ;; (set-foreground-color "#0000ee")
                    (set-frame-parameter nil 'alpha 85)
                   ))

; -----------------------------------
; @ magit
; -----------------------------------

(require 'magit)

; -----------------------------------
; @ scroll
; -----------------------------------

(scroll-bar-mode 0)
(tool-bar-mode 0)
;; (menu-bar-mode 0)
(require 'yascroll)
(global-yascroll-bar-mode 1)

;;; smooth-scroll
(require 'smooth-scroll)
(smooth-scroll-mode t)


; -----------------------------------
; @ colum
; -----------------------------------

(require 'linum)

(set-face-attribute 'linum nil
                    :foreground "red"
                    ;; :background "white"
                    ;; :height 0.9
                    )

(global-linum-mode 1)

(require 'hlinum)

;; 前景色を黒，背景色を赤にする．
(custom-set-faces
 '(linum-highlight-face ((t (
                             :foreground "white"
                             :background "red"
                             )))))
(custom-set-variables
 '(global-linum-mode t))



; -----------------------------------
; @ shell pop
; -----------------------------------
;; (require 'shell-pop)
;; ;; multi-term に対応
;; (add-to-list 'shell-pop-internal-mode-list '("multi-term" "*terminal<1>*" '(lambda () (multi-term))))
;; (shell-pop-set-internal-mode "multi-term")
;; ;; 25% の高さに分割する
;; (shell-pop-set-window-height 25)
;; (shell-pop-set-internal-mode-shell shell-file-name)
;; ;; ショートカットも好みで変更してください
;; (global-set-key [f8] 'shell-pop)

; -----------------------------------
; @ volatile highlight
; -----------------------------------
(require 'volatile-highlights)
(volatile-highlights-mode t)


; -----------------------------------
; @ powerline
; -----------------------------------
;; (require 'powerline)
;; (powerline-default-theme)

; -----------------------------------
;Undo-tree
; -----------------------------------
(require 'undo-tree)
(global-undo-tree-mode)
;;undo-treeの視覚化をキーバインド登録
(define-key global-map (kbd "C-x C-u ") 'undo-tree-visualize)

; -----------------------------------
;Move-text
; -----------------------------------
;; (require 'move-text)
;; (move-text-default-bindings)


; -----------------------------------
;multi-term
; -----------------------------------
(require 'multi-term)

; -----------------------------------
; ranbow-delimiters
; -----------------------------------
;; (require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode t)
                                        ;


;-----------------------------------
; @ character code
; -----------------------------------

(set-language-environment 'Japanese)
(set-default-coding-systems 'euc-jp-unix)
(set-terminal-coding-system 'utf-8) ;; *1
(set-keyboard-coding-system
 (if (eq window-system 'mac) 'sjis-mac 'utf-8))
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
;; (require 'utf-8m)
;; (set-file-name-coding-system 'utf-8m) ;; *2


;-----------------------------------
; @ temp
; -----------------------------------

(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)


;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)

(global-set-key (kbd "C-o ") '(lambda ()
                                (interactive)
                                (term shell-file-name)))


;-----------------------------------
; @ tabbar
; -----------------------------------

;; タブ化
;; http://www.emacswiki.org/emacs/tabbar.el
;;(require 'cl)
(require 'tabbar nil t)

;; ;; scratch buffer以外をまとめてタブに表示する
;; (setq tabbar-buffer-groups-function
;;       (lambda (b) (list "All Buffers")))
;; (setq tabbar-buffer-list-function
;;       (lambda ()
;;         (remove-if
;;          (lambda(buffer)
;;            (unless (string-match (buffer-name buffer)
;;                                  "\\(*scratch*\\|*Apropos*\\|*shell*\\|*eshell*\\|*Customize*\\)")
;;              (find (aref (buffer-name buffer) 0) " *"))
;;            )
;;          (buffer-list))))

;; tabbarを有効にする
(tabbar-mode 1)

;; ボタンをシンプルにする
(setq tabbar-home-button-enabled "")
(setq tabbar-scroll-right-button-enabled "")
(setq tabbar-scroll-left-button-enabled "")
(setq tabbar-scroll-right-button-disabled "")
(setq tabbar-scroll-left-button-disabled "")

;; Ctrl-Tab, Ctrl-Shift-Tab でタブを切り替える
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
         ,on-no-prefix
       ,on-prefix)))
(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))
(global-set-key [(control tab)] 'shk-tabbar-next)
(global-set-key [(control shift tab)] 'shk-tabbar-prev)

;; GUIで直接ファイルを開いた場合フレームを作成しない
(add-hook 'before-make-frame-hook
          (lambda ()
            (when (eq tabbar-mode t)
              (switch-to-buffer (buffer-name))
              (delete-this-frame))))


;-----------------------------------
; @ redo+
; -----------------------------------

(when (require 'redo+ nil t)
  (define-key global-map (kbd "M-z") 'redo))


;-----------------------------------
; @ flymake
; -----------------------------------



;-----------------------------------
; @ color
; -----------------------------------

;; ;;カーソルの色の設定
(set-cursor-color "#808080")
(set-cursor-color "#c0c0c0")

;対応する括弧を強調して表示する
(show-paren-mode t)
;表示までの秒数。初期値は0.125
(setq show-paren-delay 0.05)
   ;括弧内も強調
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background "#5e5e5e")
                    ;; :background "#ffc0cb")
(show-paren-mode t)

;;行カーソル
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "dark slate gray"))
    (((class color)
      (background light))
     (:background "#afeeee"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
;; (global-hl-line-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-hl-line-mode t)


;-----------------------------------
; @ fold dwin.el
; -----------------------------------

;; ブロックの折畳みと展開
;; http://www.dur.ac.uk/p.j.heslin/Software/Emacs/Download/fold-dwim.el
(when (require 'fold-dwim nil t)
  (require 'hideshow nil t)
  ;; 機能を利用するメジャーモード一覧
  (let ((hook))
    (dolist (hook
             '(emacs-lisp-mode-hook
               c-mode-common-hook
               python-mode-hook
               php-mode-hook
               ruby-mode-hook
               js2-mode-hook
               css-mode-hook
               apples-mode-hook))
      (add-hook hook 'hs-minor-mode))))

;-----------------------------------
; @ start menu
; -----------------------------------

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;;スタートアップ非表示
(setq inhibit-startup-screen t)


