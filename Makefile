# Copyright (c) 2014-2018, The Monero Project
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this list of
#    conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, this list
#    of conditions and the following disclaimer in the documentation and/or other
#    materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors may be
#    used to endorse or promote products derived from this software without specific
#    prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
# THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
# THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

all: release-all

cmake-debug:
	mkdir -p build/debug
	cd build/debug && cmake -D CMAKE_BUILD_TYPE=Debug ../..

debug: cmake-debug
	cd build/debug && $(MAKE)

# Temporarily disable some tests:
#  * libwallet_api_tests fail (Issue #895)
debug-test:
	mkdir -p build/debug
	cd build/debug && cmake -D BUILD_TESTS=ON -D CMAKE_BUILD_TYPE=Debug ../.. && $(MAKE) && $(MAKE) ARGS="-E libwallet_api_tests" test

debug-all:
	mkdir -p build/debug
	cd build/debug && cmake -D BUILD_TESTS=ON -D BUILD_SHARED_LIBS=OFF -D CMAKE_BUILD_TYPE=Debug ../.. && $(MAKE)

debug-static-all:
	mkdir -p build/debug
	cd build/debug && cmake -D BUILD_TESTS=ON -D STATIC=ON -D CMAKE_BUILD_TYPE=Debug ../.. && $(MAKE)

debug-static-win64:
	mkdir -p build/debug
	cd build/debug && cmake -G "MSYS Makefiles" -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=Debug -D BUILD_TAG="win-x64" -D CMAKE_TOOLCHAIN_FILE=../../cmake/64-bit-toolchain.cmake -D MSYS2_FOLDER=c:/msys64 ../.. && $(MAKE)

debug-static-win32:
	mkdir -p build/debug
	cd build/debug && cmake -G "MSYS Makefiles" -D STATIC=ON -D ARCH="i686" -D BUILD_64=OFF -D CMAKE_BUILD_TYPE=Debug -D BUILD_TAG="win-x32" -D CMAKE_TOOLCHAIN_FILE=../../cmake/32-bit-toolchain.cmake -D MSYS2_FOLDER=c:/msys32 ../.. && $(MAKE)

cmake-release:
	mkdir -p build/release
	cd build/release && cmake -D CMAKE_BUILD_TYPE=Release ../..

release: cmake-release
	cd build/release && $(MAKE)

release-test:
	mkdir -p build/release
	cd build/release && cmake -D BUILD_TESTS=ON -D CMAKE_BUILD_TYPE=release ../.. && $(MAKE) && $(MAKE) test

release-all:
	mkdir -p build/release
	cd build/release && cmake -D BUILD_TESTS=ON -D CMAKE_BUILD_TYPE=release ../.. && $(MAKE)

release-static:
	mkdir -p build/release
	cd build/release && cmake -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=release ../.. && $(MAKE)

coverage:
	mkdir -p build/debug
	cd build/debug && cmake -D BUILD_TESTS=ON -D CMAKE_BUILD_TYPE=Debug -D COVERAGE=ON ../.. && $(MAKE) && $(MAKE) test

# Targets for specific prebuilt builds which will be advertised for updates by their build tag

release-static-linux-armv6:
	mkdir -p build/release
	cd build/release && cmake -D BUILD_TESTS=OFF -D ARCH="armv6zk" -D STATIC=ON -D BUILD_64=OFF -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="linux-armv6" ../.. && $(MAKE)

release-static-linux-armv7:
	mkdir -p build/release
	cd build/release && cmake -D BUILD_TESTS=OFF -D ARCH="armv7-a" -D STATIC=ON -D BUILD_64=OFF -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="linux-armv7" ../.. && $(MAKE)

release-static-android:
	mkdir -p build/release
	cd build/release && cmake -D BUILD_TESTS=OFF -D ARCH="armv7-a" -D STATIC=ON -D BUILD_64=OFF -D CMAKE_BUILD_TYPE=release -D ANDROID=true -D INSTALL_VENDORED_LIBUNBOUND=ON -D BUILD_TAG="android" ../.. && $(MAKE)

release-static-linux-armv8:
	mkdir -p build/release
	cd build/release && cmake -D BUILD_TESTS=OFF -D ARCH="armv8-a" -D STATIC=ON -D BUILD_64=ON -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="linux-armv8" ../.. && $(MAKE)

release-static-linux-x86_64:
	mkdir -p build/release
	cd build/release && cmake -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="linux-x64" ../.. && $(MAKE)

release-static-freebsd-x86_64:
	mkdir -p build/release
	cd build/release && cmake -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="freebsd-x64" ../.. && $(MAKE)

release-static-mac-x86_64:
	mkdir -p build/release
	cd build/release && cmake -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="mac-x64" ../.. && $(MAKE)

