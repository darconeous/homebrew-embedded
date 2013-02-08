require 'formula'

class ArmElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  sha1 'a464ba0f26eef24c29bcd1e7489421117fb9ee35'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'arm-elf-binutils'

  def install
    binutils = Formula.factory 'arm-elf-binutils'

	ENV['CC'] = 'gcc'
    ENV['CXX'] = 'g++'
    ENV['CPP'] = 'cpp'
    ENV['LD'] = 'gcc'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"
	target = 'arm-none-eabi'

	newlib = Formula.factory 'newlib'
	dwnldr = newlib.downloader
	dwnldr.fetch # fetch (uses cache!)
	dwnldr.stage # unpack

	system "ln","-s","#{Dir["newlib*"]}/newlib"
	system "ln","-s","#{Dir["newlib*"]}/libgloss"
	
	mkdir 'build' do
      system '../configure', '--disable-nls', "--target=#{target}",
                             "--enable-languages=c",
							"--without-included-gettext",
							"--disable-__cxa_atexit",
							"--enable-multilib",
							"--enable-biendian",
							"--disable-libgfortran",
							"--disable-libssb",
							"--disable-libstdcxx-pch",
							"--enable-version-specific-runtime-libs",
							 "--enable-interwork",
                             "--with-newlib",
							"--enable-obsolete",
                             "--prefix=#{prefix}"
#                             "--without-headers",
      system 'make all'
      system 'make install'
	  system 'make install-info'
#      FileUtils.ln_sf binutils.prefix/"#{target}", prefix/"#{target}"
#      system 'make all-target-libgcc'
#      system 'make install-target-libgcc'
#      FileUtils.rm_rf share/"man"/"man7"
#	  system 'make install-info'
    end
  end
end
