//
//  AlertView.swift
//  Helpers
//
//  Created by Cristian on 17/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import Foundation

public struct AlertViewInfo {
    var title: String = ""
    var message: String = ""
    let style: AlertViewStyle
    let actions: [AlertActionInfo]
    
    public init(title: String, message: String, style: AlertViewStyle, actions: [AlertActionInfo]) {
        self.title = title
        self.message = message
        self.style = style
        self.actions = actions
    }
}

public struct AlertActionInfo {
    var title: String = ""
    let style: AlertActionStyle
    let action: (() -> Void)?
    
    public init(title: String, style: AlertActionStyle, action: (() -> Void)? ) {
        self.title = title
        self.style = style
        self.action = action
    }
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
