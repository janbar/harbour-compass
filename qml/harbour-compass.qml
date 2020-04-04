/*
  Copyright (C) 2014-2015 Jussi Vuorisalmi <jussi.vuorisalmi@iki.fi>
  All rights reserved.

  This file is part of the harbour-orienteeringcompass package.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


import QtQuick 2.0
import Sailfish.Silica 1.0
import QtSensors 5.0
import "pages"

ApplicationWindow
{
    id: appWindow

    Units {
        id: units
        scaleFactor: 1.2
        fontScaleFactor: 1.0
    }

    property bool applicationSuspended: false

    Connections {
        target: Qt.application
        onStateChanged: {
            switch (Qt.application.state) {
            case Qt.ApplicationSuspended:
            case Qt.ApplicationInactive:
                if (!applicationSuspended) {
                    console.log("Application state changed to suspended");
                    applicationSuspended = true;
                }
                break;
            case Qt.ApplicationHidden:
            case Qt.ApplicationActive:
                if (applicationSuspended) {
                    console.log("Application state changed to active");
                    applicationSuspended = false;
                }
                break;
            }
        }
    }

    CoverPage {
        id: coverPage
        compass: sharedCompass
        settings: sharedSettings
    }

    initialPage: Component { CompassPage { compass: sharedCompass; settings: sharedSettings } }
    cover: coverPage

    CompassSensor {
        id: sharedCompass
        settings: sharedSettings
        active: !applicationSuspended || coverPage.coverCompassActive
    }

    CompassSettings {
        id: sharedSettings
    }

    LightSensor {
        id: lightSensor

        active: !appWindow.applicationSuspended && sharedSettings.nightmodeSetting === "auto" &&
                sharedCompass.active

        // Jolla light sensor gives quite easily a zero level in low light...
        property real _nightThreshold: 0

        onReadingChanged: {
            //console.log("***Light reading: " + reading.illuminance);
            sharedSettings.sensorNigth = (reading.illuminance <= _nightThreshold) && active;
        }
        onActiveChanged: {
            console.log("***Light sensor: " + (active ? "START" : "STOP"));
            if (!active) {
                sharedSettings.sensorNigth = false; // Default to "day" when sensor is off
            }
        }
    }
}
