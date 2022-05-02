;;;; isometric_lisp.lisp

(in-package #:isometric-lisp)

;; TODO making game system

(defun update (dt)
  "do system change with dt"
  dt ;; not yet determined
  )

(defun draw (renderer)
  (sdl2:set-render-draw-color renderer 155 59 155 255)
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
		    (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
		      (sdl2:push-event :quit)))
	    (:idle ()
		   (let* ((current-ticks (sdl2:get-ticks))
			  (dt (- current-ticks previous-ticks)))
		     (update dt)
		     (draw renderer)
		     (setq previous-ticks current-ticks )))
	    (:quit ()
		   (progn
		     (sdl2-image:quit)
		     t))))))))
