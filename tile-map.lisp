;;;; TILED map

(in-package #:isometric-lisp)

;; tiled map present

(defclass <tiled-map> ()
  ((name :initarg :name :reader tield-map-name)
   (texture-name :initarg :texture-name :reader tiled-map-texture-name)
   (width :initarg :width :reader tiled-map-width)
   (height :initarg :height :reader tiled-map-height)
   (tile-width :initarg :tile-width :reader tiled-map-tile-width)
   (tile-height :initarg :tile-height :reader tiled-map-tile-height)
   (layers :initform nil :accessor tiled-map-layers)))

(defun make-tiled-map (name texture-name width height tile-width tile-height)
  (let ((tm (make-instance '<tiled-map>
			   :name name
			   :texture-name texture-name
			   :width width
			   :height height
			   :tile-width tile-width
			   :tile-height tile-height)))
    tm))



(defgeneric set-tiled-map-layers (<tiled-map> layer-data)
  (:documentation "Set layer of map. Size of layer = width * height"))

(defmethod set-tiled-map-layers ((tm <tiled-map>) layer-data)
  (setf (tiled-map-layers tm) layer-data))

(defgeneric render (renderer <tiled-map>)
  (:documentation "Render map "))


(defmethod render (renderer (tm <tiled-map>))
  (let* ((width (tiled-map-width tm))
	 (height (tiled-map-height tm))
	 (tile-width (tiled-map-tile-width tm))
	 (tile-height (tiled-map-tile-height tm))
	 (tile-layer (tiled-map-layers tm))
	 (texture-name (tiled-map-texture-name tm))
	 (texture (gethash texture-name *texture-repository*)))
    (loop for y below height
	  do (loop for x below width
		   do (let ((dest-rect (sdl2:make-rect (* x tile-width) (* y tile-height) tile-width tile-height)))
			(when  (sdl2:intersect-rect *camera-rect* dest-rect)
			  (let ((dest-rect (sdl2:make-rect (- (* x tile-width) (sdl2:rect-x *camera-rect*))
							   (- (* y tile-height) (sdl2:rect-y *camera-rect*))
							   tile-width tile-height)))
			    (sdl2:render-copy-ex renderer
						 texture
						 :source-rect (list-to-rect (get-texture-atlas texture-name (elt tile-layer (+ x  (* y width)))))
						 :dest-rect dest-rect))))))))

