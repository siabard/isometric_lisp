(in-package #:isometric-lisp)

;; 리소스 보관용 
(defparameter *texture-repository* (make-hash-table :test 'equal))

(defun load-texture (renderer texture-name filename)
  (let* ((surface (sdl2-image:load-image (asdf:system-relative-pathname :isometric-lisp filename)))
         (texture (sdl2:create-texture-from-surface renderer surface)))
    (progn
      (setf (gethash texture-name *texture-repository*) texture)
      (sdl2:free-surface surface))))



;; 스프라이트 클래스
(defclass <sprite> () ((x :accessor x)
		       (y :accessor y)
		       (w :accessor w)
		       (h :accessor h)
		       (src-rect :accessor src-rect)
		       (texture-name :accessor texture-name)))

(defun create-sprite (name x y w h)
  (let ((sprite (make-instance '<sprite>)))
    (progn
      (setf (x sprite) 0)
      (setf (y sprite) 0)
      (setf (w sprite) w)
      (setf (h sprite) h)
      (setf (src-rect sprite) (sdl2:make-rect x y w h))
      (setf (texture-name sprite) name)
      sprite)))

(defmethod render (renderer (spr <sprite>))
  (let ((texture (gethash (texture-name spr) *texture-repository* nil)))
    (when texture
      (sdl2:render-copy-ex
       renderer
       texture
       :source-rect (src-rect spr)
       :dest-rect (sdl2:make-rect (x spr) (y spr) (w spr) (h spr))))))


;; Texture Atlas 클래스
;; 각 텍스쳐별로 Texture의 위치를
;; 별도로 보관
;; name : [(x y w h) ... ]

(defparameter *texture-atlas* (make-hash-table :test 'equal))

(defun add-to-texture-atlas (name texture-width texture-height tile-width tile-height)
  (let ((tile-rows (floor texture-height tile-height))
	(tile-cols (floor texture-width tile-height)))
    (setf (gethash name *texture-atlas*)
	  (loop for y below tile-rows
		nconcing (loop for x below tile-cols
			       collect (list (* x tile-width) (* y tile-width) tile-width tile-height))))))

(defun get-texture-atlas (name pos)
  (elt (gethash name *texture-atlas*) pos))
