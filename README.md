# alarmspark

## Introduction

> alarmspark is a homebrew kernel written in C and assembly with the intention of learning more about how the system works at a lower level than conventional programming. alarmspark is licensed as GPLv2 so please hack it. Currently it's only real "feature" is a semi functional prink() function used to print to the screen along with some general support for terminal scrolling.

## Hacking

> Please do! Tell me what I did wrong and how I can improve it. Patches are appreciated but not expected.

## Installation

> There is currently no "install", only a live CD environment that is built using "make iso". This kernel is multiboot compliant and uses unmodified Grub as the boot loader. It is also possible to install manually to a disk with grub installed. Just add an entry to your menu config to tell Grub where the kernel is after building. This option is not currently supported.
