//
//  iOSScreen.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import Foundation

struct iOSScreen: ScreenProtocol {
    var bounds: CGRect {
        return UIScreen.main.bounds
    }
}

extension Device {
    
    var screen: ScreenProtocol {
        return iOSScreen()
    }
}
