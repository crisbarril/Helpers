//
//  Device.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import CoreGraphics

public protocol ScreenProtocol {
    var bounds: CGRect { get }
}

public struct Device {
    
    public init() {
        
    }
    
    public var screen: ScreenProtocol {
        #if os(iOS)
        
        return iOSScreen()
        
        #elseif os(watchOS)
        
        return watchOSScreen()
        
        #endif
    }
}
