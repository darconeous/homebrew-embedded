require 'formula'

class AvrGdb < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gdb/gdb-7.7.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gdb/gdb-7.7.tar.gz'
  sha1 '5cdc83ada4fe2a37d775c36272187f08b95bebe6'

  depends_on 'avr-binutils'

  def install

    binutils = Formula.factory 'avr-binutils'

    args = [
            "--target=avr",
            "--program-prefix=avr-",
            "--prefix=#{prefix}",
            "--disable-debug",
            "--disable-dependency-tracking",
    ]

    system './configure', *args
    system 'make'
    system 'make install'

  end
end

 
