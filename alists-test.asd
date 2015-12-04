(defpackage #:alists-test-system (:use #:common-lisp #:asdf))
(in-package #:alists-test-system)

(defsystem #:alists-test
  :components ((:module "test"
                        :components ((:file "package")
                                     (:file "test"))))
  :depends-on (#:alists #:fiveam)
  :perform (test-op (o s)
                    (uiop:symbol-call
                     :fiveam '#:run!
                     (uiop:find-symbol* "ALISTS-TEST-SUITE" "ALISTS-TEST"))))
