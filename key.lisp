(in-package #:isometric-lisp)

;; KEY related function
;; TODO: should refactoring to class or struct

(defvar *pressed-key* (make-hash-table :test #'equal))
(defvar *released-key* (make-hash-table :test #'equal))
(defvar *held-keys* (make-hash-table :test #'equal))

(defun init-keys ()
  (clrhash *pressed-key*)
  (clrhash *released-key*)
  (clrhash *held-keys*))

(defun clear-keys ()
  (clrhash *pressed-key*)
  (clrhash *released-key*))

(defun keyup-event (scancode)
  (setf (gethash scancode *released-key*) t)
  (setf (gethash scancode *held-keys*) nil))

(defun keydown-event (scancode)
  (setf (gethash scancode *pressed-key*) t)
  (setf (gethash scancode *held-keys*) t))

(defun key-pressed-p (scancode)
  (gethash scancode *pressed-key* nil))

(defun key-released-p (scancode)
  (gethash scancode *released-key* nil))

(defun key-held-p (scancode)
  (gethash scancode *held-keys* nil))

;; //END OF KEY related function
