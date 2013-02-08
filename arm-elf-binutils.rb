require 'formula'

class ArmElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz'
  sha1 '470c388c97ac8d216de33fa397d7be9f96c3fe04'

#  depends_on 'apple-gcc42' => :build

  def install
    ENV['CC'] = 'gcc'
    ENV['CXX'] = 'g++'
    ENV['CPP'] = 'cpp'
    ENV['LD'] = 'gcc'
	target = 'arm-none-eabi'
    mkdir 'build' do
      system '../configure', '--disable-nls', "--target=#{target}",
                             '--enable-gold=yes','--disable-werror',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
#      FileUtils.mv lib, libexec
    end
  end

end
