# DESCRIPTION; Simple aur/offical retriver
# usage: getpkgbuild <option> <savefile>
# ex: getpkgbuild aur ./PKGBUILD.tilda

fetch(){ $downloader "${1}" "${opt[@]}" $2 ; }

getpkgbuild(){
	local repo=${1} save_as=${2}
	
	case ${repo} in
		aur )
			url='https://aur.archlinux.org' 
			;;
		offical )
			url="https://projects.archlinux.org/svntogit/packages.git/plain/trunk/PKGBUILD?h=packages/"  
			;;
	esac
	
	info -d "getting PKGBULD.."
	[[ $(type -p curl ) ]] && downloader="curl" opt="-so" \
		|| downloader="wget" opt="--quiet -O" 

	fetch ${url}/packages/${package:0:2}/$package/PKGBUILD "${save_as}"
	return 0
}
