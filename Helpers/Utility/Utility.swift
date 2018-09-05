//
//  Utility.swift
//  Helpers
//
//  Created by Cristian on 02/09/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import Foundation

public enum SupportedFileTypes: String {
    case json = ".json"
    case xml = ".xml"
}

public struct Utility {
    
    public static func read(fileName: String, fileType: SupportedFileTypes, bundle: Bundle = Bundle.main) throws -> Any? {
        if let path = bundle.path(forResource: fileName, ofType: fileType.rawValue) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parsedData = parse(data, fileType: fileType)
                
                return parsedData
                
            } catch {
                throw ErrorFactory.create(withKey: "Fail to recover data", failureReason: "Fail to recover data from \(path).", domain: "SystemUtility")
            }
        }
        
        return nil
    }
    
    public static func parse(_ data: Data, fileType: SupportedFileTypes) -> Any? {
        switch fileType {
        case .json:
            return try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        default:
            return nil
        }
    }
}
