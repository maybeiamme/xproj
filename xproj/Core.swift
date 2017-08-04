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
            
            guard let projectfile = projectfile else { throw FileError.failedtoread }
            let root = try Parser().start(string: projectfile)
            guard let collection = root.dictionary["objects"] as? PBXCollection else { throw FileError.failedtoread }
            guard let rootObject = root.dictionary["rootObject"] as? String else {
                throw FileError.failedtoread
            }
            let project = try Container<PBXProject>(data: collection)
            guard let mainGroup = project.items[rootObject]?.mainGroup else { throw FileError.failedtoread }
            var group = try Container<PBXGroup>(data: collection)
            
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
            
            if let addableGroups = groupsMustBeAdded {
                try addableGroups
                    .map{ $0.components(separatedBy: "/").reversed() as Array<String> }
                    .forEach{ value in
                        let _ = try group.findGroupByPath(parent: mainGroup, reversedPathArray: value, generateGroupIfNeeded: true, uuidGenerator: PBXObject.shared)
                }
            }
            
        } catch {
            Errors.handle(error: error)
        }
        
    }
}
