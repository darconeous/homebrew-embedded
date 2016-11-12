require 'formula'

class Newlib < Formula
  homepage 'http://sourceware.org/newlib/'
  #url 'ftp://sources.redhat.com/pub/newlib/newlib-2.0.0.tar.gz'
  #sha1 'ea6b5727162453284791869e905f39fb8fab8d3f'

  url 'ftp://sources.redhat.com/pub/newlib/newlib-1.19.0.tar.gz'
  sha256 '4f43807236b2274c220881ca69f7dc6aecc52f14bb32a6f03404d30780c25007'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
