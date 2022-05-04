;;;; isometric_lisp.lisp

(in-package #:isometric-lisp)

;; TODO making game system

(defun update (dt)
  "do system change with dt"
  dt ;; not yet determined
  )


(defun draw (renderer texture)
  (sdl2:set-render-draw-color renderer 155 155 155 255)
  (sdl2:render-clear renderer)
  (sdl2:render-copy-ex
   renderer
   texture :source-rect (sdl2:make-rect 0 0 320 80) :dest-rect (sdl2:make-rect 0 0 320 80) :center (sdl2:make-point 0 0) :flip nil)
  (sdl2:render-present renderer))

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "Isometric" :flags '(:shown))
	  (sdl2:with-renderer (renderer win :flags '(:accelerated :targettexture :presentvsync))
	    (sdl2-image:init '(:jpg :png))
            (let* ((previous-ticks (sdl2:get-ticks))
		   (tile (load-texture renderer "resources/tiles/isotiles.png"))
		   (keys (make-instance 'key-input)))
	      (init-keys keys)
	      (sdl2:with-event-loop (:method :poll)
	        (:keyup (:keysym keysym)
		        (keyup-event keys (sdl2:scancode-value keysym)))
	        (:keydown (:keysym keysym)
		          (keydown-event keys (sdl2:scancode-value keysym)))
	        (:idle ()
		       (if (key-pressed-p keys (sdl2:scancode-key-to-value :scancode-escape))
		           (sdl2:push-event :quit)
		           (let* ((current-ticks (sdl2:get-ticks))
			          (dt (- current-ticks previous-ticks)))
			     (update dt)
			     (draw renderer tile)
			     (setq previous-ticks current-ticks )
			     (clear-keys keys))))
	        (:quit ()
		       (progn
		         (sdl2-image:quit)
		         t))))))))
