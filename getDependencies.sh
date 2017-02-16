echo "Copying executables Linux dependencies"
mkdir ./LinuxLibraries
# needed for Swifts stdlib
cp /usr/lib/swift/linux/libFoundation.so /src/LinuxLibraries
cp /usr/lib/swift/linux/libdispatch.so /src/LinuxLibraries
cp /usr/lib/swift/linux/libswiftCore.so /src/LinuxLibraries
cp /usr/lib/swift/linux/libswiftGlibc.so /src/LinuxLibraries

# needed for Foundation (excluding ones that empirically are not needed and/or cause a seg fault)
cp -r /usr/lib/x86_64-linux-gnu/* /src/LinuxLibraries
cp /lib/x86_64-linux-gnu/libc.so.6 /src/LinuxLibraries
cp /lib/x86_64-linux-gnu/libbsd.so.0 /src/LinuxLibraries
cp /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /src/LinuxLibraries
cp /lib/x86_64-linux-gnu/libgcrypt.so.20 /src/LinuxLibraries
cp /lib/x86_64-linux-gnu/libkeyutils.so.1 /src/LinuxLibraries
cp /lib/x86_64-linux-gnu/libssl.so.1.0.0 /src/LinuxLibraries
