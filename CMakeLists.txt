project(quarre-remote C CXX)

cmake_minimum_required(VERSION 3.7)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake_modules)

find_package(Qt5 REQUIRED COMPONENTS Quick Core QuickControls2)
find_package(Qt5QuickCompiler)

set(QUARRE_REMOTE_CXX_HEADERS)
set(QUARRE_REMOTE_CXX_IMPLEMENTATIONS)

set(QUARRE_REMOTE_RESOURCES
    ${CMAKE_SOURCE_DIR}/resources/qml/qml.qrc
    ${CMAKE_SOURCE_DIR}/resources/images/images.qrc
    ${CMAKE_SOURCE_DIR}/resources/fonts/fonts.qrc)

set(QUARRE_REMOTE_QML_SRCS
    ${CMAKE_SOURCE_DIR}/main.qml
    ${CMAKE_SOURCE_DIR}/resources/qml/sensors.qml)

#add_subdirectory(thirdparty)

add_executable(quarre-remote ${CMAKE_SOURCE_DIR}/main.cpp ${QUARRE_REMOTE_QML_SRCS})
qt5_use_modules(quarre-remote Quick Core QuickControls2)

add_custom_command(TARGET quarre-remote PRE_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/resources $<TARGET_FILE_DIR:quarre-remote>)

configure_file(main.qml main.qml COPYONLY)

install(FILES ${QUARRE_REMOTE_QML_SRCS}
    DESTINATION resources/qml)
