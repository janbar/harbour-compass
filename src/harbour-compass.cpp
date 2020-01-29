/*
  Copyright (C) 2014 Jussi Vuorisalmi <jussi.vuorisalmi@iki.fi>
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

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QtQml>
#include <QQmlEngine>
#include <sailfishapp.h>
#include "qsettingsitemqmlproxy.h"
#include "plugin.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<QSettingsItemQmlProxy>("harbour.compass", 1, 0, "SettingsItem");
    qmlRegisterType<BuiltInCompass>("harbour.compass", 1, 0, "Compass");

    QScopedPointer<BuiltInSensorPlugin> sensor(new BuiltInSensorPlugin());
    sensor->registerSensors();

    return SailfishApp::main(argc, argv);
}

