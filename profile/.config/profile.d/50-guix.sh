#!/usr/bin/env bash
	
## Extra Guix profiles section
 unset GUIX_PROFILE
GUIX_EXTRA_PROFILES="$HOME/.guix-extra-profiles"
if [ -d "$GUIX_EXTRA_PROFILES" ]; then
    for i in $GUIX_EXTRA_PROFILES/*; do
	profile=$i/$(basename "$i")
	if [ -f "$profile"/etc/profile ]; then
	    GUIX_PROFILE="$profile"
	    . "$GUIX_PROFILE"/etc/profile
	fi
	if [ -d "$profile"/share/man ]; then
        export MANPATH=$GUIX_PROFILE/share/man${MANPATH:+:}$MANPATH
    fi
	unset profile
    done
fi

## Default Guix
export GUIX_PROFILE="$HOME/.guix-profile"
[ -d "$GUIX_PROFILE/etc/profile" ] && . "$GUIX_PROFILE/etc/profile"

## SSL CA path set
export SSL_CERT_DIR="$GUIX_PROFILE/etc/ssl/certs"
export SSL_CERT_FILE="$GUIX_PROFILE/etc/ssl/certs/ca-certificates.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"
