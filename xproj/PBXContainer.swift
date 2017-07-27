//
//  PBXContainer.swift
//  xproj
//
//  Created by Jin Hyong Park on 27/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
protocol PBXType {
    static var identity: String { get }
    init( uuid: String, data: Dictionary<String,Any> ) throws
}

internal struct Container<T: PBXType> {
    internal var items: Dictionary<String,T>
    
    init( data: Dictionary<String,Any> ) throws {
        var dictionary: Dictionary<String,T> = Dictionary<String,T>()
        for (key, value) in data {
            if let info = value as? Dictionary<String,Any>, let string = info["isa"] as? String, string == T.identity {
                dictionary[key] = try T(uuid: key, data: info)
            }
        }
        items = dictionary
    }
}

protocol PBXParserProtocol {
    func start( string: String ) throws -> Dictionary<String,Any>
}
