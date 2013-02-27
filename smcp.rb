require 'formula'

class Smcp < Formula
  homepage 'https://github.com/darconeous/smcp'
  url 'https://github.com/darconeous/smcp.git', :tag => 'smcp-0.6.1-release'
  head 'https://github.com/darconeous/smcp.git', :using => :git, :branch => 'master'
  sha1 '93c8eb6c1952a126d437220814a8a8cb217d5efe'
  version '0.6.1'

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
