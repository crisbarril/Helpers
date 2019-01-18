//
//  iOSDevice.swift
//  Helpers
//
//  Created by Cristian on 03/01/2019.
//  Copyright © 2019 Cristian Barril. All rights reserved.
//

import Foundation

struct iOSDevice: DeviceProtocol {
    
    var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
    func recoverMainView<ViewClass>() -> ViewClass? {
        return UIApplication.shared.keyWindow?.rootViewController as? ViewClass
    }
    
    func showAlert(info: AlertViewInfo) {
        
        let style = recoverAlertControllerStyle(customStyle: info.style)
        
        let alert = UIAlertController(title: info.title, message: info.message, preferredStyle: style)
        
        for actionInfo in info.actions {
        
            let actionStyle = recoverAlertActionStyle(customStyle: actionInfo.style)
            
            alert.addAction(UIAlertAction(title: actionInfo.title, style: actionStyle, handler: { action in
                actionInfo.action()
            }))
        }
        
        if let viewController: UIViewController = recoverMainView() {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    private func recoverAlertControllerStyle(customStyle: AlertViewStyle) -> UIAlertController.Style {
        var style: UIAlertController.Style = .actionSheet
        switch customStyle {
        case .alert:
            style = .alert
        case .sideBySideButtonsAlert:
            // This is a watchOS style. Leave the default initial value
            break
        case .actionSheet:
            style = .actionSheet
        }
        
        return style
    }
    
    private func recoverAlertActionStyle(customStyle: AlertActionStyle) -> UIAlertActionStyle {
        var style: UIAlertActionStyle = .default
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
