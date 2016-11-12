require 'formula'

class Arm2008q3Newlib < Formula
  url 'ftp://sources.redhat.com/pub/newlib/newlib-1.16.0.tar.gz'
  homepage 'http://sourceware.org/newlib/'
  sha256 'db426394965c48c1d29023e1cc6d965ea6b9a9035d8a849be2750ca4659a3d07'

  def install
    onoe "This version of newlib is not directly installable. You probably want to install arm-2008q3-gcc instead."
    raise ErrorDuringExecution
  end

  def patches
	[
		'https://gist.github.com/darconeous/2023cf3675bfa7abad8f/raw/newlib-2008q3-66.patch.bz2',
		'https://gist.github.com/darconeous/2023cf3675bfa7abad8f/raw/newlib2.patch'
	]
  end
end
