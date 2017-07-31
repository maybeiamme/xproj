//
//  PBXObjects.swift
//  xproj
//
//  Created by Jin Hyong Park on 28/7/17.
//  Copyright © 2017 PropertyGuruuid. All rights reserved.
//

import Cocoa

internal struct PBXObject {
    internal static var shared = PBXObject()
    
    internal mutating func set( collection: PBXCollection ) {
        self.collecion = collection
    }
    
    internal var generator: UUIDGeneratorProtocol.Type?
    private var collecion: PBXCollection?
    
    private var hashValues: Dictionary<String,Bool>? {
        guard let collection = collecion else { return nil }
        var dictionary: Dictionary<String,Bool> = Dictionary<String,Bool>()
        for key in collection.dictionary.keys {
            dictionary[key] = true
        }
        return dictionary
    }
    
    internal func generateHashValue() -> String? {
        guard collecion != nil else { return nil }
        guard let generator = generator else { return nil }
        var generated = generator.generate()
        while hashValues?[generated] != nil {
            generated = UUIDGenerator.generate()
        }
        return generated
    }
}
