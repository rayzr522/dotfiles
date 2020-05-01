#!/bin/bash

set -ex

PKGBUILD_DIR=urxvt-pkgbuild

[[ -d "$PKGBUILD_DIR" ]] || git clone https://github.com/blueyed/PKGBUILD-rxvt-unicode-wide "$PKGBUILD_DIR"
cd "$PKGBUILD_DIR"

cvs -z3 -d :pserver:anonymous@cvs.schmorp.de/schmorpforge co rxvt-unicode
cd rxvt-unicode

patch --silent --forward -p0 -i ../font-width-fix.patch || true
patch --silent --forward -p0 -i ../line-spacing-fix.patch || true
patch --silent --forward -p0 -i ../sgr-mouse-mode.patch || true
patch --silent --forward -p1 -i ../enable-wide-glyphs.patch || true

./configure \
    --prefix=/usr \
    --enable-256-color \
    --enable-combining \
    --enable-fading \
    --enable-font-styles \
    --enable-iso14755 \
    --enable-keepscrolling \
    --enable-lastlog \
    --enable-mousewheel \
    --enable-next-scroll \
    --enable-perl \
    --enable-pointer-blank \
    --enable-rxvt-scroll \
    --enable-selectionscrolling \
    --enable-slipwheeling \
    --enable-smart-resize \
    --enable-startup-notification \
    --enable-transparency \
    --enable-unicode3 \
    --enable-utmp \
    --enable-wide-glyphs \
    --enable-wtmp \
    --enable-xft \
    --enable-xim \
    --enable-xterm-scroll

make -j 8
sudo make install
