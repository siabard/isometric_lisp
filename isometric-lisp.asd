;;;; isometric_lisp.asd

(asdf:defsystem #:isometric-lisp
  :description "Describe isometric_lisp here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:sdl2 #:sdl2-image #:sdl2-mixer #:sdl2-ttf)
  :components ((:file "package")
	       (:file "game")
               (:file "texture")
               (:file "key")
	       (:file "tile-map")
	       (:file "utils")
	       (:file "camera")
	       (:file "isometric_lisp")))
