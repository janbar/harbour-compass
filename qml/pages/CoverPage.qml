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

CoverBackground {

    property CompassSensor compass
    property CompassSettings settings
    property bool coverCompassActive: true // Compass active based on the manual play/pause action?

    // Almost black background for the nightmode.
    // Needs to be here before and below all the other items.
    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.7
        visible: settings.nightmodeActive
    }

    Item {
        id: coverNeedle
        width: parent.width * 1.2
        height: width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter

        rotation: - compass.azimuth

        Rectangle {
            id: needleN
            height: parent.height * 0.5
            width: height / 3
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.highlightColor
            opacity: settings.nightmodeActive ? 0.2 : 0.3
        }
        Rectangle {
            id: needleS
            height: needleN.height
            width: needleN.width
            anchors.top: needleN.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            color: settings.nightmodeActive ? "black" : "white"
            opacity: settings.nightmodeActive ? 0.5 : 0.3
        }
    }

    Label {
        id: titleLabel
        text: compass.active ? Math.abs(compass.scaledAzimuth).toFixed(0) : "Compass<br>paused"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top        
        anchors.topMargin: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        horizontalAlignment: Text.AlignHCenter
        wrapMode: TextEdit.WordWrap
        font.pixelSize: compass.active ? Theme.fontSizeExtraLarge : Theme.fontSizeMedium
        color: compass.active ? (settings.nightmodeActive ? Theme.secondaryHighlightColor : Theme.highlightColor)
                              : (settings.nightmodeActive ? Theme.secondaryColor : Theme.primaryColor)
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: (compass.active) ? "image://theme/icon-cover-pause" : "image://theme/icon-cover-play"
            onTriggered: { coverCompassActive = !compass.active; }
        }
    }
}
