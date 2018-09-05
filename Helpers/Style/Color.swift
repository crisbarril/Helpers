//
//  Color.swift
//  Helpers
//
//  Created by Cristian on 01/09/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import UIKit

public struct Color {
    var strength: String
    var hex: String
    var contrast: UIColor {
        get {
            return contrastValue == .black ? UIColor.black : UIColor.white
        }
    }
    
    private var contrastValue: Contrast
    
    var value: UIColor {
        return UIColor(hexString: hex, alpha: 1.0)
    }
        
    func alpha(_ value: CGFloat) -> UIColor {
        return UIColor(hexString: hex, alpha: value)
    }
}

enum Contrast: String {
    case black
    case white
}

extension Color {
    
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
    }
    
    init(hex: String, contrast: Contrast) {
        self.strength = "0"
        self.contrastValue = contrast
        self.hex = hex
    }
}
