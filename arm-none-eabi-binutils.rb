require 'formula'

class ArmNoneEabiBinutils < Formula
    homepage 'http://gcc.gnu.org'

    url 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz'
    sha256 '7909a08eabdbaac0f7a22e9ede82a66ba70acd50629b045e705af864eef10b65'
#    url 'http://ftp.gnu.org/gnu/binutils/binutils-2.22.tar.gz'
#    sha1 '0e16a7492c0a194962ecd33fc80fa53ccfec5149'

    def install
        target = 'arm-none-eabi'

        args = [
            "--target=#{target}",
            "--prefix=#{prefix}",
            "--infodir=#{info}",
            "--mandir=#{man}",
            '--enable-interwork',
            '--enable-multilib',
#            '--disable-debug',
#            '--disable-werror',
            '--disable-nls',
            '--disable-libssp',
            "--disable-install-libiberty",
            "--enable-poison-system-directories",
        ]

        mkdir 'build' do
            system '../configure',*args
            system 'make all'
            system 'make install'
            FileUtils.rm_rf prefix/"lib/x86_64"
            FileUtils.rm_rf prefix/"share/man/man7"
        end
    end

end
