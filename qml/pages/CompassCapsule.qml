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

Item {
    id: compassCapsule
    width: units.gu(31.25)
    height: units.gu(31.25)

    // Normalizing the angle is a bit unnecessary here...
    property real direction: normalize360(- __ringRotation)  // In degrees, 0-359
    property real azimuth: 0.0     // In degrees, set (bind) from outside, the compass needle follows this
    property bool changingDirection: false  // Is the direction (ring rotation) changing right now?

    property CompassSettings settings

    property real __previousAngle: 0
    property real __ringRotation: 0

    function normalize360(angle) {
        var semiNormalized = angle % 360
        return semiNormalized >= 0 ? semiNormalized : semiNormalized + 360
    }

    // Non-rotating stationary image on the background
    Image {
        id: basePicture
        source: "../images/compass_ring_base.png"
        anchors.centerIn: parent
        height: units.gu(31.25)
        width: units.gu(31.25)
    }

    // The turnable ring (or "housing") of the compass.
    // Consists of two overlaid images, first one with static colors and the
    // other on the top showed in the current ambient highlight color.
    Image {
        source: "../images/compass_ring_" + settings.compassScaleStr + "_" + settings.currentNightmodeStr + ".png"
        anchors.centerIn: parent
        height: units.gu(31)
        width: units.gu(31)
        rotation: __ringRotation
        Behavior on rotation { RotationAnimation { duration: 0; direction: RotationAnimation.Shortest } }
    }
    RGBIcon {
        source: "../images/compass_ring_lines_" + settings.currentNightmodeStr + "_?.png"
        color: changingDirection ? Theme.highlightColor : Theme.secondaryHighlightColor
        anchors.centerIn: parent
        width: settings.nightmodeActive ? units.gu(5.25) : units.gu(18.75)  // !!! Update whenever you regenerate the images !!!
        height: settings.nightmodeActive ? units.gu(31) : units.gu(22.125)  // !!! Update whenever you regenerate the images !!!
        rotation: __ringRotation
        Behavior on rotation { RotationAnimation { duration: 0; direction: RotationAnimation.Shortest } }
    }

    // The needle of the compass.
    // Consists of two overlaid images, first one with static colors and the
    // other on the top showed in the current ambient highlight color.
    Image {
        source: "../images/compass_needle_day_S.png"
        anchors.centerIn: parent
        visible: !settings.nightmodeActive
        rotation: - compassCapsule.azimuth
        width: units.gu(2.5); height: units.gu(24)
        Behavior on rotation { RotationAnimation { duration: 500; direction: RotationAnimation.Shortest; easing.type: Easing.InOutQuad; } }
    }
    RGBIcon {
        source: "../images/compass_needle_" + settings.currentNightmodeStr +  "_N_?.png"
        color: Theme.highlightColor
        anchors.centerIn: parent
        rotation: - compassCapsule.azimuth
        width: units.gu(2.5); height: units.gu(24)
        Behavior on rotation { RotationAnimation { duration: 500; direction: RotationAnimation.Shortest; easing.type: Easing.InOutQuad; } }
    }

    MouseArea {
        anchors.centerIn: parent
        width: compassCapsule.width
        height: compassCapsule.height
        property int __radius: width/2
        property int __ringWidth: units.gu(2.8125)      // approx
        property int __ringTouchExtra: units.gu(1.25)   // +- 20 pix

        function isTouchOnRing(touchX, touchY) {
            var fixedX = touchX - __radius
            var fixedY = touchY - __radius
            var distance = Math.sqrt(fixedX*fixedX + fixedY*fixedY)
            return distance > (__radius - __ringWidth - __ringTouchExtra) && distance < (__radius + __ringTouchExtra)
        }
        function xyToAngle(touchX, touchY) {
            return Math.atan2(touchY - __radius, touchX - __radius) * 180/Math.PI
        }

        onPressed: {
            if (isTouchOnRing(mouseX, mouseY)) {
                compassCapsule.changingDirection = true
                compassCapsule.__previousAngle = xyToAngle(mouseX, mouseY)
                //console.log("Starting direction change at:", mouseX, mouseY, " angle ", compassCapsule.__previousAngle)
            }
        }
        onReleased: {
            compassCapsule.changingDirection = false
            //console.log("Ended direction change: ", compass.direction.toFixed(1))
        }
        onPositionChanged: {
            if (compassCapsule.changingDirection) {
                compassCapsule.__ringRotation += xyToAngle(mouseX, mouseY) - compassCapsule.__previousAngle
                compassCapsule.__previousAngle = xyToAngle(mouseX, mouseY)
            }
        }
    }


}
