;;;; isometric_lisp.lisp

(in-package #:isometric_lisp)

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "Isometric" :flags '(:shown))
      (sdl2:with-renderer (renderer win :flags '(:accelerated :targettexture :presentvsync))
	(sdl2-image:init '(:jpg :png))
	(sdl2:with-event-loop (:method :poll)
	  (:keyup (:keysym keysym)
		  (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
		    (sdl2:push-event :quit)))
	  (:idle ()
		 (sdl2:set-render-draw-color renderer 0 0 0 255)
		 (sdl2:render-clear renderer)
		 (sdl2:render-present renderer))
	  (:quit ()
		 (progn
		   (sdl2-image:quit)
		   t)))))))
