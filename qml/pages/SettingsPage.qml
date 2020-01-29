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

    property CompassSettings settings

    SilicaFlickable {
        id: flickable
        anchors.fill: parent
        contentHeight: pageColumn.height

        VerticalScrollDecorator { flickable: flickable }

        Column {
            id: pageColumn

            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - (2 * Theme.paddingLarge)
            spacing: Theme.paddingSmall
            property int column3width: (pageColumn.width - (2 * Theme.paddingSmall)) / 3

            PageHeader {
                title: "Settings"
            }

            SectionHeader {
                text: "Compass scale"
            }

            SwitchRow {
                id: scaleRow
                contentWidth: pageColumn.width
                name: "scale"
                valueList: [ "360", "400", "6000" ]
                labelList: [ "degree", "gradian", "mil" ]
                // NOTE: currentIndex set by page.onStatusChanged below
                onCurrentValueChanged: {
                    if (page.status === PageStatus.Active) {
                        //console.log("SettingsPage SwitchRow valueChanged: " + currentValue);
                        settings.compassScaleStr = currentValue
                    }
                }
            }

            SectionHeader {
                text: "Night mode"
            }

            SwitchRow {
                id: nightmodeRow
                contentWidth: pageColumn.width
                name: "nightmode"
                valueList: [ "auto", "day", "night" ]
                labelList: [ "auto", "day", "night" ]
                // NOTE: currentIndex set by page.onStatusChanged below
                onCurrentValueChanged: {
                    if (page.status === PageStatus.Active) {
                        //console.log("SettingsPage SwitchRow valueChanged: " + currentValue);
                        settings.nightmodeSetting = currentValue
                    }
                }
            }
        } // Column
    }

    onStatusChanged: {
        if (page.status === PageStatus.Activating) {
            nightmodeRow.currentIndex = settings.nightmodeIndex;
            scaleRow.currentIndex = settings.compassScaleIndex;
        }
    }
}
