//
//  AlertView.swift
//  Helpers
//
//  Created by Cristian on 17/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import Foundation

public struct AlertViewInfo {
    let title: String = ""
    let message: String = ""
    let style: AlertViewStyle
    let actions: [AlertActionInfo]
}

public struct AlertActionInfo {
    let title: String = ""
    let style: AlertActionStyle
    let action: (() -> Void)
}

public enum AlertActionStyle : Int {
    
    case `default`
    
    case cancel
    
    case destructive
}

public enum AlertViewStyle : Int {
    
    case alert
    
    case sideBySideButtonsAlert
    
    case actionSheet
}
