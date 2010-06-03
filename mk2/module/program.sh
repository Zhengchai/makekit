DEPENDS="core platform"

load()
{
    mk_run_program()
    {
	__program="$1"
	shift
	
	if [ -n "$MK_VERBOSE" ]
	then
	    mk_msg "=> ${__program##*/} $*"
	fi

	mk_run_with_extended_library_path \
	    "${MK_STAGE_DIR}${MK_LIBDIR}" \
	    "${__program}" \
	    "$@"
    }

    mk_check_program()
    {
	mk_push_vars PROGRAM FAIL
	mk_parse_params

	if [ -z "$PROGRAM" ]
	then
	    PROGRAM="$1"
	fi

	_def="`_mk_def_name "$PROGRAM"`"
	_res=""

	if _mk_contains "$PROGRAM" "$MK_INTERNAL_PROGRAMS"
	then
	    _res="${MK_STAGE_DIR}${MK_BIN_DIR}/${PROGRAM}"
	else
	    _IFS="$IFS"
	    IFS=":"
	    for __dir in ${MK_PATH} ${PATH}
	    do
	       if [ -x "${__dir}/${PROGRAM}" ]
	       then
		   _res="${__dir}/${PROGRAM}"
		   break;
	       fi
	    done
	    IFS="$_IFS"
	fi

	mk_export "$_def=$_res"

	if [ -z "$_res" ]
	then
	    mk_msg "program $PROGRAM: not found"
	    if [ "$FAIL" = "yes" ]
	    then
		mk_fail "could not find program: $PROGRAM"
	    fi
	    return 1
	else
	    mk_msg "program $PROGRAM: $_res"
	    return 0
	fi
    }
}