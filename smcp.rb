require 'formula'

class Smcp < Formula
  homepage 'https://github.com/darconeous/smcp'
  url 'https://github.com/darconeous/smcp.git', :tag => 'smcp-0.6.2-release'
  head 'https://github.com/darconeous/smcp.git', :using => :git, :branch => 'master'
  sha1 'b8717692b2fd9c5ad1e1024136d555cbdd08d97f'
  version '0.6.2'

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
