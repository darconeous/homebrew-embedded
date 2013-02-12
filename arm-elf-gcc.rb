require 'formula'

class ArmElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  #url 'http://ftpmirror.gnu.org/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  #mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.7.2/gcc-4.7.2.tar.bz2'
  #sha1 'a464ba0f26eef24c29bcd1e7489421117fb9ee35'
  
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.3.2/gcc-4.3.2.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.3.2/gcc-4.3.2.tar.bz2'
  sha1 '787b566ad4f386a9896e2d5703e6ff5e7ccaca58'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'arm-elf-binutils'

  def install
    binutils = Formula.factory 'arm-elf-binutils'

    ENV['CC'] = 'llvm-gcc-4.2'
    ENV['CXX'] = 'llvm-g++-4.2'
    ENV['LD'] = 'llvm-gcc-4.2'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"
	
	target = 'arm-none-eabi'
#	target = 'arm-elf'
	
	gccbuildpath = buildpath
	newlib = Formula.factory 'newlib'
	newlib.brew do
		ohai "Moving newlib into GCC build tree"
		system "mv","newlib",gccbuildpath/"newlib"
		ohai "Moving libgloss into GCC build tree"
		system "mv","libgloss",gccbuildpath/"libgloss"
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
		system 'make install'
		system 'make install-info'
		FileUtils.rm_rf prefix/"lib/x86_64"
    end
  end
  def patches
	'https://gist.github.com/darconeous/2023cf3675bfa7abad8f/raw/gcc-2008q3-66.patch.bz2'
  end
end

__END__
diff --git a/gcc/config/arm/t-arm-elf b/gcc/config/arm/t-arm-elf
index 25b7acb..19eaf52 100644
--- a/gcc/config/arm/t-arm-elf
+++ b/gcc/config/arm/t-arm-elf
@@ -39,9 +39,9 @@ MULTILIB_MATCHES     =
 # Not quite true.  We can support hard-vfp calling in Thumb2, but how do we
 # express that here?  Also, we really need architecture v5e or later
 # (mcrr etc).
-MULTILIB_OPTIONS       += mfloat-abi=hard
-MULTILIB_DIRNAMES      += fpu
-MULTILIB_EXCEPTIONS    += *mthumb/*mfloat-abi=hard*
+#MULTILIB_OPTIONS       += mfloat-abi=hard
+#MULTILIB_DIRNAMES      += fpu
+#MULTILIB_EXCEPTIONS    += *mthumb/*mfloat-abi=hard*
 #MULTILIB_EXCEPTIONS    += *mcpu=fa526/*mfloat-abi=hard*
 #MULTILIB_EXCEPTIONS    += *mcpu=fa626/*mfloat-abi=hard*
 
@@ -53,12 +53,12 @@ MULTILIB_EXCEPTIONS    += *mthumb/*mfloat-abi=hard*
 # MULTILIB_DIRNAMES    += le be
 # MULTILIB_MATCHES     += mbig-endian=mbe mlittle-endian=mle
 # 
-# MULTILIB_OPTIONS    += mfloat-abi=hard/mfloat-abi=soft
-# MULTILIB_DIRNAMES   += fpu soft
-# MULTILIB_EXCEPTIONS += *mthumb/*mfloat-abi=hard*
+#MULTILIB_OPTIONS    += mfloat-abi=hard/mfloat-abi=soft
+#MULTILIB_DIRNAMES   += fpu soft
+#MULTILIB_EXCEPTIONS += *mthumb/*mfloat-abi=hard*
 # 
-# MULTILIB_OPTIONS    += mno-thumb-interwork/mthumb-interwork
-# MULTILIB_DIRNAMES   += normal interwork
+#MULTILIB_OPTIONS    += mno-thumb-interwork/mthumb-interwork
+#MULTILIB_DIRNAMES   += normal interwork
 # 
 # MULTILIB_OPTIONS    += fno-leading-underscore/fleading-underscore
 # MULTILIB_DIRNAMES   += elf under

