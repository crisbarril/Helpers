//
//  ColorGroup.swift
//  Helpers
//
//  Created by Cristian on 01/09/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import Foundation

public  struct ColorGroup {
    public let key: Palette
    public let defaultShade: CustomColor
    public let shades: [CustomColor]
}

internal extension ColorGroup {
    
    private enum Key  {
        static let key = "key"
        static let defaultShade = "default"
        static let shades = "shades"
    }
    
    //failable initializer
    init?(json: [String: Any]) {
        guard let groupKey = json[Key.key] as? String,
            let keyPalette = Palette(rawValue: groupKey),
            let defaultShadeData = json[Key.defaultShade] as? [String: Any],
            let defaultShade = CustomColor(json: defaultShadeData),
            let shadesArray = json[Key.shades] as? [[String: Any]]
            
            else {
                return nil
        }
        
        self.key = keyPalette
        self.defaultShade = defaultShade
        
        var shadesTemp = [CustomColor]()
        
        for obj in shadesArray {
            if let color = CustomColor(json: obj) {
                shadesTemp.append(color)
            }
        }
        
        shades = shadesTemp
    }
}
