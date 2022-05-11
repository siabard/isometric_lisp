(in-package #:isometric-lisp)

(defun list-to-rect (lst)
  (let ((rect  (apply #'sdl2:make-rect lst)))
    rect))
