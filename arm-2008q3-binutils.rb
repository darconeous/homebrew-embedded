require 'formula'

class Arm2008q3Binutils < Formula
	homepage 'http://gcc.gnu.org'
	url 'http://ftp.gnu.org/gnu/binutils/binutils-2.18.tar.bz2'
	sha256 '4515254f55ec3d8c4d91e7633f3850ff28f60652b2d90dc88eef47c74c194bc9'

	def install
#		ENV['CC'] = 'llvm-gcc-4.2'
#		ENV['CXX'] = 'llvm-g++-4.2'
#		ENV['LD'] = 'llvm-gcc-4.2'

		target = 'arm-none-eabi'

		args = [
			'--with-pkgversion=Sourcery G++ Lite 2008q3-66',
			'--with-bugurl=https://support.codesourcery.com/GNUToolchain/',
			
			"--target=#{target}",
			"--prefix=#{prefix}",
			"--infodir=#{info}",
			"--mandir=#{man}",

			'--disable-debug',
			'--disable-nls',
			'--disable-werror',
			"--disable-install-libiberty",
			"--enable-poison-system-directories",
			
#			"--enable-interwork",
#			"--enable-multilib",
		]

		mkdir 'build' do
			system '../configure',*args
			system 'make all'
			system 'make install'

			# Removes stupid libiberty.a
			FileUtils.rm_rf prefix/"lib/x86_64"
		end
	end
	def patches
		[
			# Code Sourcery arm-2008q3 patch.
			'https://gist.github.com/darconeous/2023cf3675bfa7abad8f/raw/binutils-2008q3-66.patch.bz2',
			
			# Prevent PDF generation of documentation we don't care about.
			DATA
		]
	end

end


__END__
diff -u /Users/darco/Projects/gcc/arm-2008q3-66-arm-none-eabi/binutils-stable/Makefile.in binutils-2.18/Makefile.in
--- /Users/darco/Projects/gcc/arm-2008q3-66-arm-none-eabi/binutils-stable/Makefile.in	2008-11-13 05:11:25.000000000 -0800
+++ binutils-2.18/Makefile.in	2013-02-11 18:19:12.000000000 -0800
@@ -1109,101 +1109,8 @@
 
 .PHONY: pdf-host
 
-pdf-host: maybe-pdf-ash
-pdf-host: maybe-pdf-autoconf
-pdf-host: maybe-pdf-automake
-pdf-host: maybe-pdf-bash
-pdf-host: maybe-pdf-bfd
-pdf-host: maybe-pdf-opcodes
-pdf-host: maybe-pdf-binutils
-pdf-host: maybe-pdf-bison
-pdf-host: maybe-pdf-byacc
-pdf-host: maybe-pdf-bzip2
-pdf-host: maybe-pdf-dejagnu
-pdf-host: maybe-pdf-diff
-pdf-host: maybe-pdf-dosutils
-pdf-host: maybe-pdf-etc
-pdf-host: maybe-pdf-fastjar
-pdf-host: maybe-pdf-fileutils
-pdf-host: maybe-pdf-findutils
-pdf-host: maybe-pdf-find
-pdf-host: maybe-pdf-fixincludes
-pdf-host: maybe-pdf-flex
-pdf-host: maybe-pdf-gas
-pdf-host: maybe-pdf-gcc
-pdf-host: maybe-pdf-gawk
-pdf-host: maybe-pdf-gettext
-pdf-host: maybe-pdf-gmp
-pdf-host: maybe-pdf-mpfr
-pdf-host: maybe-pdf-gnuserv
-pdf-host: maybe-pdf-gprof
-pdf-host: maybe-pdf-gzip
-pdf-host: maybe-pdf-hello
-pdf-host: maybe-pdf-indent
-pdf-host: maybe-pdf-intl
-pdf-host: maybe-pdf-tcl
-pdf-host: maybe-pdf-itcl
-pdf-host: maybe-pdf-ld
-pdf-host: maybe-pdf-libcpp
-pdf-host: maybe-pdf-libdecnumber
-pdf-host: maybe-pdf-libgui
-pdf-host: maybe-pdf-libiberty
-pdf-host: maybe-pdf-libtool
-pdf-host: maybe-pdf-m4
-pdf-host: maybe-pdf-make
-pdf-host: maybe-pdf-mmalloc
-pdf-host: maybe-pdf-patch
-pdf-host: maybe-pdf-perl
-pdf-host: maybe-pdf-prms
-pdf-host: maybe-pdf-rcs
-pdf-host: maybe-pdf-readline
-pdf-host: maybe-pdf-release
-pdf-host: maybe-pdf-recode
-pdf-host: maybe-pdf-sed
-pdf-host: maybe-pdf-send-pr
-pdf-host: maybe-pdf-shellutils
-pdf-host: maybe-pdf-sid
-pdf-host: maybe-pdf-sim
-pdf-host: maybe-pdf-tar
-pdf-host: maybe-pdf-texinfo
-pdf-host: maybe-pdf-textutils
-pdf-host: maybe-pdf-time
-pdf-host: maybe-pdf-uudecode
-pdf-host: maybe-pdf-wdiff
-pdf-host: maybe-pdf-zip
-pdf-host: maybe-pdf-zlib
-pdf-host: maybe-pdf-gdb
-pdf-host: maybe-pdf-expect
-pdf-host: maybe-pdf-guile
-pdf-host: maybe-pdf-tk
-pdf-host: maybe-pdf-libtermcap
-pdf-host: maybe-pdf-utils
-pdf-host: maybe-pdf-convert
-pdf-host: maybe-pdf-gnattools
-
 .PHONY: pdf-target
 
