SK = $$_PRO_FILE_PWD_/../../../Sky

SK_CORE = $$SK/src/SkCore/src

TARGET = HEVR

DESTDIR = $$_PRO_FILE_PWD_/bin

CONFIG += console

macx:CONFIG -= app_bundle

contains(QT_MAJOR_VERSION, 4) {
    QT += network script xml xmlpatterns
} else {
    QT += network xml xmlpatterns
}

QT -= gui

DEFINES += SK_CONSOLE SK_NO_QML SK_CORE_LIBRARY

contains(QT_MAJOR_VERSION, 4) {
    DEFINES += QT_4
} else {
    DEFINES += QT_LATEST
}

deploy|android {
    DEFINES += SK_DEPLOY
}

!win32-msvc*:QMAKE_CXXFLAGS += -std=c++11

unix:QMAKE_LFLAGS += "-Wl,-rpath,'\$$ORIGIN'"

include(src/global/global.pri)
include(src/controllers/controllers.pri)
include(src/kernel/kernel.pri)
include(src/io/io.pri)
include(src/thread/thread.pri)

include(src/3rdparty/qtsingleapplication/qtsingleapplication.pri)

INCLUDEPATH += $$SK/include/SkCore \
               include/HEVR \

# Windows dependency for ShellExecuteA
win32-msvc*:LIBS += shell32.lib