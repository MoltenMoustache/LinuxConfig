#!/bin/sh

export WLR_NO_HARDWARE_CURSORS=1
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export LIBVA_DRIVER_NAME=nvidia
#export WLR_RENDERER=vulkan
#export WLR_DRM_DEVICES=/dev/dri/card1
#export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json
export PATH="$HOME/.local/bin/applications:$PATH"
exec dbus-run-session sway --unsupported-gpu
