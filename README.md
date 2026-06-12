# merlin-r-oss

Tools upstreamed to python3



How to build:

    Clone or download code.

    run: git clone https://github.com/kdrag0n/proton-clang.git ./clang-13/aaa

    Then run ./merlinp.sh to build kernel for Redmi Note 9.

    Go AnyKernel3-master to get your zip file.
How to install

    Flash vbmeta_vd171--V12.5.1.0.RJOMIXM.img to vbmeta partition (without it, the device will enter a bootloop).

    Flash TWRP.img to recovery partition.

    Put the zip you obtained from AnyKernel3-master in an external SD Card ( or later sideload it ).

    Reboot to recovery

    Use TWRP Recovery to install the kernel's zip.

    Pull the boot.img from the device ( for example with MTKclient)

    If with MTKclient change boot.bin to boot.img.

    Now you obtained your new boot, if you want to use apatch you will replace the RAMDISK with the next steps. ( INCOMPLETE )
    
        Put the boot.img in kitchen and run patch.sh
    
        After that just flash the new boot signed image to your device

WARNING: WORK UNDER DEVELOPMENT, MAY NOT BE FINISHED.

Modified from Arafattex kernel source.

Aditional credits:

[TWRP Recovery](https://xdaforums.com/t/twrp-3-4-2b-cn-wszx150-for-merlin-redmi-note-9-redmi-10x-4g-unofficial.4345969/)

[Patched vbmeta image](https://xdaforums.com/t/vbmeta-img-patched-vbmeta-image-partition-disabled-verity-disabled-verification-for-merlin-xiaomi-redmi-10x-4g-xiaomi-redmi-note-9.4221075/)

[MTKclient](https://github.com/bkerler/mtkclient)

[Kitchen](https://github.com/ravindu644/Kitchen)