-pdf-target: maybe-pdf-target-libstdc++-v3
-pdf-target: maybe-pdf-target-libmudflap
-pdf-target: maybe-pdf-target-libssp
-pdf-target: maybe-pdf-target-newlib
-pdf-target: maybe-pdf-target-libgcc
-pdf-target: maybe-pdf-target-libgfortran
-pdf-target: maybe-pdf-target-libobjc
-pdf-target: maybe-pdf-target-libtermcap
-pdf-target: maybe-pdf-target-winsup
-pdf-target: maybe-pdf-target-libgloss
-pdf-target: maybe-pdf-target-libiberty
-pdf-target: maybe-pdf-target-gperf
-pdf-target: maybe-pdf-target-examples
-pdf-target: maybe-pdf-target-libffi
-pdf-target: maybe-pdf-target-libjava
-pdf-target: maybe-pdf-target-zlib
-pdf-target: maybe-pdf-target-boehm-gc
-pdf-target: maybe-pdf-target-qthreads
-pdf-target: maybe-pdf-target-rda
-pdf-target: maybe-pdf-target-libada
-pdf-target: maybe-pdf-target-libgomp
 
 .PHONY: do-html
 do-html:
@@ -1537,101 +1444,9 @@
 
 .PHONY: install-pdf-host
 
