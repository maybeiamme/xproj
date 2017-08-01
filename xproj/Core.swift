//
//  Core.swift
//  xproj
//
//  Created by Jin Hyong Park on 1/8/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct Core {
    var argument: ArgumentsProtocol
    var fileManager: FileProtocol.Type?
    
    var projectfile: String?
    var groupsMustBeAdded: Array<String>?
    var filesMustBeAdded: Array<String>?
    
    init( argument: ArgumentsProtocol ) {
        self.argument = argument
    }
    
    mutating func processArgument() {
        do {
            guard let fileManager = fileManager else { throw FileError.notexist }
            
            let arguments = argument

            projectfile = try fileManager.read(path: (arguments.project as NSString).appendingPathComponent("project.pbxproj") )
            
            if arguments.recursive == true {
                for directory in arguments.files {
                    if fileManager.isDirectory(path: directory) == false { throw FileError.notdirectory }
                }
                let relativeDirectories = try arguments.files.flatMap{ base in
                    return try fileManager.allContents(at: base).filter{ fileManager.isDirectory(path: $0) }.map{ $0.replacingOccurrences(of: base, with: "") }
                }
                let reilativeFiles = try arguments.files.flatMap{ base in
                    return try fileManager.allContents(at: base).filter{ fileManager.isDirectory(path: $0) == false }.map{ $0.replacingOccurrences(of: base, with: "") }
                }
                groupsMustBeAdded = relativeDirectories.map{ (arguments.destination as NSString).appendingPathComponent($0) }
                filesMustBeAdded = reilativeFiles.map{ (arguments.destination as NSString).appendingPathComponent($0) }
            } else {
                for directory in arguments.files {
                    if fileManager.isDirectory(path: directory) == true { throw FileError.notdirectory }
                }
                
                let relativeFiles = arguments.files.map{ ($0 as NSString).lastPathComponent }
                filesMustBeAdded = relativeFiles.map{ (arguments.destination as NSString).appendingPathComponent($0) }
            }
        } catch {
            Errors.handle(error: error)
        }
        
    }
}
