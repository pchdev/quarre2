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
$ cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/path/to/qt-android/lib/cmake/Qt5 -DCMAKE_TOOLCHAIN_FILE=../CMake/android_toolchain.cmake -DOSSIA_PD=OFF -DOSSIA_MAX=OFF -DOSSIA_PYTHON=OFF -DOSSIA_QT=ON -DOSSIA_QML=ON -DOSSIA_STATIC=OFF -DOSSIA_DNSSD=OFF -DCMAKE_INSTALL_PREFIX=../../libossia-install-android-clang
$ make -j4
$ make install
```

#### Add ossia-qml to qt-android-clang qml folder
```bash
$ cp libossia-install-android-clang/Ossia /your/install/path/to/qt5-android/qml
```

## Specifications

### addresses 
#### common
* `/common/scenario/start (impulse)` : *notifies users that the scenario has started, activating, remote's scenario counter starts*
* `/common/scenario/end* (impulse)` : *notifies users that the scenario has ended, remote's scenario counter stops*
* `/common/scenario/stop (integer)` : *notifies users that the scenario has been forcefully stopped, because of an anomaly*
* `/common/scenario/reset (impulse)` : *reinitializes the scenario and the remotes to the first state of the scenario*
* `/common/scenario/pause (impulse)` : *notifies users that the scenario has been paused, all interactions are temporarily suspended*
* `/common/scenario/resume (impulse)` : *notifies users that the scenario and the active interactions are resumed*
* `/common/scenario/name (string)` : *the current scenario's name, displayed on the remote*
* `/common/scenario/scene/name (string)` : *the current scene's name, displayed on the remote*

#### user-interactions

* `/user/?/address (string)`
* `/user/?/interactions/next/incoming (string, string, string, int, int)` :
* `/user/?/interactions/next/cancel (int)` :
* `/user/?/interactions/next/begin (optional : (string, string, string, int))` :
* `/user/?/interactions/next/pause (impulse)` :
* `/user/?/interactions/next/resume (impulse)` :
* `/user/?/interactions/current/end (impulse)` :
* `/user/?/interactions/current/stop (int)` :
* `/user/?/interactions/current/pause (impulse)` :
* `/user/?/interactions/current/resume (impulse)` :
* `/user/?/interactions/current/force (string, string, string, int)` :

#### user-sensors

##### accelerometers
* `/user/?/sensors/accelerometers/available (boolean)` :
* `/user/?/sensors/accelerometers/active (boolean)` :
* `/user/?/sensors/accelerometers/data/xyz (float, float, float)` :
* `/user/?/sensors/accelerometers/data/x (float)` :
* `/user/?/sensors/accelerometers/data/x/active (boolean)` :
* `/user/?/sensors/accelerometers/data/y (float)` :
* `/user/?/sensors/accelerometers/data/y/active (boolean)` :
* `/user/?/sensors/accelerometers/data/z (float)` :
* `/user/?/sensors/accelerometers/data/z/active (boolean)` :

##### rotation sensors
* `/user/?/sensors/rotation/available (boolean)` :
* `/user/?/sensors/rotation/active (boolean)` :
* `/user/?/sensors/rotation/data/xyz (float, float, float)` :
* `/user/?/sensors/rotation/data/x (float)` :
* `/user/?/sensors/rotation/data/x/active (boolean)` :
* `/user/?/sensors/rotation/data/y (float)` :
* `/user/?/sensors/rotation/data/y/active (boolean)` :
* `/user/?/sensors/rotation/data/z (float)` :
* `/user/?/sensors/rotation/data/z/active (boolean)` :

##### proximity
* `/user/?/sensors/proximity/available (boolean)` :
* `/user/?/sensors/proximity/active (boolean)` :
* `/user/?/sensors/proximity/data/close (boolean)` :

#### user-gestures






