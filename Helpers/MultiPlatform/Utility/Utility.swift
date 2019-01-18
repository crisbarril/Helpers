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
    
    /// Method to recover file from disk. If the parameter `fromDocumentDirectory` is true, then checks firsts in the sandbox. If its not there, then look in the Bundle and move it to the sandbox.
    public func read(fileName: String, fileType: SupportedFiles, bundle: Bundle = Bundle.main, fromDocumentDirectory: Bool = false) throws -> Data {
        
        var pathURL: URL
        
        if fromDocumentDirectory {
            
            // File in sandbox
            guard let sandboxURL = urlFromSandbox(fileName: fileName, fileType: fileType) else {
                throw ErrorFactory.create(withKey: "Fail URL generation", failureReason: "Fail to generate sandbox URL for \(fileName)\(fileType.rawValue)", domain: "Utility")
            }
            
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: sandboxURL.path) {
                pathURL = sandboxURL
            }
            else {
                // Not in sandbox. Searching in Bundle and copying to sandbox
                try moveFile(fileName: fileName, fileType: fileType, fromBundle: bundle, toURL: sandboxURL)
                return try read(fileName: fileName, fileType: fileType, bundle: bundle, fromDocumentDirectory: fromDocumentDirectory)
            }
        }
        else {
            // Read file from Bundle
            if let bundleURL = urlFromBundle(fileName: fileName, fileType: fileType, bundle: bundle) {
                pathURL = bundleURL
            }
            else {
                // Not in Bundle. Throw error
                throw ErrorFactory.create(withKey: "File missing", failureReason: "File \(fileName) its not in Bundle", domain: "Utility")
            }
        }
        
        do {
            return try Data(contentsOf: pathURL, options: .mappedIfSafe)
        } catch {
            throw ErrorFactory.create(withKey: "Fail to recover data from file: \(fileName)", failureReason: error.localizedDescription, domain: "Utility")
        }
    }
    
    public func write(content: Data, fileName: String, fileType: SupportedFiles) throws {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent("\(fileName)\(fileType.rawValue)")
            
            //writing
            do {
                try content.write(to: fileURL)
                print("File \(fileName) written in path: \(fileURL)")
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
    
    //MARK: Private funcs
    
    private func urlFromBundle(fileName: String, fileType: SupportedFiles, bundle: Bundle) -> URL? {
        if let path = bundle.path(forResource: fileName, ofType: fileType.rawValue) {
            return URL(fileURLWithPath: path)
        }
        else {
            print("Fail to generate bundle url for \(fileName)\(fileType.rawValue)")
            return nil
        }
    }
    
    private func urlFromSandbox(fileName: String, fileType: SupportedFiles) -> URL? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return dir.appendingPathComponent("\(fileName)\(fileType.rawValue)")
        }
        else {
            print("Fail to generate sandbox url for \(fileName)\(fileType.rawValue)")
            return nil
        }
    }
    
    private func moveFile(fileName: String, fileType: SupportedFiles, fromBundle bundle: Bundle, toURL url: URL) throws {
        do {
            let data = try read(fileName: fileName, fileType: fileType, bundle: bundle, fromDocumentDirectory: false)
            try write(content: data, fileName: fileName, fileType: fileType)
            
        } catch {
            throw ErrorFactory.create(withKey: "File moving file", failureReason: "Fail to move file \(fileName) from Bundle to Sandbox. Error: \(error)", domain: "Utility")
        }
    }
}
