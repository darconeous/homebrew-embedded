require 'formula'

class ArmNoneEabiGcc < Formula
  homepage 'http://gcc.gnu.org'

  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.2/gcc-4.8.2.tar.bz2'
  sha1 '810fb70bd721e1d9f446b6503afe0a9088b62986'

#  url 'http://ftpmirror.gnu.org/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
#  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
#  sha1 'a464ba0f26eef24c29bcd1e7489421117fb9ee35'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'arm-none-eabi-binutils'

  fails_with :clang do
    build 421
  end

  def install
    target = 'arm-none-eabi'
    binutils = Formula.factory "#{target}-binutils"

    ENV['PATH'] += ":#{binutils.prefix/"bin"}"


	gccbuildpath = buildpath
	newlib = Formula.factory 'newlib'
	newlib.brew do
		ohai "Moving newlib into GCC build tree"
		system "mv","newlib",gccbuildpath/"newlib"
		ohai "Moving libgloss into GCC build tree"
		system "mv","libgloss",gccbuildpath/"libgloss"
	end

	args = [
          "--target=#{target}",
          "--prefix=#{prefix}",
          "--infodir=#{info}",
          "--mandir=#{man}",

          "--enable-interwork",
          "--enable-multilib",
          "--enable-languages=c,c++",
          "--with-newlib",
          "--disable-libssb",
          '--disable-nls',
          '--with-system-zlib',


#          '--disable-tls',
#          '--disable-werror',
#          '--disable-debug',
#          "--disable-shared",

#          "--disable-threads",
#          "--disable-mudflap",
#          "--disable-libgomp",
#          "--with-float=soft",

          #'--disable-decimal-float',
          #'--with-headers',
          #"--disable-newlib-supplied-syscalls",

          #"--enable-newlib-io-long-long",
          #"--enable-version-specific-runtime-libs",
          "--enable-poison-system-directories",

          #"--enable-target-optspace",

#          "--without-included-gettext",
          "--disable-install-libiberty",
          #"--disable-libunwind-exceptions",
#          "--disable-sjlj-exceptions",
          #"--disable-libffi",
          #'--disable-libmudflap',
          #'--disable-libgomp',
          #"--disable-__cxa_atexit",
          #"--disable-libgfortran",
          #"--disable-libstdcxx-pch",

          # Without this line, GCC won't be able to find the assembler.
          #"--with-as=#{binutils.prefix}/bin/#{target}-as",

#		"--enable-newlib-io-reent-small",
#		"--with-float=soft",
#		"--with-abi=atpcs",		# Using old ABI for now.
#		"--enable-float",
#		"--enable-biendian",
          "CFLAGS=-std=gnu89",
	]

	mkdir 'build' do
          system '../configure', *args

            system 'make all'
            system 'make installdirs'
            system 'make install-target'
            system 'make install-host'

#          system 'make all-gcc'
#          system 'make install-gcc'
#          system 'make all'
#          system 'make install'
#          system 'make install-info'
          FileUtils.rm_rf prefix/"lib/x86_64"
          FileUtils.rm_rf prefix/"share/man/man7"
        end
  end
end
