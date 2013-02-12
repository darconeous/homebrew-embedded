require 'formula'

class AvrLibc < Formula
  url 'http://download.savannah.gnu.org/releases/avr-libc/avr-libc-1.8.0.tar.bz2'
  homepage 'http://www.nongnu.org/avr-libc/'
  sha256 '67a36bdb43a16f9b0512ba09584d4785f9bce6c057393f1020a5552e096e34ce'

  depends_on 'avr-gcc'

  def install
    # brew's build environment is in our way
    ENV.delete 'CFLAGS'
    ENV.delete 'CXXFLAGS'
    ENV.delete 'LD'
    ENV.delete 'CC'
    ENV.delete 'CXX'

    avr_gcc = Formula.factory('avr-gcc')
    build = `./config.guess`.chomp
    system "./configure", "--build=#{build}", "--prefix=#{prefix}", "--host=avr"
    system "make"
    system "make install"
    avr = File.join prefix, 'avr'
    # copy include and lib files where avr-gcc searches for them
    # this wouldn't be necessary with a standard prefix
    ohai "copying #{avr} -> #{avr_gcc.prefix}"
    cp_r avr, avr_gcc.prefix
  end
end

