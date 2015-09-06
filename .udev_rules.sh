#!/bin/bash
cat << EOF > /etc/udev/rules.d/60-objdev.rules
SUBSYSTEM!="usb_device", ACTION!="add", GOTO="objdev_rules_end"

# USBasp
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", GROUP="wheel", MODE="0664"

# Android
ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="4e22", GROUP="wheel", MODE="0664"
ATTRS{idVendor}=="24e3", ATTRS{idProduct}=="0c03", GROUP="wheel", MODE="0664"

# USB-Blaster
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="664", GROUP="wheel"
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE="664", GROUP="wheel"
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE="664", GROUP="wheel"

# USB-Blaster II
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="664", GROUP="wheel"
ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="664", GROUP="wheel"

LABEL="objdev_rules_end"

EOF
