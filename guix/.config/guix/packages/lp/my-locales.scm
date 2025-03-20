(define-module
  (lp my-locales)
  #:use-module (gnu packages base))

(define-public my-locales
               (make-glibc-utf8-locales
                 glibc
                 #:locales (list "en_US" "pt_PT")
                 #:name "glibc-my-utf8-locales"))
