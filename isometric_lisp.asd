;;;; isometric_lisp.asd

(asdf:defsystem #:isometric_lisp
  :description "Describe isometric_lisp here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:sdl2 #:sdl2-image #:sdl2-mixer #:sdl2-ttf)
  :components ((:file "package")
               (:file "isometric_lisp")))
