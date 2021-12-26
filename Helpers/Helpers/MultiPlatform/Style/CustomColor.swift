//
//  Color.swift
//  Helpers
//
//  Created by Cristian on 01/09/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import UIKit

public struct CustomColor {
    public var strength: String
    public var hex: String
    public var alpha: CGFloat
    public var contrast: UIColor {
        get {
            guard contrastValue != .none else {
                return UIColor(white: 0, alpha: 0)
            }
            
            return contrastValue == .black ? UIColor.black : UIColor.white
        }
    }
    
    private var contrastValue: Contrast
    
    public var value: UIColor {
        guard hex != "" else {
            return UIColor(white: 0, alpha: 0)
        }
        
        return UIColor(hexString: hex, alpha: alpha)
    }
        
    public func alpha(_ value: CGFloat) -> CustomColor {
        return CustomColor(hex: hex, alpha: value, contrast: contrastValue)
    }
}

public enum Contrast: String {
    case black, white, none
}

extension CustomColor {
    
    private enum Key  {
        static let strength = "strength"
        static let hex = "hex"
        static let contrast = "contrast"
    }
    
    //failable initializer
    init?(json: [String: Any]) {
        guard let strengthValue = json[Key.strength] as? String,
            let hexValue = json[Key.hex] as? String,
            let contrastValue = json[Key.contrast] as? String,
            let contrast = Contrast(rawValue: contrastValue)
            
            else {
                return nil
        }
        
        self.strength = strengthValue
        self.hex = hexValue
        self.contrastValue = contrast
        self.alpha = 1.0
    }
    
    init(hex: String, alpha: CGFloat = 1.0, contrast: Contrast) {
        self.strength = "0"
        self.contrastValue = contrast
        self.alpha = alpha
        self.hex = hex
    }
}
