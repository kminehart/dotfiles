#!/usr/bin/env bash
color=c44304
bg_color=00000000
text_color=e8e8e8
wrong_color=931c4b
ver_color=73234c

swaylock \
  --fade-in $1 --grace $1 --grace-no-mouse --grace-no-touch \
  --image=/usr/share/backgrounds/gnome/blobs-d.svg \
  --effect-blur=10x10 \
  --clock \
  --indicator-thickness 5 \
	--text-wrong-color $wrong_color \
	--inside-color $bg_color \
	--inside-ver-color $ver_color \
  --inside-clear-color $bg_color \
	--text-color $text_color \
	--ring-color $color \
	--ring-ver-color $ver_color \
	--ring-wrong-color $wrong_color \
	--ring-clear-color $color \
	--line-color $bg_color \
	--line-ver-color $bg_color \
	--line-wrong-color $wrong_color \
	--text-ver-color $text_color \
	--text-clear-color $text_color \
  --layout-bg-color $bg_color \
  --layout-border-color $bg_color \
  --layout-text-color $text_color \
  --key-hl-color $ver_color
