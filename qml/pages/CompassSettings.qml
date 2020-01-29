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
import harbour.compass 1.0 as Builtin

// Non-viaual item
Item {
    id: settings

    property variant scaleStrList: [ "360", "400", "6000" ]
    property variant scaleLabelList: [ "degree", "gradian", "mil" ]

    property string compassScaleStr: qSettingScale.value  // Read in the initial settings via QSettings
    property real compassScaleVal: 1 * compassScaleStr  // read-only
    property int compassScaleIndex: scaleStrList.indexOf(compassScaleStr)

    property variant nightmodeStrList: [ "auto", "day", "night" ]
    property variant nightmodeLabelList: [ "auto", "day", "night" ]

    property string nightmodeSetting: qSettingNightmode.value // Read in the initial settings via QSettings
    property bool sensorNigth: false  // Is it now night according to the light sensor
    property bool nightmodeActive: (nightmodeSetting === "night") || ((nightmodeSetting === "auto") && sensorNigth)
    property string currentNightmodeStr: nightmodeActive ? "night" : "day"
    property int nightmodeIndex: nightmodeStrList.indexOf(nightmodeSetting)

    property bool calibrationTest: qSettingCalibrationTest.value

    //onCompassScaleStrChanged: { console.log("Compass scale: " + compassScaleStr); }
    //onCompassScaleIndexChanged: { console.log("Compass scale index: " + compassScaleIndex); }

    Builtin.SettingsItem {
        id: qSettingScale
        key: "compassScale"
        defaultValue: "360"
    }
    Builtin.SettingsItem {
        id: qSettingNightmode
        key: "nightmode"
        defaultValue: "auto"
    }
    Builtin.SettingsItem {
        id: qSettingCalibrationTest
        key: "calibrationTest"
        defaultValue: false
    }

    Component.onCompleted: {
//        compassScaleStr = qSettingScale.value
//        nightmodeSetting = qSettingNightmode.value
//        calibrationTest = qSettingCalibrationTest.value;
//        console.log("CompassSettings: Component.onCompleted: scale value: " + compassScaleStr);
//        console.log("CompassSettings: Component.onCompleted: nightmode value: " + nightmodeSetting);
//        console.log("CompassSettings: Component.onCompleted: calibrationTest: " + qSettingCalibrationTest.value + " " + calibrationTest);
    }
    Component.onDestruction: {
        console.log("Settings: writing settings...");
        qSettingScale.value = compassScaleStr;
        qSettingNightmode.value = nightmodeSetting;
    }
}
