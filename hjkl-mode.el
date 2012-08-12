;;;
;;; hjkl-mode.el
;;;
;;; author: Satoshi Namai
;;;
;;; Time-stamp: <2012-08-12 21:01:29 (namai)>
;;;

(require 'key-chord)

(defun turn-off-hjkl-mode ()
  (interactive)
  (hjkl-mode -1))

(defun turn-on-hjkl-mode ()
  (interactive)
  (hjkl-mode t))

(defun hjkl/delete-line-on-cursor ()
  (interactive)
    (beginning-of-line)
    (kill-line)
    (kill-line))

(defun hjkl/insert-next-line ()
  (interactive)
  (hjkl-mode -1)
  (open-line 1)
  (next-line)
  (beginning-of-line))

(defun hjkl/yank-to-next-line ()
  (interactive)
  (next-line)
  (beginning-of-line)
  (yank)
  (beginning-of-line))

(defun hjkl/set-marker ()
  (interactive)
  (set-marker (make-marker) (point)))

(defun hjkl/undo ()
  (interactive)
  (if (fboundp 'undo-tree-undo)
      (undo-tree-undo)
    (undo))))


(defvar hjkl-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "j") 'next-line)
    (define-key map (kbd "k") 'previous-line)
    (define-key map (kbd "l") 'forward-char)
    (define-key map (kbd "h") 'backward-char)
    (define-key map (kbd "0") 'move-biginning-of-line)
    (define-key map (kbd "$") 'move-end-of-line)
    (define-key map (kbd "g g") 'beginning-of-buffer)
    (define-key map (kbd "G") 'end-of-buffer)
    (define-key map (kbd "i") 'turn-off-hjkl-mode)
    (define-key map (kbd "o") 'hjkl/insert-next-line)
    (define-key map (kbd "d d") 'hjkl/delete-line-on-cursor)
    (define-key map (kbd "y") 'kill-ring-save)
    (define-key map (kbd "x") 'delete-char)
    (define-key map (kdb "d w") 'subword-kill)
    (define-key map (kbd "p") 'yank)
    (define-key map (kbd "P") 'hjkl/yank-to-next-line)
    (define-key map (kbd "v") 'set-mark-command)
    (define-key map (kbd "u") 'hjkl/undo)
    map))

(define-minor-mode hjkl-mode
  "hjkl-mode is a minor-mode. hjkl-mode provide keybind to move cursor by vim-keybinds."
  :lighter " vi" :keymap hjkl-mode-map)

(key-chord-mode 1)
(key-chord-define-global "jk" 'turn-on-hjkl-mode)

(provide 'hjkl-mode)