-install-pdf-host: maybe-install-pdf-ash
-install-pdf-host: maybe-install-pdf-autoconf
-install-pdf-host: maybe-install-pdf-automake
-install-pdf-host: maybe-install-pdf-bash
-install-pdf-host: maybe-install-pdf-bfd
-install-pdf-host: maybe-install-pdf-opcodes
-install-pdf-host: maybe-install-pdf-binutils
-install-pdf-host: maybe-install-pdf-bison
-install-pdf-host: maybe-install-pdf-byacc
-install-pdf-host: maybe-install-pdf-bzip2
-install-pdf-host: maybe-install-pdf-dejagnu
-install-pdf-host: maybe-install-pdf-diff
-install-pdf-host: maybe-install-pdf-dosutils
-install-pdf-host: maybe-install-pdf-etc
-install-pdf-host: maybe-install-pdf-fastjar
-install-pdf-host: maybe-install-pdf-fileutils
-install-pdf-host: maybe-install-pdf-findutils
-install-pdf-host: maybe-install-pdf-find
-install-pdf-host: maybe-install-pdf-fixincludes
-install-pdf-host: maybe-install-pdf-flex
-install-pdf-host: maybe-install-pdf-gas
-install-pdf-host: maybe-install-pdf-gcc
-install-pdf-host: maybe-install-pdf-gawk
-install-pdf-host: maybe-install-pdf-gettext
-install-pdf-host: maybe-install-pdf-gmp
-install-pdf-host: maybe-install-pdf-mpfr
-install-pdf-host: maybe-install-pdf-gnuserv
-install-pdf-host: maybe-install-pdf-gprof
-install-pdf-host: maybe-install-pdf-gzip
-install-pdf-host: maybe-install-pdf-hello
-install-pdf-host: maybe-install-pdf-indent
-install-pdf-host: maybe-install-pdf-intl
-install-pdf-host: maybe-install-pdf-tcl
-install-pdf-host: maybe-install-pdf-itcl
-install-pdf-host: maybe-install-pdf-ld
-install-pdf-host: maybe-install-pdf-libcpp
-install-pdf-host: maybe-install-pdf-libdecnumber
-install-pdf-host: maybe-install-pdf-libgui
-install-pdf-host: maybe-install-pdf-libiberty
-install-pdf-host: maybe-install-pdf-libtool
-install-pdf-host: maybe-install-pdf-m4
-install-pdf-host: maybe-install-pdf-make
-install-pdf-host: maybe-install-pdf-mmalloc
-install-pdf-host: maybe-install-pdf-patch
-install-pdf-host: maybe-install-pdf-perl
-install-pdf-host: maybe-install-pdf-prms
-install-pdf-host: maybe-install-pdf-rcs
-install-pdf-host: maybe-install-pdf-readline
-install-pdf-host: maybe-install-pdf-release
-install-pdf-host: maybe-install-pdf-recode
-install-pdf-host: maybe-install-pdf-sed
-install-pdf-host: maybe-install-pdf-send-pr
-install-pdf-host: maybe-install-pdf-shellutils
-install-pdf-host: maybe-install-pdf-sid
-install-pdf-host: maybe-install-pdf-sim
-install-pdf-host: maybe-install-pdf-tar
-install-pdf-host: maybe-install-pdf-texinfo
-install-pdf-host: maybe-install-pdf-textutils
-install-pdf-host: maybe-install-pdf-time
-install-pdf-host: maybe-install-pdf-uudecode
-install-pdf-host: maybe-install-pdf-wdiff
-install-pdf-host: maybe-install-pdf-zip
-install-pdf-host: maybe-install-pdf-zlib
-install-pdf-host: maybe-install-pdf-gdb
-install-pdf-host: maybe-install-pdf-expect
-install-pdf-host: maybe-install-pdf-guile
-install-pdf-host: maybe-install-pdf-tk
-install-pdf-host: maybe-install-pdf-libtermcap
-install-pdf-host: maybe-install-pdf-utils
-install-pdf-host: maybe-install-pdf-convert
-install-pdf-host: maybe-install-pdf-gnattools
 
 .PHONY: install-pdf-target
 
-install-pdf-target: maybe-install-pdf-target-libstdc++-v3
-install-pdf-target: maybe-install-pdf-target-libmudflap
-install-pdf-target: maybe-install-pdf-target-libssp
-install-pdf-target: maybe-install-pdf-target-newlib
-install-pdf-target: maybe-install-pdf-target-libgcc
-install-pdf-target: maybe-install-pdf-target-libgfortran
-install-pdf-target: maybe-install-pdf-target-libobjc
-install-pdf-target: maybe-install-pdf-target-libtermcap
-install-pdf-target: maybe-install-pdf-target-winsup
-install-pdf-target: maybe-install-pdf-target-libgloss
-install-pdf-target: maybe-install-pdf-target-libiberty
-install-pdf-target: maybe-install-pdf-target-gperf
-install-pdf-target: maybe-install-pdf-target-examples
-install-pdf-target: maybe-install-pdf-target-libffi
-install-pdf-target: maybe-install-pdf-target-libjava
-install-pdf-target: maybe-install-pdf-target-zlib
-install-pdf-target: maybe-install-pdf-target-boehm-gc
-install-pdf-target: maybe-install-pdf-target-qthreads
-install-pdf-target: maybe-install-pdf-target-rda
-install-pdf-target: maybe-install-pdf-target-libada
-install-pdf-target: maybe-install-pdf-target-libgomp
 
 .PHONY: do-install-html
 do-install-html:
