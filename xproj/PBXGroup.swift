//
//  PBXGroup.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

//internal struct PBXGroupContainer {
//    internal var items: Dictionary<String,PBXGroup>
//    
//    init( data: Dictionary<String,Any> ) throws {
//        var dictionary: Dictionary<String,PBXGroup> = Dictionary<String,PBXGroup>()
//        for (key, value) in data {
//            if let info = value as? Dictionary<String,Any>, let string = info["isa"] as? String, string == PBXGroup.identity {
//                dictionary[key] = try PBXGroup(uuid: key, data: info)
//            }
//        }
//        items = dictionary
//    }
//}

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
    let children: Array<String>?
    let name: String?
    let sourceTree: String?
    let path: String?
}

