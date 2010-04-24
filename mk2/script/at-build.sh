#!/bin/sh

. "${MK_HOME}/mk.sh" || exit 1
mk_import

_mk_args

MK_MSG_DOMAIN="build"

mk_msg "$SOURCEDIR"

_mk_try mkdir -p "${MK_STAGE_DIR}"
_stage_dir="`cd "${MK_STAGE_DIR}" && pwd`"
cd "${MK_OBJECT_DIR}${MK_SUBDIR}/${SOURCEDIR}"
_mk_try ${MAKE} ${MFLAGS}
_mk_try ${MAKE} ${MFLAGS} DESTDIR="${_stage_dir}" install
cd "${MK_ROOT_DIR}"
_mk_try touch "$1"