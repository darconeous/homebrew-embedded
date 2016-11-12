require 'formula'

class Avarice < Formula
  homepage 'http://http://avarice.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/avarice/avarice/avarice-2.13/avarice-2.13.tar.bz2'
  sha256 '25ba8f747fa0ea9f9d27ec7c3c2245622954aaec53345a84877527d955c07aef'

  depends_on 'libusb'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

  test do
    system "avarice"
  end
end
