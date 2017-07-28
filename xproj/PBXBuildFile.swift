//
//  PBXBuildFile.swift
//  xproj
//
//  Created by Jin Hyong Park on 25/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXBuildFile: AutoEquatable, PBXType {
    internal static let identity = "PBXBuildFile"
    
    init( uuid: String, data: Dictionary<String,Any> ) throws {
        guard let fileRef = data["fileRef"] as? String, let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
        self.fileRef = fileRef
    }
    
    let uuid: String
    let isa: String
    let fileRef: String?
}

