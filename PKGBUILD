# Author: ava1ar <mail(at)ava1ar(dot)info>

pkgname=cstpkg-git
_pkgname=cstpkg
pkgver=34.1c635e8
pkgrel=1
pkgdesc="A tool to modify PKGBUILD with custom specifiy recipe" 
url="https://github.com:pale3/cstpkg.git" 
license=('GPL')
arch=('any')
depends=('bash' 'diffutils') 
optdepends=(
	'vim: for vimdiff'
	'colordiff: for colored diff output'
)
source=(git+https://github.com/pale3/cstpkg.git) 
sha1sums=('SKIP')

pkgver() {
	cd ${_pkgname}
	echo $(git rev-list --count master).$(git rev-parse --short master)
}

package() { 
	cd ${_pkgname}
	install -D -m 755 ${_pkgname} "${pkgdir}"/usr/bin/${_pkgname}
	
	# for compatibility with yaourt
	ln -s ${_pkgname} "${pkgdir}"/usr/bin/customizepkg

	mkdir -p "${pkgdir}"/usr/lib/cstpkg
	cp -R lib/*.bash "${pkgdir}"/usr/lib/cstpkg/

	mkdir -p "${pkgdir}"/usr/share/cstpkg/examples
	cp -R examples/*.example "${pkgdir}"/usr/share/cstpkg/examples

	mkdir -p "${pkgdir}"/etc/cstpkg.d/
}