release-static-linux-i686:
	mkdir -p build/release
	cd build/release && cmake -D STATIC=ON -D ARCH="i686" -D BUILD_64=OFF -D CMAKE_BUILD_TYPE=release -D BUILD_TAG="linux-x86" ../.. && $(MAKE)

release-static-win64:
	mkdir -p build/release
	cd build/release && cmake -G "MSYS Makefiles" -D STATIC=ON -D ARCH="x86-64" -D BUILD_64=ON -D CMAKE_BUILD_TYPE=Release -D BUILD_TAG="win-x64" -D CMAKE_TOOLCHAIN_FILE=../../cmake/64-bit-toolchain.cmake -D MSYS2_FOLDER=c:/msys64 ../.. && $(MAKE)

release-static-win32:
	mkdir -p build/release
	cd build/release && cmake -G "MSYS Makefiles" -D STATIC=ON -D ARCH="i686" -D BUILD_64=OFF -D CMAKE_BUILD_TYPE=Release -D BUILD_TAG="win-x32" -D CMAKE_TOOLCHAIN_FILE=../../cmake/32-bit-toolchain.cmake -D MSYS2_FOLDER=c:/msys32 ../.. && $(MAKE)

package-debian-amd64-monerod: release-static-linux-x86_64
	mkdir -p build/packaging/amd64/monerod/DEBIAN
	echo "Package: monerod" > build/packaging/amd64/monerod/DEBIAN/control
	#echo Version: `cat src/version.cpp.in | grep "#define DEF_MONERO_VERSION \"" | cut -d'"' -f2`-`git rev-parse HEAD | cut -c1-8` >> build/packaging/amd64/monerod/DEBIAN/control #this echo takes actual branch from version.cpp.in
	echo Version: `cat src/version.cpp.in | grep "#define DEF_MONERO_VERSION \"" | cut -d'"' -f2 | cut -d'-' -f1`-`git branch | grep "*" | cut -d' ' -f 2`-`git rev-parse HEAD | cut -c1-8` >> build/packaging/amd64/monerod/DEBIAN/control #this echo takes actual branch from git
	cd build/packaging/amd64/monerod/DEBIAN/
	echo "Section: Miscellaneous" >> control
	echo "Priority: optional" >> control
	echo "Architecture: amd64" >> control
	echo "Depends: libssl-dev, pkg-config, libzmq3-dev, libsodium-dev, libminiupnpc-dev, libunwind8-dev, liblzma-dev, libreadline-dev, libldns-dev, libexpat1-dev" >> control
	echo "Maintainer: Jorropo <jorropo.pgm@gmail.com>" >> control #The email maybe need to be changed by the monero fundation general email, but I don't find it, (me (Jorropo) can post on repo all produced .deb, if I do, stay like that and remove this comment)
	echo "Description: Monero deamon" >> control
	echo "Homepage: https://getmonero.org/" >> control
	echo "Bugs: https://github.com/monero-project/monero/issues" >> control
	cd ../
	mkdir -p usr/bin
	cp ../../release/bin/monerod usr/bin/
	cd ../
	dpkg-deb --build monerod

package-debian-amd64-monero-wallet-cli: release-static-linux-x86_64
	mkdir -p build/packaging/amd64/monero-wallet-cli/DEBIAN
	mkdir -p build/packaging/amd64/monero-wallet-cli/usr/bin

package-debian-amd64-monerod-wallet-rpc: release-static-linux-x86_64
	mkdir -p build/packaging/amd64/monero-wallet-rpc/DEBIAN
	mkdir -p build/packaging/amd64/monero-wallet-rpc/usr/bin

package-debian-amd64-monero-blockchain-utils: release-static-linux-x86_64
	mkdir -p build/packaging/amd64/monero-blockchain-utils/DEBIAN
	mkdir -p build/packaging/amd64/monero-blockchain-utils/usr/bin

fuzz:
	mkdir -p build/fuzz
	cd build/fuzz && cmake -D STATIC=ON -D SANITIZE=ON -D BUILD_TESTS=ON -D USE_LTO=OFF -D CMAKE_C_COMPILER=afl-gcc -D CMAKE_CXX_COMPILER=afl-g++ -D ARCH="x86-64" -D CMAKE_BUILD_TYPE=fuzz -D BUILD_TAG="linux-x64" ../.. && $(MAKE)

clean:
	@echo "WARNING: Back-up your wallet if it exists within ./build!" ; \
        read -r -p "This will destroy the build directory, continue (y/N)?: " CONTINUE; \
	[ $$CONTINUE = "y" ] || [ $$CONTINUE = "Y" ] || (echo "Exiting."; exit 1;)
	rm -rf build

tags:
	ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ src contrib tests/gtest

.PHONY: all cmake-debug debug debug-test debug-all cmake-release release release-test release-all clean tags
