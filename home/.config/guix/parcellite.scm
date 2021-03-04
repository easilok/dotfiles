(use-modules
 (guix packages)
 (guix git-download)
 (guix utils)
 (gnu packages gtk)
 (guix build-system gnu)
 (guix status)
 (gnu packages glib)
 (gnu packages autotools)
 (gnu packages pkg-config)
 (gnu packages base)
 (gnu packages glib)
 (gnu packages version-control)
 )

;; (define-public parcellite
  (package
    (name "parcellite")
    (version "1.2.1-5e73b1b")
    (source (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/CristianHenzel/ClipIt/archive/")
	    (commit "5e73b1b008c4b8ababc22aaaec0720cd80701bf7")))
      (sha256
        (base32 "0czaf7kzakf42q7x5nww3g921n00fxxx7lh1brp2z05vbl313s07"))))
    (build-system gnu-build-system)
    ;; (arguments
    ;;  '(#:phases (alist-cons-after
    ;;              'autogen
    ;;              (lambda _
    ;;                (zero? (system* "sh" "autogen.sh")))
    ;;              %standard-phases)))
    (arguments
     '(#:phases
       ;; (alist-cons-after
       ;;           'unpack 'autogen
       ;;           (lambda _
       ;; 		   (substitute* "scmversion.sh" (("#!/bin/sh") (string-append "#!" (which "sh"))))
       ;;             (zero? (system* "sh" "autogen.sh")))
       ;;           %standard-phases)
       (modify-phases %standard-phases
           (add-after 'unpack 'fix-hardcoded-paths
             (lambda _
               (substitute* "scmversion.sh"
			    (("#!/bin/sh") (string-append "#!" (which "sh"))))))
       ;; #:configure-flags '("LIBS='pkg-config --libs gtk+-2.0'")
))
    (native-inputs
     `(("intltool" ,intltool)
       ("pkg-config" ,pkg-config)
       ("autoconf", autoconf)
       ("automake", automake)
       ("libtool", libtool)
       ("which", which)
       ("glib", glib)
       ;; ("glibc", glibc)
       ("subversion", subversion)
       ("git", git)
       ))
    (inputs
     `(("gtk+" ,gtk+-2)))
    (home-page "http://parcellite.sourceforge.net/")
    (synopsis "Lightweight GTK+ clipboard manager")
    (description
     "Parcellite is a lightweight GTK+ clipboard manager. This is a stripped down,
basic-features-only clipboard manager with a small memory footprint for those
who like simplicity. ")
    (license "gpl3+")
);;)
