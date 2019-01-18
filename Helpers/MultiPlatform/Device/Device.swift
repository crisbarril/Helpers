//
//  Device.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import CoreGraphics

public protocol DeviceProtocol {
    
    var screenBounds: CGRect { get }
    
    func recoverMainView<ViewClass>() -> ViewClass?
    
    func showAlert(info: AlertViewInfo)
}

public struct Device {
    
    public init() {
        
    }
    
    public var current: DeviceProtocol {
        #if os(iOS)
        
        return iOSDevice()
        
        #elseif os(watchOS)
        
        return watchOSDevice()
        
        #endif
    }
}
