//
//  DateHelper.swift
//  Pods
//
//  Created by Cristian Barril on 29/06/2019.
//

import Foundation

public struct DateHelper {
    
    public init() {
        
    }
    
    public func timeString(fromSeconds seconds: Int) -> String {
     
        guard seconds > 0 else {
            return ""
        }
        
        var resultString = ""
        
        if seconds/60/60 > 0 {
            resultString.append("\(seconds/60/60):")
        }
        
        if seconds/60 > 0 {
            resultString.append("\(seconds/60):")
        }
        
        resultString.append(String(format: "%02d", seconds%60))
        
        return resultString
    }
}
