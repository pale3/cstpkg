info(){
	local msgtype="$1"
	case $msgtype in
		-m ) printf "%b\n" " ${G}:::${N} $2" 	;; 
		-e ) printf "%b\n" " ${R}:E:${N} $2"	;; 
		-E ) printf "%b\n" "  ${R}*${N}  Fatal error ${2}, Exiting..."; exit $3	;; 
		-w ) printf "%b\n" " ${Y}:W:${N} $2" 	;; 
		-d ) printf "%b\n" " ${G}:D:${N} $2" 	;; 
		-a ) printf "%b\n" "  -> $2" ;; 
	esac
}

include(){
	local modules="$@"
	
	for module in ${modules[@]} ; do
		[[ -e ${CST_LIBDIR}/${module}.bash ]] && \
			source "${CST_LIBDIR}/${module}.bash" || notfound+="${module} "
	done

	if [[ ! -z $notfound ]]; then
		for lib in ${notfound}; do
			info -w "Lib '${W}${lib}${N}' doesn't exist"
		done
		exit 14 # E_CODE terminate if lib not found
	fi

	return 0
}

validate_and_copy_file(){
	local file=${1}

	# checking exsistance of specified file
	if [[ ! -f ${CST_CONFIGDIR}/${package}/${file} ]]; then
		info -w "File ${file} doesn't exist! Using orginal PKGBUILD functions"
		return 127
	else
		cp ${CST_CONFIGDIR}/${package}/${file} "./" || return 127
		return 0
	fi	
}

error_handling(){
	local ret=$?; shift
	
	case $ret in
			0 ) echo 0    ;; # no errors
		125 ) echo 125  ;; # errors from libs
		127 ) echo 127  ;; # errors from function
		255 ) echo 255  ;; # errors from main
			* ) echo $ret ;; # any other error
	esac
}
