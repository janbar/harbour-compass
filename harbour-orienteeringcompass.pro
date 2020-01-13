# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-orienteeringcompass

CONFIG += sailfishapp

SOURCES += src/harbour-orienteeringcompass.cpp \
    src/qsettingsitemqmlproxy.cpp

OTHER_FILES += qml/harbour-orienteeringcompass.qml \
    rpm/harbour-orienteeringcompass.spec \
    rpm/harbour-orienteeringcompass.yaml \
    harbour-orienteeringcompass.desktop \
    qml/pages/CompassPage.qml \
    qml/pages/CoverPage.qml \
    qml/pages/OrientCompassSensor.qml \
    qml/pages/AboutPage.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/CompassCapsule.qml \
    qml/pages/MultiToggleButton.qml \
    TODO.txt \
    qml/pages/RGBIcon.qml \
    qml/pages/CompassSettings.qml \
    qml/pages/CalibrationPage.qml \
    qml/pages/SwitchRow.qml \
    qml/pages/Units.qml \
    COPYING.txt \
    README.txt

HEADERS += \
    src/qsettingsitemqmlproxy.h

