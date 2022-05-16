;;;; isometric_lisp.lisp

(in-package #:isometric-lisp)

;; TODO making game system

(defun update (dt)
  "do system change with dt"
  dt ;; not yet determined
  )


(defun draw (renderer map)
  (sdl2:set-render-draw-color renderer 155 155 155 255)
  (sdl2:render-clear renderer)
  (render renderer map)
  (sdl2:render-present renderer))

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "Isometric" :flags '(:shown) :w 640 :h 800)
	  (sdl2:with-renderer (renderer win :flags '(:accelerated :targettexture :presentvsync))
	    (sdl2-image:init '(:jpg :png))
            (let* ((previous-ticks (sdl2:get-ticks))
		   (keys (make-instance 'key-input)))
	      (init-keys keys)
	      (load-texture renderer "isotiles" "resources/tiles/isotiles.png")
	      (add-to-texture-atlas "isotiles" 320 80 64 80)
	      (make-camera-rect 0 0 320 240)
	      (let* ((isotiles-cube (get-texture-atlas "isotiles" 0))
		     (sprite (apply #'create-sprite (cons  "isotiles" isotiles-cube)))
		     (world-map (make-tiled-map "world-map" "isotiles" 3 3 64 80)))
		(set-tiled-map-layers world-map '(0 0 0 1 1 1 2 2 2))
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
			       (draw renderer world-map)
			       (setq previous-ticks current-ticks )
			       (clear-keys keys))))
	          (:quit ()
			 (progn
		           (sdl2-image:quit)
		           t)))))))))

