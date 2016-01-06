#!/bin/sh

set -e

BIN=nethack360-rumprun.bin
IMG=nethack360-data.e2img

die ()
{

	echo '>>' 2>&1
	echo '>> ERROR: ' $*
	exit 1
}

uncompress ()
{

	printf '>> Uncompressing %s ... ' $1
	xz -d -c ${1}.xz > ${1}
	printf 'done\n'
}

[ -f ${BIN}.xz ] || die run script in repository
type qemu-system-x86_64 >/dev/null 2>&1 || die qemu-system-x86_64 required

# uncompress only once.  Avoids nuking savegames and so forth.
[ -f ${IMG} ] || uncompress ${IMG}

# uncompress if updated (not perfect, but, meh)
[ -f ${BIN} -a ${BIN} -nt ${BIN}.xz ] || uncompress ${BIN}

# always fsck if fsck.ext2 is available on the host, never otherwise
if type fsck.ext2 >/dev/null 2>&1; then
	fsck.ext2 -p ${IMG} || true
fi

qemu-system-x86_64 -drive if=virtio,file=${IMG} ${*} -kernel ${BIN}
