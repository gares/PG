;; proof-maths-menu.el   Support for maths menu mode package
;;
;; Copyright (C) 2007 LFCS Edinburgh / David Aspinall
;; Author:    David Aspinall <David.Aspinall@ed.ac.uk>
;; License:   GPL (GNU GENERAL PUBLIC LICENSE)
;;
;;
;; With thanks to Dave Love for the original maths menu code,
;; provided at http://www.loveshack.ukfsn.org/emacs/
;;
;; $Id$
;;
;; =================================================================
;;
;; NB: maths-menu is bundled with Proof General in lib/, and PG will select
;; it's own version before any other version on the Emacs load path.
;; If you want to override this, simply load your version before
;; starting Emacs, with (require 'maths-menu).
;;

(eval-when-compile
  (require 'proof-utils) ; for proof-ass, proof-eval-when-ready-for-assistant
  (require 'cl))

(eval-when (compile)
  (require 'maths-menu)) ; it's loaded dynamically at runtime


;;;###autoload
(defun proof-maths-menu-set-global (flag)
  "Set global status of maths-menu mode for PG buffers to be FLAG.
Turn on/off menu in all script buffers and ensure new buffers follow suit."
  (let ((hook (proof-ass-sym mode-hook)))
    (if flag
	(add-hook hook 'maths-menu-mode)
      (remove-hook hook 'maths-menu-mode))
    (proof-map-buffers 
      (proof-buffers-in-mode proof-mode-for-script)
      (maths-menu-mode (if flag 1 0)))))

  
  
;;;###autoload
(defun proof-maths-menu-enable ()
  "Turn on or off maths-menu mode in Proof General script buffer.
This invokes `maths-menu-mode' to toggle the setting for the current
buffer, and then sets PG's option for default to match.
Also we arrange to have maths menu mode turn itself on automatically 
in future if we have just activated it for this buffer."
  (interactive)
  (if (proof-maths-menu-support-available) ;; will load maths-menu-mode
      (proof-maths-menu-set-global (not maths-menu-mode))))

(provide 'proof-maths-menu)
;; End of proof-maths-menu.el
