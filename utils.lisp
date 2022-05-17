(in-package #:isometric-lisp)

(defun list-to-rect (lst)
  (let ((rect  (apply #'sdl2:make-rect lst)))
    rect))

(defun cardinal-to-isometric (x y)
  (let ((dx (- x y))
	(dy (* 0.5 (+ x y))))
    (list dx dy)))

(defun isometric-to-cardinal (x y)
  (let ((iso-x (* 0.5 (+ (* 2 y) x)))
	(iso-y (* 0.5 (- (* 2 y) x))))
    (list iso-x iso-y)))
