//
//  watchOSScreen.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import WatchKit

struct watchOSScreen: ScreenProtocol {
    var bounds: CGRect {
        return WKInterfaceDevice.current().screenBounds
    }
}
