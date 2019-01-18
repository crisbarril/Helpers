//
//  Utility.swift
//  Helpers
//
//  Created by Cristian on 02/09/2018.
//  Copyright © 2018 LostToys. All rights reserved.
//

import Foundation

public enum SupportedFiles: String {
    case json = ".json"
    case xml = ".xml"
}

public struct Utility {
    
    public init() {
        
    }
    
    public func read(fileName: String, fileType: SupportedFiles, bundle: Bundle = Bundle.main) throws -> Any? {
        
        if let path = bundle.path(forResource: fileName, ofType: fileType.rawValue) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parsedData = parse(data, fileType: fileType)
                
                return parsedData
                
            } catch {
                throw ErrorFactory.create(withKey: "Fail to recover data from file: \(fileName)", failureReason: error.localizedDescription, domain: "Utility")
            }
        }
        else {
            throw ErrorFactory.create(withKey: "Fail to find file", failureReason: "Fail to find file in bundle: \(bundle.description).", domain: "Utility")
        }
    }
    
    public func write(content: String, fileName: String, fileType: SupportedFiles, bundle: Bundle = Bundle.main) throws {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent("\(fileName)\(fileType.rawValue)")
            
            //writing
            do {
                try content.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                throw ErrorFactory.create(withKey: "Fail to write data in file: \(fileName)\(fileType.rawValue)", failureReason: error.localizedDescription, domain: "Utility")
            }
        }
    }
    
    public func parse(_ data: Data, fileType: SupportedFiles) -> Any? {
        switch fileType {
        case .json:
            return try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        default:
            return nil
        }
    }
    
    
}
