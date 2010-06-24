(setq inferior-lisp-program "sbcl") 
(add-to-list 'load-path "~/lisp/slime/") 
(add-to-list 'load-path "~/")
(add-to-list 'load-path "/home/desktop/php-mode-1.5.0")
(add-to-list 'load-path "/home/desktop/scalamode")

(require 'scala-mode-auto)


(require 'php-mode)
;; To use abbrev-mode, add lines like this:
(add-hook 'php-mode-hook
'(lambda () (define-abbrev php-mode-abbrev-table "ex" "extends")))

(defun phplint-thisfile ()
(interactive)
(save-buffer)
(compile (format "php -l %s" (buffer-file-name))))
(add-hook 'php-mode-hook
'(lambda ()
(local-set-key (local-set-key (kbd "\C-c\C-c") 'phplint-thisfile))))
;; end of php lint


(require 'slime)
(require 'quack)

(require 'uniquify)


;;(slime-setup '(slime-fancy slime-asdf))


(defun collapse-compilation-window (buffer)
  "Shrink the window if the process finished successfully."
  (let ((compilation-window-height 5))
    (compilation-set-window-height (get-buffer-window buffer 0))))

(add-hook 'compilation-finish-functions
          (lambda (buf str)
            (if (string-match "exited abnormally" str)
;               (next-error)
              ;;no errors, make the compilation window go away in a few seconds
              ;(run-at-time "2 sec" nil 'delete-windows-on (get-buffer-create "*compilation*"))
              (collapse-compilation-window buf)
              (message "No Compilation Errors!")
              )
            ))

;(add-hook 'compilation-finish-functions 'my-compilation-finish-function)



(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(toggle-fullscreen)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(global-set-key "\C-j" 'slime-eval-buffer)

 (load "~/haskell-mode/haskell-site-file")

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(setq haskell-program-name "ghci")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(quack-default-program "gsi")
 '(quack-programs (quote ("/home/desktop/plt/bin/mzscheme" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -il r6rs" "mzscheme -il typed-scheme" "mzscheme -M errortrace" "mzscheme3m" "mzschemecgc" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-run-scheme-always-prompts-p nil)
 '(quack-switch-to-scheme-method (quote other-window)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )




   ; (transient-mark-mode 1)  ; Now on by default: makes the region act quite like the text "highlight" in many apps.
   ; (setq shift-select-mode t) ; Now on by default: allows shifted cursor-keys to control the region.
   (setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
   (setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
   (setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection

   ;; these will probably be already set to these values, leave them that way if so!
   ; (setf interprogram-cut-function 'x-select-text)
   ; (setf interprogram-paste-function 'x-cut-buffer-or-selection-value)

   ; You need an emacs with bug #902 fixed for this to work properly. It has now been fixed in CVS HEAD.
   ; it makes "highlight/middlebutton" style (X11 primary selection based) copy-paste work as expected
   ; if you're used to other modern apps (that is to say, the mere act of highlighting doesn't
   ; overwrite the clipboard or alter the kill ring, but you can paste in merely highlighted
   ; text with the mouse if you want to)
   (setq select-active-regions t) ;  active region sets primary X11 selection
   (global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.

   ;; with this, doing an M-y will also affect the X11 clipboard, making emacs act as a sort of clipboard history, at
   ;; least of text you've pasted into it in the first place.
   ; (setq yank-pop-change-selection t)  ; makes rotating the kill ring change the X11 clipboard.

(defun shell-compile ()
  (interactive)
  (save-buffer)
  (shell-command (concat "python " (buffer-file-name)))
  (if (<= (* 2 (window-height)) (frame-height))
      (enlarge-window 5)
    nil))

 (add-hook 'python-mode-hook
           (lambda () (local-set-key (kbd "\C-c\C-c") 'shell-compile)))
 

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")


(add-hook 'find-file-hooks 'assume-new-is-modified)
(defun assume-new-is-modified ()
  (when (not (file-exists-p (buffer-file-name)))
    (set-buffer-modified-p t)))


(defun c-shell-compile ()
  (interactive)
  (save-buffer)
(if (= 0 (shell-command (concat "gcc " (buffer-file-name))))
    (shell-command "./a.out")
(progn
  (if (<= (* 2 (window-height)) (frame-height))
      (enlarge-window 5)
    nil))))



 (add-hook 'c-mode-hook
           (lambda () (local-set-key (kbd "\C-c\C-c") 'c-shell-compile)))


(global-set-key (kbd "\C-c\C-k") 'compile)

(setq compilation-window-height 8)
