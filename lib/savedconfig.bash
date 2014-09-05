restore_config(){
	local config="${1}" srcdir="$(pwd)/src"

	if [[ -f ${CONFIGDIR}/${pkgname}/${config} ]]; then
	 # what if srcdir/pkgname doesn't exist than we can't operate	
	 # as makepkg -o needs to be executed first
	 if [[ ! -d "${srcdir}/${pkgname}/" ]]; then
		 MODIFY=0
		 echo "There is no "${srcdir}/${pkgname}/", you need to run  makepkg -o first!!"
		 clean
		 exit 1
	 else
		cp ${CONFIGDIR}/${pkgname}/${config} "${srcdir}/${pkgname}/"
	 fi

 else
	 echo "file ${CONFIGDIR}/${pkgname}/${config} doesn't exist" 
	 echo "cp your config file to ${CONFIGDIR}/${pkgname}/ for later use"
	 echo "then create line config ${config} in ${pkgname}.cstpkg"
 fi
 return 0
}
