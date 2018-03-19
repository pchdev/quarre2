# quarre-remote application

## Building

### Android

#### Install Android SDK & NDK (from Android studio e.g.)

#### Building qt5-android-clang version (currently 5.10.0) from github sources
```bash
$ git clone https://github.com/qt/qt5.git
$ git checkout 5.10
$ cd qt5
$ ./init-repository
$ ./configure -opensource -license-confirm -xplatform 'android-clang' -c++std c++14 \
              -nomake examples -nomake tests  \
              -android-ndk /your/path/to/ndk -android-sdk /your/path/to/sdk \
              -android-arch armeabi-v7a -android-ndk-platform android-21 \
              -prefix /your/install/path/qt5-android-clang \
              -no-warnings-are-errors -opengl es2
$ make -j4
$ make install
```

#### Building libossia
```bash
$ git clone --recursive https://github.com/OSSIA/libossia.git
$ cd libossia
```
- edit the android_toolchain.cmake file, located in libossia/CMake, setting your specs + the correct android-ndk path

```bash
$ mkdir build
$ cd build
$ cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../CMake/android_toolchain.cmake -DOSSIA_PD=OFF -DOSSIA_MAX=OFF -DOSSIA_PYTHON=OFF -DOSSIA_QT=ON -DOSSIA_QML=ON -DOSSIA_STATIC=OFF -DOSSIA_DNSSD=OFF -DCMAKE_INSTALL_PREFIX=../../libossia-install-android-clang
$ make -j4
$ make install
```

#### Add ossia-qml to qt-android-clang qml folder
```bash
$ cp libossia-install-android-clang/Ossia /your/install/path/to/qt5-android/qml
```
