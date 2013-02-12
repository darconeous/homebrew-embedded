require 'formula'

class Arm2008q3Gcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.3.2/gcc-4.3.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.3.2/gcc-4.3.2.tar.bz2'
  sha1 '787b566ad4f386a9896e2d5703e6ff5e7ccaca58'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'arm-2008q3-binutils'

  def install
    binutils = Formula.factory 'arm-2008q3-binutils'

    ENV['CC'] = 'llvm-gcc-4.2'
    ENV['CXX'] = 'llvm-g++-4.2'
    ENV['LD'] = 'llvm-gcc-4.2'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"
	
	target = 'arm-none-eabi'
	
	gccbuildpath = buildpath
	newlib = Formula.factory 'arm-2008q3-newlib'
	newlib.brew do
		ohai "Moving newlib into GCC build tree"
		system "mv","newlib",gccbuildpath/"newlib"
#		ohai "Moving libgloss into GCC build tree"
#		system "mv","libgloss",gccbuildpath/"libgloss"
	end

	args = [
		'--with-pkgversion=Sourcery G++ Lite 2008q3-66',
		'--with-bugurl=https://support.codesourcery.com/GNUToolchain/',
		
		"--target=#{target}",
		"--prefix=#{prefix}",
        "--infodir=#{info}",
        "--mandir=#{man}",
		
		"--enable-obsolete",
		'--disable-nls',
		'--disable-werror',
		'--disable-debug',
		"--disable-shared",
		
		"--enable-languages=c",	

		'--disable-decimal-float',
		'--with-headers',
		"--enable-interwork",
		"--enable-multilib",
		"--with-newlib",
		"--disable-newlib-supplied-syscalls",

		"--enable-newlib-io-long-long",
		"--enable-version-specific-runtime-libs",	
		"--enable-poison-system-directories",

		"--enable-target-optspace",

		"--without-included-gettext",
		"--disable-install-libiberty",
		"--disable-libunwind-exceptions",
		"--disable-libffi",
		'--disable-libmudflap',
		'--disable-libgomp',
		"--disable-__cxa_atexit",
		"--disable-libgfortran",
		"--disable-libssb",
		"--disable-libstdcxx-pch",

		# Without this line, GCC won't be able to find the assembler.
		"--with-as=#{binutils.prefix}/bin/#{target}-as",

#		"--enable-newlib-io-reent-small",
#		"--with-float=soft",
#		"--with-abi=atpcs",		# Using old ABI for now.
#		"--enable-float",
#		"--enable-biendian",
	]

	mkdir 'build' do
		system '../configure', *args
		system 'make all'
		system 'make installdirs'
		system 'make install-target'
		system 'make install-host'

		FileUtils.rm_rf prefix/"lib/x86_64"
    end
  end
  def patches
	[
		'https://gist.github.com/darconeous/2023cf3675bfa7abad8f/raw/gcc-2008q3-66.patch.bz2',
		DATA
	]
  end
end

__END__
diff --git a/gcc/Makefile.in b/gcc/Makefile.in
index 3518dbc..eaafadb 100644
--- a/gcc/Makefile.in
+++ b/gcc/Makefile.in
@@ -3934,7 +3934,7 @@ maintainer-clean:
 # Install the driver last so that the window when things are
 # broken is small.
 install: install-common $(INSTALL_HEADERS) \
-    install-cpp install-man install-info install-html install-pdf \
+    install-cpp install-man install-info \
     install-@POSUB@ install-driver

 # Handle cpp installation.
