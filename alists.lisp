(in-package #:alists)

;;; FIXME: support test, test-not, key
;;; Note: assumes uniform alists (common set of keys between alists)
;; (defun project (items from-alists)
;;   "Merge alists"
;;   (labels ((project-alist (items alist)
;;              (mapcar #'(lambda (key)
;;                          (let ((pair (assoc key alist)))
;;                            (if pair
;;                                pair
;;                                (cons key nil))))
;;                      items)))
;;     (mapcar #'(lambda (alist)
;;                 (project-alist items alist))
;;             from-alists)))

;;; FIXME: handle test, test-not, key
;; (defun join (key left-alists right-alists &key test test-not key)
;;   (let ((result '()))
;;     (dolist (left-tuple left-alists)
;;       (dolist (right-tuple right-alists)
;;         (when (funcall test
;;                        (cdr (assoc key left-tuple))
;;                        (cdr (assoc key right-tuple)))
;;           (setf result
;;                 (cons (append left-tuple right-tuple)
;;                       result)))))
;;     (reverse result)))

(defmacro let-assoc (bindings alist &body body)
  "Destructure ALIST selectively into bindings specified by BINDINGS.
BINDINGS consists of (NAME ITEM &KEY TEST TEST-NOT KEY). ITEM, TEST,
TEST-NOT and KEY have the same meaning as their use in ASSOC. NAME is
the binding name.

Example, get the \"foo\" and :BAR associations from an ALIST:

   (let ((an-alist '((:bar    . 42)
                     (\"foo\" . \"eleven\"))))
     (let-assoc ((bar :bar)
                 (foo \"foo\" :test #'string=))
         an-alist
       (list foo bar))) => '(\"eleven\" 42)"
  (let ((alist-temp (gensym)))
    `(let* ((,alist-temp ,alist)
            ,@(mapcar (lambda (binding)
                        (destructuring-bind (name item &rest assoc-keys)
                            binding
                          (if assoc-keys
                              `(,name (cdr (assoc ,item ,alist-temp ,@assoc-keys)))
                              `(,name (cdr (assoc ,item ,alist-temp))))))
                      bindings))
       ,@body)))
