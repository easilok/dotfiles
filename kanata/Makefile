CONFIG:=$(HOME)/.config/kanata
BINARIES:=$(HOME)/.local/bin

config:
	mkdir -p $(CONFIG)
	ln -sfr laptop.kbd $(CONFIG)/laptop.kbd

install:
	sudo groupadd uinput
	sudo usermod -aG input $(USER)
	sudo usermod -aG uinput $(USER)
	echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee -a /etc/udev/rules.d/99-input.rules
	sudo udevadm control --reload && udevadm trigger --verbose --sysname-match=uniput
	sudo modprobe uinput
	ln -sfr kan $(BINARIES)

.PHONY: config install
