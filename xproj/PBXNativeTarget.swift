//
//  PBXNativeTarget.swift
//  xproj
//
//  Created by Jin Hyong Park on 27/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa


internal struct PBXNativeTarget: AutoEquatable, PBXType {
    internal static let identity: String = "PBXNativeTarget"
    
    init( uuid: String, data: Dictionary<String,Any> ) throws {
        guard let isa = data["isa"] as? String else {
            throw ParseError.brokenSyntax
        }
        self.uuid = uuid
        self.isa = isa
        self.buildConfigurationList = data["buildConfigurationList"] as? String
        self.buildPhases = data["buildPhases"] as? Array<String>
        self.buildRules = data["buildRules"] as? Array<String>
        self.dependencies = data["dependencies"] as? Array<String>
        self.name = data["name"] as? String
        self.productName = data["productName"] as? String
        self.productReference = data["productReference"] as? String
        self.productType = data["productType"] as? String
    }
    
    let uuid: String
    let isa: String
    let buildConfigurationList: String?
    let buildPhases: Array<String>?
    let buildRules: Array<String>?
    let dependencies: Array<String>?
    let name: String?
    let productName: String?
    let productReference: String?
    let productType: String?
}

