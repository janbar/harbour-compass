# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-compass

QT += sensors

CONFIG += sailfishapp

SOURCES += \
    src/genericcompass.cpp \
    src/harbour-compass.cpp \
    src/qsettingsitemqmlproxy.cpp \
    src/plugin.cpp

HEADERS += \
    src/qsettingsitemqmlproxy.h \
    src/genericcompass.h \
    src/plugin.h

OTHER_FILES += qml/harbour-compass.qml \
    rpm/harbour-compass.spec \
    rpm/harbour-compass.yaml \
    harbour-compass.desktop \
    qml/pages/CompassPage.qml \
    qml/pages/CoverPage.qml \
    qml/pages/CompassSensor.qml \
    qml/pages/AboutPage.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/CompassCapsule.qml \
    qml/pages/MultiToggleButton.qml \
    qml/pages/RGBIcon.qml \
    qml/pages/CompassSettings.qml \
    qml/pages/CalibrationPage.qml \
    qml/pages/SwitchRow.qml \
    qml/pages/Units.qml \
    COPYING.txt \
    README.txt
