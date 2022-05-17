;;;; isometric_lisp.lisp

(in-package #:isometric-lisp)

;; making mouse system
(defstruct mouse-system x y button-l button-r)


(defun update (dt)
  "do system change with dt"
  dt ;; not yet determined
  )

;; handle key / mouse / pad
(defun update-input (keys mouses)
  "update system for key/mouse/pad input"
  (multiple-value-bind (mouse-x mouse-y) (sdl2:mouse-state)
    (setf (mouse-system-x mouses) mouse-x)
    (setf (mouse-system-y mouses) mouse-y)))

(defun draw (renderer mouse-state keys map sprite)
  (sdl2:set-render-draw-color renderer 155 155 155 255)
  (sdl2:render-clear renderer)
  (setf (x sprite) (mouse-system-x mouse-state))
  (setf (y sprite) (mouse-system-y mouse-state))
  (render renderer map)
  (render renderer sprite)
  (sdl2:render-present renderer))

(defun main ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "Isometric" :flags '(:shown) :w 640 :h 800)
	  (sdl2:with-renderer (renderer win :flags '(:accelerated :targettexture :presentvsync))
	    (sdl2-image:init '(:jpg :png))
            (let* ((previous-ticks (sdl2:get-ticks))
		   (keys (make-instance 'key-input))
		   (mouse-state (make-mouse-system)))
	      (init-keys keys)
	      (load-texture renderer "isotiles" "resources/tiles/isotiles.png")
	      (add-to-texture-atlas "isotiles" 320 80 64 80)
	      (make-camera-rect 0 0 320 240)
	      (let* ((isotiles-cube (get-texture-atlas "isotiles" 0))
		     (sprite (apply #'create-sprite (cons  "isotiles" isotiles-cube)))
		     (world-map (make-tiled-map "world-map" "isotiles" 3 3 64 80)))
		(set-tiled-map-layers world-map '(0 0 0 1 1 1 2 2 2))
		(sdl2:with-event-loop (:method :poll)
		  (:mousebuttonup (:button button)
				  (cond ((= button 1)
					 (setf (mouse-system-button-l mouse-state) nil))
					((= button 3)
					 (setf (mouse-system-button-r mouse-state) nil))))
		  (:mousebuttondown (:button button)
				    (cond ((= button 1)
					   (setf (mouse-system-button-l mouse-state) t))
					  ((= button 3)
					   (setf (mouse-system-button-r mouse-state) t))))
	          (:keyup (:keysym keysym)
		          (keyup-event keys (sdl2:scancode-value keysym)))
	          (:keydown (:keysym keysym)
		            (keydown-event keys (sdl2:scancode-value keysym)))
	          (:idle ()
			 (if (key-pressed-p keys (sdl2:scancode-key-to-value :scancode-escape))
		             (sdl2:push-event :quit)
		             (let* ((current-ticks (sdl2:get-ticks))
			            (dt (- current-ticks previous-ticks)))
			       (update-input keys mouse-state)
			       (update dt)
			       (draw renderer mouse-state keys world-map sprite)
			       (setq previous-ticks current-ticks )
			       (clear-keys keys))))
	          (:quit ()
			 (progn
		           (sdl2-image:quit)
		           t)))))))))

