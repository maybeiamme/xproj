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
        guard let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
    }
    
    let uuid: String
    let isa: String
    var fileRef: String?
}

