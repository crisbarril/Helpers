//
//  Device.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import Foundation

public enum Platforms {
    case iOS, watchOS
}

protocol ScreenProtocol {
    var bounds: CGRect { get }
}

public struct Device {
    
    let screen: ScreenProtocol
    
    init(for platform: Platforms) {
        switch platform {
        case .iOS:
            screen = iOSScreen()
        case .watchOS:
            screen = watchOSScreen()
        }
    }
}
