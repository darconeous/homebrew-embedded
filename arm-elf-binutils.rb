require 'formula'

class ArmElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz'
  sha1 '470c388c97ac8d216de33fa397d7be9f96c3fe04'

#  depends_on 'apple-gcc42' => :build

  def install
    ENV['CC'] = 'llvm-gcc-4.2'
    ENV['CXX'] = 'llvm-g++-4.2'
    ENV['CPP'] = 'llvm-cpp-4.2'
    ENV['LD'] = 'llvm-gcc-4.2'

	target = 'arm-none-eabi'
	target = 'arm-elf'
	
	args = [
		'--disable-debug',
		'--disable-nls',
		'--disable-wwerror',
        "--infodir=#{info}",
        "--mandir=#{man}",
		"--disable-install-libiberty",
		"--enable-interwork",
		"--enable-multilib",

#		'--enable-gold=yes',
	]
    
	mkdir 'build' do
      system '../configure', "--target=#{target}", "--prefix=#{prefix}", *args
      system 'make all'
      system 'make install'
	  FileUtils.rm_rf prefix/"lib/x86_64"
    end
  end

end
