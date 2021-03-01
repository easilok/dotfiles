;; -*- mode: guix-scheme-*-

(define-module (lp suckless)
 #:use-module (guix packages)
 #:use-module (guix git-download)
 #:use-module (gnu packages suckless))

(define-public my-dmenu
  (package
   (inherit dmenu)
   (name "my-dmenu")
   (version "latest")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://gitlab.com/easilok/dmenu")
       (commit "746f0468e669da3397afc6e8f6fb1223f30cc6f7")))
     (file-name
      (git-file-name name version))
     (sha256
      (base32
       "0y1zjfhipk86hv35qv85sjyy1ii3ymfqigcqy3xss4jwmq9mi1ld"))))))

(define-public my-dwm
  (package
   (inherit dmenu)
   (name "my-dwm")
   (version "latest")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://gitlab.com/easilok/dwm")
       (commit "c77b3854f9d71750c9663ad2e10649944eea633f")))
     (file-name
      (git-file-name name version))
     (sha256
      (base32
       "1dp8gwqbyq4bn4szx4b61sz12dil8z7k124dc6qknc047k8hq587"))))))

;; A copy from benoitj package definition to dwmstatus
(define-public my-dwmblocks
  (package
   (name "my-dwmblocks")
   (version "latest")
   (source
    (origin
     (method git-fetch)
     (uri
      (git-reference
       (url "https://gitlab.com/easilok/dwmblocks")
       (commit "0fdc485e2313b0f9949b2553d199262d76d10c86")))
     (file-name
      (git-file-name name version))
     (sha256
      (base32
       "1a7a5jmv2v2lfd56kd281g4dj9slsh8n10yf8j2lkqk6qgkasl12"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f                      ; no tests
	       #:make-flags
	       (list (string-append "CC=" ,(cc-for-target))
		     (string-append "PREFIX=" %output)
		     (string-append "FREETYPEINC="
				    (assoc-ref %build-inputs "freetype")
				    "/include/freetype2"))
	       #:phases
	       (modify-phases %standard-phases (delete 'configure))))
   (inputs
    `(("freetype" ,freetype)
      ("libxft" ,libxft)
      ("libx11" ,libx11)
      ("libxinerama" ,libxinerama)))
   (home-page "https://git.suckless.org/dwmstatus")
   (synopsis "DWM status bar with blocks")
   (description
    "dwm status bar with blocks")
   (license license:x11)))
