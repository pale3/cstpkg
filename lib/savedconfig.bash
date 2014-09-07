restore_config(){
	local config="${1}" srcdir="$(pwd)/src"

	if [[ -f ${CONFIGDIR}/${package}/${config} ]]; then
	 # what if srcdir/pkgname doesn't exist than we can't operate	
	 # as makepkg -o needs to be executed first
	 if [[ ! -d "${srcdir}/${package}/" ]]; then
		 MODIFY=0
		 info -e "There is no "${srcdir}/${package}/",\n     you need to run  makepkg -o first!!"
		 clean
		 exit 255
	 else
		 cp "${CONFIGDIR}/${package}/${config}" "${srcdir}/${package}/"
	 fi

 else
	 info -e "file ${CONFIGDIR}/${package}/${config} doesn't exist" 
	 info -m "cp your config file to ${CONFIGDIR}/${package}/ for later use"
	 info -m "then create line config ${config} in ${package}.cstpkg"
 fi
 return 0
}
