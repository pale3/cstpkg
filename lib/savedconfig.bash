restore_config(){
	local config="${1}" startdir="$(pwd)" srcdir="$(pwd)/src"

	if [[ -f ${CST_CONFIGDIR}/${package}/${config} ]]; then
		 info -m "Copying '$config' to '$startdir'"
		 
		 # copy configuration from /etc to startdir
		 cp "${CST_CONFIGDIR}/${package}/${config}" "./"

		 # create src dir if it doesn't exist	
		 mkdir -p src
		 
		 # link configuration to src dir for later use
		 [[ ! -f ${srcdir}/${config} ]] && ln -s "$(pwd)/${config}" "src/"
		 return 0
 else
	 info -e "file ${CST_CONFIGDIR}/${package}/${config} doesn't exist" 
	 info -m "cp your config file to ${CST_CONFIGDIR}/${package}/ for later use"
	 info -m "then create line config ${config} in ${package}.cstpkg"
	 info -m "like this: %config <filename.conf>"
	 return 127
 fi
}
