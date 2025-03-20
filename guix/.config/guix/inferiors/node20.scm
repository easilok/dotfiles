(define-module
  (node20)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (guix packages)
  #:use-module (srfi srfi-1))

(define channels
  ;; This is the old revision from which we want to
  ;; extract python3.10
  (list (channel
         (name 'guix)
         (url "https://git.savannah.gnu.org/git/guix.git")
         (commit
          "1bb7866667"))))

(define inferior
  ;; An inferior representing the above revision.
  (inferior-for-channels channels))

(define-public node20
  (package
    (inherit (first (lookup-inferior-packages inferior "node")))
    (name "node20")))
