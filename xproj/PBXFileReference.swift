//
//  PBXFileReference.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa


internal struct PBXFileReference: AutoEquatable, PBXType {
    internal static var identity: String = "PBXFileReference"
    
    init( uuid: String, data: Dictionary<String,Any> ) throws {
        guard let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
        self.explicitFileType = data["explicitFileType"] as? String
        self.includeInIndex = data["includeInIndex"] as? String
        self.path = data["path"] as? String
        self.sourceTree = data["sourceTree"] as? String
        self.name = data["name"] as? String
    }
    
    let uuid: String
    let isa: String
    let explicitFileType: String?
    let includeInIndex: String?
    let path: String?
    let sourceTree: String?
    let name: String?
}

