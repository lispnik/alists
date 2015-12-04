(defpackage #:alists-system (:use #:common-lisp #:asdf))
(in-package #:alists-system)

(defsystem #:alists
  :components ((:file "package")
               (:file "alists"))
  :serial t
  :in-order-to ((test-op (test-op #:alists-test))))
