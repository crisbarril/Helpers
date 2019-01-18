//
//  watchOSDevice.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import WatchKit

struct watchOSDevice: DeviceProtocol {
    var screenBounds: CGRect {
        return WKInterfaceDevice.current().screenBounds
    }
    
    func recoverMainView<ViewClass>() -> ViewClass? {
        return WKExtension.shared().rootInterfaceController as? ViewClass
    }
    
    func showAlert(info: AlertViewInfo) {
        
        let style = recoverAlertControllerStyle(customStyle: info.style)
        var actions = [WKAlertAction]()
        
        for actionInfo in info.actions {
            
            let actionStyle = recoverAlertActionStyle(customStyle: actionInfo.style)
            
            let action = WKAlertAction(title: actionInfo.title, style: actionStyle) {
                actionInfo.action()
            }
            
            actions.append(action)
        }
        
        if let interfaceController: WKInterfaceController = recoverMainView() {
            interfaceController.presentAlert(withTitle: info.title, message: info.message, preferredStyle: style, actions:actions)
        }
    }
    
    private func recoverAlertControllerStyle(customStyle: AlertViewStyle) -> WKAlertControllerStyle {
        var style: WKAlertControllerStyle = .actionSheet
        switch customStyle {
        case .alert:
            style = .alert
        case .sideBySideButtonsAlert:
            style = .sideBySideButtonsAlert
        case .actionSheet:
            style = .actionSheet
        }
        
        return style
    }
    
    private func recoverAlertActionStyle(customStyle: AlertActionStyle) -> WKAlertActionStyle {
        var style: WKAlertActionStyle = .default
        switch customStyle {
            
        case .default:
            style = .default
        case .cancel:
            style = .cancel
        case .destructive:
            style = .destructive
        }
        
        return style
    }

}
