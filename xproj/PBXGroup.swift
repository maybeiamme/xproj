//
//  PBXGroup.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXGroup: AutoEquatable, PBXType {
    internal static let identity: String = "PBXGroup"
    
    init( uuid: String, data: Dictionary<String,Any> ) throws {
        guard let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
        self.children = data["children"] as? Array<String>
        self.path = data["path"] as? String
        self.sourceTree = data["sourceTree"] as? String
        self.name = data["name"] as? String
    }
    
    let uuid: String
    let isa: String
    var children: Array<String>?
    var name: String?
    var sourceTree: String?
    var path: String?
}
