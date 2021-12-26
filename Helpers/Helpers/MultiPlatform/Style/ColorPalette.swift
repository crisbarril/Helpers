//
//  ColorPalette.swift
//  Helpers
//
//  Created by Cristian on 10/07/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import UIKit

//Color manager
public class ColorPalette {
    static public var colors: [ColorGroup] = ColorPalette.initialize()
    
    static public var primary: CustomColor = get(.red, strength: "50")
    static public var accent: CustomColor = get(.red, strength: "50")
    static public var dark: CustomColor = get(.red, strength: "50")
    
    static public func get(_ color: Palette, strength: String? = nil) -> CustomColor {
        let colorInfo = colors.first { (colorData) -> Bool in
            return colorData.key == color
        }
        
        guard let colorGroup = colorInfo else { return custom(hexString: "", alpha: 1.0, contrast: .none) }
        
        if let colorStrength = strength {
            let selectedColor = colorGroup.shades.first { (data) -> Bool in
                return data.strength == colorStrength
            }
            
            return selectedColor ?? colorGroup.defaultShade
        }
        
        return colorGroup.defaultShade
    }
    
    static public func custom(hexString: String, alpha: CGFloat = 1.0, contrast: Contrast) -> CustomColor {
        return CustomColor(hex: hexString, alpha: alpha, contrast: contrast)
    }
}

extension ColorPalette {
    
    private enum Key  {
        static let colorArray = "colors"
    }
    
    //https://www.materialpalette.com/colors
    static private func initialize() -> [ColorGroup] {
        var colors = [ColorGroup]()
        
        do {
            let jsonData = try Utility().read(fileName: "ColorPalette", fileType: .json, bundle: Bundle(for: ColorPalette.self))
            let json = Utility().parse(jsonData, fileType: .json)
            
            if let item = json as? [String:Any], let colorArray = item[Key.colorArray] as? [[String: Any]] {
                
                for obj in colorArray {
                    if let color = ColorGroup(json: obj) {
                        colors.append(color)
//                        print("New color group: \(color)")
                    }
                }
            }
            
        } catch {
            print(error)
        }
        
        return colors
    }
}
