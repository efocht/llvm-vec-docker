#!/bin/bash

VENODEID=${VE_NODE_NUMBER:-0}
if [ -e "/dev/veslot$VENODEID" ]; then
    VE=$(readlink -f /dev/veslot$VENODEID)
    VEDEVICE_="--device $VE:$VE"
    VEVEOS_="-v /var/opt/nec/ve/veos:/var/opt/nec/ve/veos:z"
fi
docker run -it --rm \
    -v /dev:/dev:z \
    $VEDEVICE_ $VEVEOS_ \
    -v $HOME:$HOME:z \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -u $(id -u):$(id -g) \
    -w $PWD \
    efocht/llvm-vec:2.3.0
