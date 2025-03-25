(define-module
  (lp textutils)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages perl)
  #:use-module (guix download))

(define-public utf8proc-2.10.0
  (package
    (inherit utf8proc)
    (name "utf8proc")
    (version "2.10.0")
    (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaStrings/utf8proc")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1n1k67x39sk8xnza4w1xkbgbvgb1g7w2a7j2qrqzqaw1lyilqsy2"))))))
    ; (native-inputs
    ;   (let ((UNICODE_VERSION "16.0.0"))  ; defined in data/Makefile
    ;     ;; Test data that is otherwise downloaded with curl.
    ;     `(("NormalizationTest.txt"
    ;        ,(origin
    ;           (method url-fetch)
    ;           (uri (string-append "https://www.unicode.org/Public/"
    ;                               UNICODE_VERSION "/ucd/NormalizationTest.txt"))))
    ;       ("GraphemeBreakTest.txt"
    ;        ,(origin
    ;           (method url-fetch)
    ;           (uri (string-append "https://www.unicode.org/Public/"
    ;                               UNICODE_VERSION
    ;                               "/ucd/auxiliary/GraphemeBreakTest.txt"))))
    ;      ;; For tests.
    ;      ("perl" ,perl))))))
