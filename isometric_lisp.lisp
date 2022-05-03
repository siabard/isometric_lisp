;;;; isometric_lisp.lisp

(in-package #:isometric-lisp)

;; TODO making game system

(defun update (dt)
  "do system change with dt"
  dt ;; not yet determined
  )

;; KEY related function
;; TODO: should refactoring to class or struct

(defvar *pressed-key* (make-hash-table :test #'equal))
(defvar *released-key* (make-hash-table :test #'equal))
(defvar *held-keys* (make-hash-table :test #'equal))


(defun clear-keys ()
  (clrhash *pressed-key*)
  (clrhash *released-key*))

(defun keyup-event (scancode)
  (setf (gethash scancode *released-key*) t)
  (setf (gethash scancode *held-keys*) nil))

(defun keydown-event (scancode)
  (setf (gethash scancode *pressed-key*) t)
  (setf (gethash scancode *held-keys*) t))

(defun key-pressed-p (scancode)
  (gethash scancode *pressed-key* nil))

(defun key-released-p (scancode)
  (gethash scancode *released-key* nil))

(defun key-held-p (scancode)
  (gethash scancode *held-keys* nil))

;; //END OF KEY related function

(defun draw (renderer)
  (sdl2:set-render-draw-color renderer 155 155 155 255)
  (sdl2:render-clear renderer)
  (sdl2:render-present renderer))

(defun main ()
  (sdl2:with-init (:everything)
    (let ((previous-ticks (sdl2:get-ticks)))
      (sdl2:with-window (win :title "Isometric" :flags '(:shown))
	(sdl2:with-renderer (renderer win :flags '(:accelerated :targettexture :presentvsync))
	  (sdl2-image:init '(:jpg :png))
	  (sdl2:with-event-loop (:method :poll)
	    (:keyup (:keysym keysym)
		    (keyup-event (sdl2:scancode-value keysym)))
	    (:keydown (:keysym keysym)
		      (keydown-event (sdl2:scancode-value keysym)))
	    (:idle ()
		   (if (key-pressed-p (sdl2:scancode-key-to-value :scancode-escape))
		       (sdl2:push-event :quit)
		       (let* ((current-ticks (sdl2:get-ticks))
			      (dt (- current-ticks previous-ticks)))
			 (update dt)
			 (draw renderer)
			 (setq previous-ticks current-ticks )
			 (clear-keys))))
	    (:quit ()
		   (progn
		     (sdl2-image:quit)
		     t))))))))
