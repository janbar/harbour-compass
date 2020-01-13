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
import QtSensors 5.0


// This is a non-visual item, a wrapper around the Qt Compass sensor element.
// It provides some additional logic for comparing the current azimuth vs.
// direction set by the user (to orienteer!) and provides the compass reading
// value in different formats according to current settings.
Item {
    id: compass

    property alias active: activeSensor.running
    property real calibration: 0.0 // Default to 100%
    property real azimuth: 0.0     // current azimuth in degrees
    property real direction: 0.0   // the orienteering direction set by user, 0-359.99 degrees
    property bool rightDirection: false // (Math.abs(azimuth - direction) < 2.0 || Math.abs(azimuth - direction) > 358.0)

    property real __normalDirection: normalize360(direction)  // 0-359.99 degrees for sure
    property real scaledDirection: scaleAngle(direction)
    property real scaledAzimuth: scaleAngle(azimuth)
    property real compassScaleVal: 360  // default, bound to settings later from outside

    function normalize360(angle) {
        var semiNormalized = angle % 360
        return semiNormalized >= 0 ? semiNormalized : semiNormalized + 360
    }
    function scaleAngle(angle360) {
        return angle360 / 360 * compassScaleVal
    }

    property real value: 0.0

    Compass {
        id: compassSensor

        onReadingChanged: {
            compass.value = reading.azimuth;
            var c = reading.calibrationLevel;
            if (c > compass.calibration)
                compass.calibration = c;
            compassReader.start();
        }
    }

    Timer {
        id: compassReader
        interval: 500
        onTriggered: {
            var n = compass.value;
            compass.azimuth = n;
            compass.rightDirection = (Math.abs(n - compass.__normalDirection) < 4.0 || Math.abs(n - compass.__normalDirection) > 356.0);
        }
    }

    //!FIXME: Sony Xperia 10 needs challenge
    Timer {
        id: activeSensor
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            compassSensor.active = false;
            compassSensor.active = true;
        }
        onRunningChanged: {
            compassSensor.active = running;
        }
    }
}
