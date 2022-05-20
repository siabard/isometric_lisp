(in-package #:isometric-lisp)


;;;; game state class

(defclass <game> () ((iso-scroll :accessor game-iso-scroll :initarg :iso-scroll)
		     (map-scroll :accessor game-map-scroll :initarg :map-scroll)))


;; constructor
;; position is list for 2D (x y)
(defun make-game (iso-scroll-position map-scroll-position)
  (let ((game (make-instance '<game>
			     :iso-scroll iso-scroll-position
			     :map-scroll map-scroll-position)))
    game))

