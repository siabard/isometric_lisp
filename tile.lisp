(in-package #:isometric-lisp)

(defun load-texture (renderer filename)
  (let* ((surface (sdl2-image:load-image (asdf:system-relative-pathname :isometric-lisp filename)))
         (texture (sdl2:create-texture-from-surface renderer surface)))
    (sdl2:free-surface surface)
    texture))
