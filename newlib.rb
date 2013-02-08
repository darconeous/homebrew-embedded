require 'formula'

class Newlib < Formula
  url 'ftp://sources.redhat.com/pub/newlib/newlib-1.19.0.tar.gz'
  homepage 'http://sourceware.org/newlib/'
  md5 '0966e19f03217db9e9076894b47e6601'


  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
