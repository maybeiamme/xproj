//
//  PBXSourcesBuildPhase.swift
//  xproj
//
//  Created by Shepherd on 2017. 8. 6..
//  Copyright © 2017년 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXSourcesBuildPhase: AutoEquatable, PBXType {
    internal static var identity: String = "PBXSourcesBuildPhase"
    
    init( uuid: String, data: Dictionary<String,Any> ) throws {
        print( "data when init PBXSourcesBuildPhase : [\(data)]" )
        guard let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
        self.files = data["files"] as? Array<String>
        self.buildActionMask = data["buildActionMask"] as? String
        self.runOnlyForDeploymentPostprocessing = data["runOnlyForDeploymentPostprocessing"] as? String
    }
    
    let uuid: String
    let isa: String
    let buildActionMask: String?
    var files: Array<String>?
    let runOnlyForDeploymentPostprocessing: String?
}
