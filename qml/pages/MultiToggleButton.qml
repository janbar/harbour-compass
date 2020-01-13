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
    id: multiToggleButton
    width: 56
    height: 56

    property string name: ""
    property string currentValue: valueList[currentIndex]  // read-only
    property variant valueList: []  // needs to be a list, see QTBUG-10822
    property int currentIndex: 0 // read-write externally
    property string highlightHAlign: "left"    // or "right"
    property string highlightVAlign: "bottom"  // or "top"
    property bool nightmodeActive: false

    // Highlight graphics for the buttom press.
    // Numbers are based on experimenting...
    GlassItem {
        id: highlightImage
        anchors.left: buttonImage.left
        anchors.bottom: buttonImage.bottom
        anchors.leftMargin: (highlightHAlign === "left") ? -90 : -parent.width
        anchors.bottomMargin: (highlightVAlign === "bottom") ? -90 : -parent.width
        color: Theme.highlightColor
        radius: 6.0
        falloffRadius: 0.23
        width: units.gu(12.5)
        height: units.gu(12.5)
        visible: false
    }

    RGBIcon {
        id: buttonImage
        source: "../images/icon_" + name + "_" + currentValue + "_?.png"
        anchors.centerIn: parent
        width: units.gu(3.5); height: units.gu(3.5)
        color: nightmodeActive ? Theme.highlightColor : "white"
    }

    MouseArea {
        id: mouseArea
        anchors.centerIn: parent
        width: units.gu(4)
        height: units.gu(4)

        onPressed: {
            highlightImage.visible = true
        }
        onReleased: {
            if (mouseX > 0 && mouseY > 0 && mouseX < mouseArea.width && mouseY < mouseArea.height) {
                currentIndex = currentIndex >= valueList.length - 1 ? 0 : currentIndex += 1
                //console.log("MultiToggleButton: onReleased: changing to value ", currentValue)
            }
            highlightImage.visible = false
        }
        onExited: {
            highlightImage.visible = false
            //console.log("MultiToggleButton: onExited")
        }
        onCanceled: {
            highlightImage.visible = false
            //console.log("MultiToggleButton: onCanceled")
        }
    }
}
