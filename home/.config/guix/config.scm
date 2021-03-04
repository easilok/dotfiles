;; This is an operating system configuration generated
;; by the graphical installer.

(use-modules (gnu)
	     (srfi srfi-1)
	     (gnu services desktop)
	     (gnu services base)
	     (gnu services cups)
	     (gnu services pm)
	     (gnu services docker)
	     (gnu services virtualization)
	     (gnu packages version-control)
	     (gnu packages linux)
	     (gnu packages mtools)
	     (gnu packages audio)
	     (gnu packages pulseaudio)
	     (gnu packages bash)
	     (gnu packages xorg)
	     (gnu packages gnome)
	     (gnu packages cups)
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
 ;; (services
 ;;  (append
 ;;   (list (service openssh-service-type)
 ;; 	 ;; (service slim-service-type)
 ;; 	 ;; (remove (lambda (service)
 ;; 	 ;; 	   (eq? (service-kind service) gdm-service-type))))
 ;; 	 (set-xorg-configuration
 ;; 	  (xorg-configuration
 ;; 	   (keyboard-layout keyboard-layout))))
 ;;   %desktop-services
 ;;   (list (extra-special-file "/bin/bash" (file-append bash "/bin/bash")))
 ;;   ))
(services (cons* (service slim-service-type
                              (slim-configuration
                                (xorg-configuration
                                  (xorg-configuration
                                    (keyboard-layout keyboard-layout)
                                    ))))
                    (service tlp-service-type
                             (tlp-configuration
                                (cpu-boost-on-ac? #t)
                                (wifi-pwr-on-bat? #t)))
                    (service thermald-service-type)
                    (service docker-service-type)
                    (service libvirt-service-type
                             (libvirt-configuration
                              (unix-sock-group "libvirt")
                              (tls-port "16555")))
                    (service cups-service-type
                             (cups-configuration
                               (web-interface? #t)
                               (extensions
                                 (list cups-filters))))
                    (bluetooth-service #:auto-enable? #t)
                    (remove (lambda (service)
                                (eq? (service-kind service) gdm-service-type))
                            %my-desktop-services)))
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
