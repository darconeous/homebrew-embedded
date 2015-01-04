require 'formula'

class CcTool < Formula
  homepage 'http://cctool.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/cctool/cc-tool-0.26-src.tgz'
  sha1 'f313e55f019ea5338438633f5b5e689b699343e1'

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
