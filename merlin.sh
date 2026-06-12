#!/bin/bash

# --- Definición de colores para hacerlo más "amigable" ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

echo -e "${GREEN}Hi merlin user, just wait and watch...${NC}"

# El parámetro -p evita que lance error si la carpeta "outM" ya existe
mkdir -p outM

export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc

echo -e "${YELLOW}[1/3] Generating defconfig...${NC}"
make O=outM ARCH=arm64 merlin_defconfig

export PATH="${PWD}/clang-13/aaa/bin:${PATH}"

echo -e "${YELLOW}[2/3] Starting kernel compilation...${NC}"
make -j$(nproc --all) O=outM \
                      ARCH=arm64 \
                      LD=${PWD}/clang-13/aaa/bin/ld.lld \
                      OBJCOPY=${PWD}/clang-13/aaa/bin/llvm-objcopy \
                      AS=${PWD}/clang-13/aaa/bin/llvm-as \
                      NM=${PWD}/clang-13/aaa/bin/llvm-nm \
                      STRIP=${PWD}/clang-13/aaa/bin/llvm-strip \
                      OBJDUMP=${PWD}/clang-13/aaa/bin/llvm-objdump \
                      READELF=${PWD}/clang-13/aaa/bin/llvm-readelf \
                      CC=${PWD}/clang-13/aaa/bin/clang \
                      CROSS_COMPILE=${PWD}/clang-13/aaa/bin/aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=${PWD}/clang-13/aaa/bin/arm-linux-gnueabi- 

# --- Comprobación de seguridad ---
bp=${PWD}/outM
IMAGE="${bp}/arch/arm64/boot/Image.gz"

# Si el Image.gz NO existe, la compilación falló. Detenemos el script.
if [ ! -f "$IMAGE" ]; then
    echo -e "${RED}Error: Kernel Image (Image.gz) not found! Compilation failed.${NC}"
    exit 1
fi

echo -e "${GREEN}Compilation successful!${NC}"
echo -e "${YELLOW}[3/3] Packaging AnyKernel zip...${NC}"

DATE=$(date "+%Y%m%d-%H%M")
ZIPNAME="Shas-Dream-Merlin-R-vendor"

cd ${PWD}/AnyKernel3-master || exit

# El -f fuerza el borrado y evita que el sistema "grite" si los archivos no existen
rm -f *.zip *-dtb 

# Copiamos el kernel compilado
cp "$IMAGE" .

# Creamos el zip de AnyKernel
zip -r9 "${ZIPNAME}-${DATE}.zip" *

echo -e "${GREEN}Done! Your flashable zip is ready: ${ZIPNAME}-${DATE}.zip${NC}"
cd - || exit
