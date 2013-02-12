require 'formula'

class Newlib < Formula
#  url 'ftp://sources.redhat.com/pub/newlib/newlib-1.19.0.tar.gz'
#  homepage 'http://sourceware.org/newlib/'
#  md5 '0966e19f03217db9e9076894b47e6601'

  url 'ftp://sources.redhat.com/pub/newlib/newlib-1.16.0.tar.gz'
  homepage 'http://sourceware.org/newlib/'
  sha1 '841edec33d19a9e549984982fb92445ee967e265'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
  def patches
	'https://gist.github.com/darconeous/2023cf3675bfa7abad8f/raw/newlib-2008q3-66.patch.bz2'
# fixes something small
#    DATA
  end
end
