# DESCRIPTION; Simple aur/offical retriver
# usage: getpkgbuild <option> <savefile>
# example: getpkgbuild aur ./PKGBUILD.tilda

determine_PM(){
	local pm=$1
	case ${pm} in
		yaourt )
			QOPT="-Si" ;;
		pacaur )
			QOPT="-Si" ;;
		aura)
			QOPT="-Ai" ;;
		cower )
			QOPT="-i"  ;;	
		packer )
			QOPT="-Si" ;;
	esac

	echo $pm $QOPT
}

fetch(){ $downloader "${1}" "${opt[@]}" $2 ; }

getpkgbuild(){
	local repo=${1} save_as=${2}
	local QLOCAL="pacman -Qi"
	
	case ${repo} in
		aur )
			QUPST=$(determine_PM "$pattern")
			url='https://aur.archlinux.org' 
			;;
		offical )
			QUPST="pacman -Si"	
			url="https://projects.archlinux.org/svntogit/packages.git/plain/trunk/PKGBUILD?h=packages/"  
			;;
	esac
	
	local current_ver=$( $QLOCAL ${package} 2> /dev/null | awk '/Version/ {print $3}')
	local new_ver=$( $QUPST ${package} 2> /dev/null | awk '/Version/ {print $3}')
	
	# ako je git uvijek pokreni 
	[[ -z $current_ver ]] && \
		info -w "package ${package} doesn't exist in local DB (installed?)"
	
	# needs some tests
		if (( $git )); then
			info -d "fetching ${package} PKGBULD from ${repo}.."
		else 	
			current_ver=${current_ver//[[:punct:]]/}
			new_ver=${new_ver//[[:punct:]]/}
			if [[ $current_ver -lt $new_ver ]]; then
				info -d "fetching ${package} PKGBULD from ${repo}.."
			elif [[ $current_ver -gt $new_ver ]]; then
				info -d "fetching ${package} PKGBULD from ${repo}.."
				info -w "Current versions of ${package} is grater then new version..Downgrading.."
			else	
				info -d "Same versions"	&& exit 1
			fi	
		fi
	
	# is curl present? fallback to wget
	[[ $(type -p curl ) ]] && downloader="curl" opt="-so" \
		|| downloader="wget" opt="--quiet -O" 

	fetch ${url}/packages/${package:0:2}/$package/PKGBUILD "${save_as}"
	return 0
}
