require 'formula'

class Smcp < Formula
  homepage 'https://github.com/darconeous/smcp'
  url 'https://github.com/darconeous/smcp.git', :tag => '0.6.5-release'
  head 'https://github.com/darconeous/smcp.git', :using => :git, :branch => 'master'
  #sha1 '3ee78de83293b43aa2a7c7396cef60d82929f98e'
  version '0.6.5'

  if build.head?
    depends_on 'autoconf' => :build
    depends_on 'automake' => :build
    depends_on 'libtool' => :build
  end

  def install
    system "[ -x configure ] || PATH=\"#{HOMEBREW_PREFIX}/bin:$PATH\" ./bootstrap.sh" if build.head?

    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}"

    system "make check"
    system "make install"
  end

  def test
    system "smcpctl -p 10342 cat -i coap://localhost:10342/"
  end
end
