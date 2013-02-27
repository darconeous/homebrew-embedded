require 'formula'

class CcTool < Formula
  homepage 'http://cctool.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/cctool/cc-tool-0.24-src.tgz'
  sha1 'c10c0d7652769ed754c549fd5f428a3519a4a78f'

  depends_on 'libusb'
  depends_on 'boost'
  depends_on 'pkg-config' => :build

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
