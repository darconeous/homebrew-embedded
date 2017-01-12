require 'formula'

class Avarice < Formula
  homepage 'http://http://avarice.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/avarice/avarice/avarice-2.13/avarice-2.13.tar.bz2'
  #sha1 'b0bc56d587600651c0e61be676177b2eebfad3ae'
  sha256 'a14738fe78e1a0a9321abcca7e685a00ce3ced207622ccbcd881ac32030c104a'

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
