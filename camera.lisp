(in-package #:isometric-lisp)

;;;; 가상 전체 화면에서 카메라 출력 부분을 계산
;;; Camera의 x, y, width, height 안에 있는 것만
;;; renderer 에 노출해야함.
;;; SDL2 는 renderer 관련 내장 함수를 이용하면, Double Buffering이 일어나므로
;;; 별도의 Surface는 필요없음

(defparameter *camera-rect* nil)

(defun make-camera-rect (x y width height)
  (setf *camera-rect* (sdl2:make-rect x y width height)))


(defun move-camera-rect-to (x y)
  (setf (sdl2:rect-x *camera-rect*) x)
  (setf (sdl2:rect-y *camera-rect*) y))

