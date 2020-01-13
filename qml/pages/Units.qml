import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    property real scaleFactor: 1.0
    property real fontScaleFactor: 1.0
    property real gridUnit: scaleFactor * Screen.widthRatio * 12.0

    function dp(p) {
        return scaleFactor * p;
    }

    function gu(u) {
        return gridUnit * u;
    }

    function fx(s) {
        if (s === "x-small")
            return Theme.fontSizeTiny * scaleFactor * fontScaleFactor;
        if (s === "small")
            return Theme.fontSizeExtraSmall * scaleFactor * fontScaleFactor;
        if (s === "medium")
            return Theme.fontSizeSmall * scaleFactor * fontScaleFactor;
        if (s === "large")
            return Theme.fontSizeMedium * scaleFactor * fontScaleFactor;
        if (s === "x-large")
            return Theme.fontSizeLarge * scaleFactor * fontScaleFactor;
        if (s === "huge")
            return Theme.fontSizeHuge * scaleFactor * fontScaleFactor;

        return 0.0;
    }
}
