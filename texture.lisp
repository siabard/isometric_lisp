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
