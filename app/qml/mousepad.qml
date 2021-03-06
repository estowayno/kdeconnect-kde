/*
 * Copyright 2015 Aleix Pol Gonzalez <aleixpol@kde.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.0 as Kirigami
import org.kde.kdeconnect 1.0

Kirigami.Page
{
    id: mousepad
    title: i18n("Remote Control")
    property QtObject pluginInterface
    property QtObject device

    ColumnLayout
    {
        anchors.fill: parent

        MouseArea {
            id: area
            Layout.fillWidth: true
            Layout.fillHeight: true
            property var lastPos: Qt.point(-1, -1)

            onClicked: mousepad.pluginInterface.sendCommand("singleclick", true);

            onPositionChanged: {
                if (lastPos.x > -1) {
    //                 console.log("move", mouse.x, mouse.y, lastPos)
                    var delta = Qt.point(mouse.x-lastPos.x, mouse.y-lastPos.y);

                    pluginInterface.moveCursor(delta);
                }
                lastPos = Qt.point(mouse.x, mouse.y);
            }
            onReleased: {
                lastPos = Qt.point(-1, -1)
            }
        }

        RemoteKeyboard {
            device: mousepad.device
            Layout.fillWidth: true
            visible: remoteState
        }

        RowLayout {
            Layout.fillWidth: true

            Button {
                Layout.fillWidth: true
                icon.name: "input-mouse-click-left"
                onClicked: mousepad.pluginInterface.sendCommand("singleclick", true);
            }
            Button {
                Layout.fillWidth: true
                icon.name: "input-mouse-click-middle"
                onClicked: mousepad.pluginInterface.sendCommand("middleclick", true);
            }
            Button {
                Layout.fillWidth: true
                icon.name: "input-mouse-click-right"
                onClicked: mousepad.pluginInterface.sendCommand("rightclick", true);
            }
        }
    }
}
