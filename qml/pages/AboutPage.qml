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

Page {
    id: page

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: column.height

        VerticalScrollDecorator { flickable: flickable }

        Column {
            id: column

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - (2 * Theme.paddingLarge)
            spacing: Theme.paddingLarge

            PageHeader {
                title: "Orienteering Compass"
            }
            Label {
                text: "Version 3.0.0"
                color: Theme.primaryColor
                wrapMode: TextEdit.WordWrap
                width: parent.width
            }
            Label {
                text: "By Jussi Vuorisalmi, <a href=\"mailto:jussi.vuorisalmi@iki.fi?subject=About%20Orienteering%20Compass%20SailfishOS\">jussi.vuorisalmi@iki.fi</a>"
                color: Theme.primaryColor
                linkColor: "#ffffff"
                wrapMode: TextEdit.WordWrap
                width: parent.width
                font.pixelSize: units.fx("small")
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
            Label {
                text: "Improved by Janbar, <a href=\"mailto:jlbarriere68@gmail.com?subject=About%20Compass%20SailfishOS\">jlbarriere68@gmail.com</a>"
                color: Theme.primaryColor
                linkColor: "#ffffff"
                wrapMode: TextEdit.WordWrap
                width: parent.width
                font.pixelSize: units.fx("small")
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }
            Label {
                text: "Source code available in <a href=\"https://github.com/janbar/harbour-compass\">https://github.com/janbar/harbour-compass</a> under the terms of GPLv3 license."
                color: Theme.primaryColor
                linkColor: "#ffffff"
                wrapMode: TextEdit.WordWrap
                width: parent.width
                font.pixelSize: units.fx("small")
                onLinkActivated: {
                    Qt.openUrlExternally(link)
                }
            }

        } // Column
    }
}
