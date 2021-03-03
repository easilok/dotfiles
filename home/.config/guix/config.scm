;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
	     (srfi srfi-1)
	     (gnu services desktop)
	     (gnu services base)
	     (gnu packages version-control)
	     (gnu packages linux)
	     (gnu packages mtools)
	     (gnu packages audio)
	     (gnu packages pulseaudio)
	     (gnu packages bash)
	     (gnu packages xorg)
	     (gnu packages gnome)
	     (gnu packages vim))
(use-service-modules desktop networking ssh xorg)
;; Import nonfree linux module.
(use-modules (nongnu packages linux)
	     (nongnu system linux-initrd))

;; (define %my-desktop-services
;;   (cons*
;;    (service openssh-service-type)
   ;; (set-xorg-configuration
   ;;  (xorg-configuration
   ;;   (keyboard-layout keyboard-layout)))
   ;; (extra-special-file "/bin/bash" (file-append bash "/bin/bash"))
   ;; ))
(define %my-desktop-services
  (modify-services %desktop-services
		   (elogind-service-type config =>
					 (elogind-configuration (inherit config)
								(handle-lid-switch-external-power 'suspend)))
		   ))

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (locale "en_US.utf8")
 (timezone "Europe/Lisbon")
 (keyboard-layout (keyboard-layout "pt"))
 (host-name "edison")
 (groups
  (append
   (list
    (user-group
     (name "plugdev")))
   %base-groups))
 (users (cons* (user-account
		(name "luis")
		(comment "Luis Pereira")
		(group "users")
		(home-directory "/home/luis")
		(supplementary-groups
		 '("wheel" "netdev" "audio" "video" "plugdev" "input")))
	       %base-user-accounts))
 (packages
  (append
   (list (specification->package "openbox")
	 (specification->package "nss-certs")
	 git
	 ntfs-3g
	 exfat-utils
	 fuse-exfat
	 vim
	 bluez
	 bluez-alsa
	 pulseaudio
	 tlp
	 xf86-input-libinput
	 (specification->package "gcc-toolchain")
	 (specification->package "make")
	 (specification->package "cmake")
	 (specification->package "pkg-config")
	 gvfs)
   %base-packages))
 ;; (service special-files-service-type 
 ;; 	  `(("/bin/sh" ,(file-append bash "/bin/sh")) %base-services))
    
 ;; (services %my-desktop-services)
 (services
  (append
   (list (service openssh-service-type)
	 ;; (service slim-service-type)
	 ;; (remove (lambda (service)
	 ;; 	   (eq? (service-kind service) gdm-service-type))))
	 (set-xorg-configuration
	  (xorg-configuration
	   (keyboard-layout keyboard-layout))))
   %desktop-services
   (list (extra-special-file "/bin/bash" (file-append bash "/bin/bash")))
   ))
 ;; (services
 ;;  (cons*
 ;;   (extra-special-file "/bin/sh"
 ;; 	 (file-append bash "/bin/sh"))
 ;;   %base-services))
 (bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (target "/dev/sda")
   (keyboard-layout keyboard-layout)))
 (swap-devices
  (list (uuid "b7472182-f20b-42b0-b47a-cbf713a76f6a")))
 (file-systems
  (cons* (file-system
	  (mount-point "/")
	  (device
	   (uuid "8b0a5b29-a788-49d7-af38-4b98359eb358"
		 'ext4))
	  (type "ext4"))
	 %base-file-systems)))
