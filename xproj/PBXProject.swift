//
//  PBXProject.swift
//  xproj
//
//  Created by Jin Hyong Park on 4/8/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Cocoa

internal struct PBXProject: AutoEquatable, PBXType {
    internal static let identity: String = "PBXProject"
    
    init( uuid: String, data: Dictionary<String,Any> ) throws {
        guard let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
        self.mainGroup = data["mainGroup"] as? String
    }
    
    let uuid: String
    let isa: String
    let mainGroup: String?
    
}
