docker_dev:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/src -w /src swiftlambda/build /bin/bash

build:
	swift build -c release

run:
	./.build/release/ExampleLambda

clean:
	rm -rf ./build
	rm -rf ./output
	rm -rf ./LinuxLibraries

package:
	mkdir -p ./output
	cp ./shim/index.js ./output
	cp ./.build/release/ExampleLambda ./output
	cp -r ./LinuxLibraries ./output
	cd ./output && zip -r lambda_deployment_package.zip * 

deploy:
	cd terraform; terraform apply

gather_dependencies:
	echo "Copying executable's Linux dependencies from Kitura-Swift"
	mkdir -p ./LinuxLibraries
#	docker run --rm --volume "$(shell pwd)/swiftcommand:/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /root/swift-3.0.2-RELEASE-ubuntu14.04/usr/lib/swift/linux/*.so /usr/lib/x86_64-linux-gnu/libicudata.so.52 /usr/lib/x86_64-linux-gnu/libicui18n.so.52 /usr/lib/x86_64-linux-gnu/libicuuc.so.52 /usr/lib/x86_64-linux-gnu/libbsd.so /usr/lib/x86_64-linux-gnu/libxml2.so.2 /usr/lib/x86_64-linux-gnu/libxml2.so.2.9.1 /usr/lib/x86_64-linux-gnu/libcurl.so.4 /usr/lib/x86_64-linux-gnu/libidn.so.11 /usr/lib/x86_64-linux-gnu/librtmp.so.0 /lib/x86_64-linux-gnu/libssl.so.1.0.0 /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 /lib/x86_64-linux-gnu/libbsd.so.0 /usr/lib/x86_64-linux-gnu/libgnutls.so.26 /lib/x86_64-linux-gnu/libgcrypt.so.11 /usr/lib/x86_64-linux-gnu/libkrb5.so.3 /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 /usr/lib/x86_64-linux-gnu/libsasl2.so.2 /usr/lib/x86_64-linux-gnu/libgssapi.so.3 /usr/lib/x86_64-linux-gnu/libtasn1.so.6 /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 /lib/x86_64-linux-gnu/libkeyutils.so.1 /usr/lib/x86_64-linux-gnu/libheimntlm.so.0 /usr/lib/x86_64-linux-gnu/libkrb5.so.26 /src/LinuxLibraries'
# needed for Swift's stdlib
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /root/swift-3.0.2-RELEASE-ubuntu14.04/usr/lib/swift/linux/libFoundation.so /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /root/swift-3.0.2-RELEASE-ubuntu14.04/usr/lib/swift/linux/libdispatch.so /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /root/swift-3.0.2-RELEASE-ubuntu14.04/usr/lib/swift/linux/libswiftCore.so /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /root/swift-3.0.2-RELEASE-ubuntu14.04/usr/lib/swift/linux/libswiftGlibc.so /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libicudata.so.52 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libicui18n.so.52 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libicuuc.so.52 /src/LinuxLibraries'
# needed for Foundation (excluding ones that empirically are not needed and/or cause a seg fault)
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libbsd.so.0 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libc.so.6 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libcom_err.so.2 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libcrypt.so.1 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libdl.so.2 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libgcc_s.so.1 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libgcrypt.so.11 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libgpg-error.so.0 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libkeyutils.so.1 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/liblzma.so.5 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libm.so.6 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libpthread.so.0 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libresolv.so.2 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/librt.so.1 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libssl.so.1.0.0 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libutil.so.1 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /lib/x86_64-linux-gnu/libz.so.1 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libasn1.so.8 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libcurl.so.4 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libffi.so.6 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libgnutls.so.26 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libgssapi.so.3 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libhcrypto.so.4 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libheimbase.so.1 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libheimntlm.so.0 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libhx509.so.5 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libidn.so.11 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libkrb5.so.26 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libkrb5.so.3 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libroken.so.18 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/librtmp.so.0 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libsasl2.so.2 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 /src/LinuxLibraries'
#	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libtasn1.so.6 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libwind.so.0 /src/LinuxLibraries'
	docker run --rm --volume "$(shell pwd):/src" --workdir /src ibmcom/kitura-ubuntu /bin/bash -c 'cp /usr/lib/x86_64-linux-gnu/libxml2.so.2 /src/LinuxLibraries'

