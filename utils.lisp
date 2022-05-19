(in-package #:isometric-lisp)

(defun list-to-rect (lst)
  (let ((rect  (apply #'sdl2:make-rect lst)))
    rect))

(defun cardinal-to-isometric (x y)
  (let ((dx (floor  (- x y)))
	(dy (floor  (* 0.5 (+ x y)))))
    (list dx dy)))

(defun isometric-to-cardinal (x y)
  (let ((iso-x (floor  (* 0.5 (+ (* 2 y) x))))
	(iso-y (floor  (* 0.5 (- (* 2 y) x)))))
    (list iso-x iso-y)))

(defun tile-coordinates (x y)
  (list (floor x *tile-size*) (floor y *tile-size*)))
