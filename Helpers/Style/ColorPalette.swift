//
//  ColorPalette.swift
//  Helpers
//
//  Created by Cristian on 10/07/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import UIKit

//Color manager
public struct ColorPalette {
    static var colors: [ColorGroup] = ColorPalette.initialize()
    
    static var primary: Color = get(.red, strength: "50")
    static var accent: Color = get(.red, strength: "50")
    static var dark: Color = get(.red, strength: "50")
    
    static func get(_ color: Palette, strength: String? = nil) -> Color {
        let colorInfo = colors.first { (colorData) -> Bool in
            return colorData.key == color
        }
        
        guard let colorGroup = colorInfo else { return custom(hexString: "#000000", contrast: .white) }
        
        if let colorStrength = strength {
            let selectedColor = colorGroup.shades.first { (data) -> Bool in
                return data.strength == colorStrength
            }
            
            return selectedColor ?? colorGroup.defaultShade
        }
        
        return colorGroup.defaultShade
    }
    
    static func custom(hexString: String, contrast: Contrast) -> Color {
        return Color(hex: hexString, contrast: contrast)
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
            let jsonData = try Utility.read(fileName: "ColorPalette", fileType: .json)

            if let json = jsonData as? [String:Any], let colorArray = json[Key.colorArray] as? [[String: Any]] {
                
                for obj in colorArray {
                    if let color = ColorGroup(json: obj) {
                        colors.append(color)
                        print("New color group: \(color)")
                    }
                }
            }
            
        } catch {
            print(error)
        }
        
        return colors
    }
}
