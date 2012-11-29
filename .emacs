;; (global-set-key "\C-x\C-r" 'find-file-read-only)
;; already defined in ido mode
(global-set-key (kbd "\C-c j") 'flyspell-check-previous-highlighted-word)

(setq frame-title-format (list "Emacs -- %f"))

(set-face-foreground 'font-lock-comment-face "dim gray")
(set-face-foreground 'font-lock-constant-face' "gold")
(set-face-foreground 'font-lock-string-face' "salmon")
(set-face-foreground 'font-lock-keyword-face' "CadetBlue1")

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
   (setq interpreter-mode-alist (cons '("python" . python-mode)
                                      interpreter-mode-alist))
   (autoload 'python-mode "python-mode" "Python editing mode." t)


(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Kills all them buffers except scratch
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
	  (buffer-list))
  (delete-other-windows))

;;saves files as executables if they have a hashbang at the start
(add-hook 'after-save-hook
    'executable-make-buffer-file-executable-if-script-p)


;;ido mode
(require 'ido)
(ido-mode t)
(ido-everywhere 1)

;; highlight brackets
(require 'paren)
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)

(defun google ()
  "Googles a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active
        (buffer-substring (region-beginning) (region-end))
      (read-string "Google: "))))) 


(defun select-next-window ()
  "Switch to the next window" 
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window" 
  (interactive)
  (select-window (previous-window)))

;; this lets you move between frames
(global-set-key (kbd "M-<right>") 'select-next-window)
(global-set-key (kbd "M-<left>")  'select-previous-window)

(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)


(add-to-list 'exec-path "/usr/local/bin/aspell")
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-change-dictionary "british")
(setq ispell-extra-args '("--sug-mode=ultra"))

(require 'package)
;; Marmalade
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
;; The original ELPA archive still has some useful
;; stuff.
;; (add-to-list 'package-archives<br />
;;              '("elpa" . "http://tromey.com/elpa/"))
(package-initialize)

(setq aquamacs-scratch-file nil)