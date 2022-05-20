(in-package #:isometric-lisp)

(defun list-to-rect (lst)
  (let ((rect  (apply #'sdl2:make-rect lst)))
    rect))

(defun cardinal-to-isometric (x y)
  (let ((dx (- x y))
	(dy (floor (+ x y) 2)))
    (list dx dy)))

(defun isometric-to-cardinal (x y)
  (let ((iso-x (floor (+ (* 2 y) x) 2))
	(iso-y (floor (- (* 2 y) x) 2)))
    (list iso-x iso-y)))

(defun tile-coordinates (x y)
  (list (floor x *tile-size*) (floor y *tile-size*)))
