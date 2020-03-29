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
import QtSensors 5.2 as Legacy
import harbour.compass 1.0 as Builtin


// This is a non-visual item, a wrapper around the Qt Compass sensor element.
// It provides some additional logic for comparing the current azimuth vs.
// direction set by the user (to orienteer!) and provides the compass reading
// value in different formats according to current settings.
Item {
    id: compass
    property CompassSettings settings

    property bool active: true
    property real calibration: 0.0 // Default to 0%
    property real azimuth: 0.0     // current azimuth in degrees
    property real direction: 0.0   // the orienteering direction set by user, 0-359.99 degrees
    property bool rightDirection: false // (diff < 4.0)

    property real __normalDirection: normalize360(direction)  // 0-359.99 degrees for sure
    property real scaledDirection: scaleAngle(direction)
    property real scaledAzimuth: scaleAngle(azimuth)
    property real compassScaleVal: 360  // default, bound to settings later from outside

    function normalize360(angle) {
        var semiNormalized = angle % 360
        return semiNormalized < 0 ? 360 + semiNormalized : semiNormalized
    }
    function scaleAngle(angle360) {
        return angle360 / 360 * compassScaleVal
    }

    property real value: 0.0

    Builtin.Compass {
        id: compassBuiltin
        active: compass.active
        dataRate: 2
        onReadingChanged: {
            var n = normalize360(reading.azimuth);
            compass.azimuth = n;
            var d = Math.abs(n - compass.__normalDirection);
            compass.rightDirection = d < 4.0 || d > 356.0;
            compass.calibration = reading.calibrationLevel;
        }
    }
}
