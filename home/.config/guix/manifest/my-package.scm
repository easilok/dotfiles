;; -*- mode: guix-scheme -*-

(use-modules
 (lp suckless))

(packages->manifest
 `((,my-dmenu "out"))
 `((,my-dwm "out"))
 `((,my-dwmblocks "out"))
 )
