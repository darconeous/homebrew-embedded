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

    ENV['CC'] = 'llvm-gcc-4.2'
    ENV['CXX'] = 'llvm-g++-4.2'
    ENV['CPP'] = 'llvm-cpp-4.2'
    ENV['LD'] = 'llvm-gcc-4.2'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"
	
	target = 'arm-none-eabi'
	target = 'arm-elf'

	newlib = Formula.factory 'newlib'
	dwnldr = newlib.downloader
	dwnldr.fetch # fetch (uses cache!)
	dwnldr.stage # unpack

	system "ln","-s","#{Dir["newlib*"]}/libgloss"
	system "ln","-s","#{Dir["newlib*"]}/newlib"
	
	args = [
		"--enable-obsolete",
		'--disable-nls',
		'--disable-wwerror',
		'--disable-debug',
		
		"--enable-languages=c",	

        "--enable-fpu",
		"--enable-biendian",
		"--enable-interwork",
		"--enable-multilib",
		"--with-newlib",

		"--enable-version-specific-runtime-libs",
        "--infodir=#{info}",
        "--mandir=#{man}",
		
		"--without-included-gettext",
		"--disable-install-libiberty",
		"--disable-__cxa_atexit",
		"--disable-libgfortran",
		"--disable-libssb",
		"--disable-shared",
		"--disable-libstdcxx-pch",

		# !?!?
		"--with-as=#{binutils.prefix}/bin/#{target}-as",
	]

	mkdir 'build' do
		system '../configure', "--target=#{target}", "--prefix=#{prefix}", *args
		system 'make all'
		system 'make install'
		system 'make install-info'
    end
  end
  def patches
    # fixes something small
    DATA
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
+MULTILIB_OPTIONS    += mfloat-abi=hard/mfloat-abi=soft
+MULTILIB_DIRNAMES   += fpu soft
+MULTILIB_EXCEPTIONS += *mthumb/*mfloat-abi=hard*
 # 
-# MULTILIB_OPTIONS    += mno-thumb-interwork/mthumb-interwork
-# MULTILIB_DIRNAMES   += normal interwork
+MULTILIB_OPTIONS    += mno-thumb-interwork/mthumb-interwork
+MULTILIB_DIRNAMES   += normal interwork
 # 
 # MULTILIB_OPTIONS    += fno-leading-underscore/fleading-underscore
 # MULTILIB_DIRNAMES   += elf under

