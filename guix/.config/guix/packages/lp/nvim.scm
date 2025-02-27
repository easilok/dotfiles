(define-module
  (lp nvim)
  #:use-module (lp tree-sitter)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages vim))

(define-public nvim-latest
  (package
    (inherit neovim)
    (name "nvim-latest")
    (version "0.10.4")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/neovim/neovim")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "007v6aq4kdwcshlp8csnp12cx8c0yq8yh373i916ddqnjdajn3z3"))))
    (inputs (modify-inputs
              (package-inputs neovim)
              (replace "tree-sitter" tree-sitter-24)))))

