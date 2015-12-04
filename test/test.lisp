(in-package #:alists-test)

(def-suite alists-test-suite)
(in-suite alists-test-suite)

(test let-assoc-none
  (is (null (let-assoc nil nil))))

(test let-assoc-one
  (is (string=
       "example"
       (let-assoc ((item :item)) '((:item . "example"))
         item))))

(test let-assoc-test
  (is (string=
       "example"
       (let-assoc ((item "item" :test #'string=)) '(("item" . "example"))
         item))))

(test let-assoc-test-not
  (is (string=
       "example"
       (let-assoc ((item "item" :test-not #'string/=))
           '(("item" . "example"))
         item))))

(test let-assoc-key
  (is (string=
       "example"
       (let-assoc ((item :item :key #'car))
           '(((:item . 53) . "example"))
         item))))
