require 'formula'

class CcTool < Formula
  homepage 'http://cctool.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/cctool/cc-tool-0.26-src.tgz'
  sha256 'bdac339c0208c4eba33f9b129b545d97d1a6b3e393f0d94ea9f0d646712fc3dd'

  depends_on 'libusb'
  depends_on 'boost'
  depends_on 'pkg-config' => :build

  # Fix makefile
  patch :DATA

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end

__END__
diff -uNr a/Makefile.in b/Makefile.in
--- a/Makefile.in
+++ b/Makefile.in
@@ -224,7 +224,7 @@
 LD = @LD@
 LDFLAGS = @LDFLAGS@
 LIBOBJS = @LIBOBJS@
-LIBS = -s \
+LIBS = \
 	$(BOOST_FILESYSTEM_LIBS) \
 	$(BOOST_REGEX_LIBS) \
 	$(BOOST_SYSTEM_LIBS) \
