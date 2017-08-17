//
//  PBXObjects.swift
//  xproj
//
//  Created by Jin Hyong Park on 28/7/17.
//  Copyright © 2017 PropertyGuruuid. All rights reserved.
//

import Cocoa

internal struct PBXUUIDGenerator: UUIDWithoutDuplicateProtocol {
    internal static var shared = PBXUUIDGenerator()
    
    internal mutating func set( collection: PBXCollection ) {
        self.collecion = collection
        
        guard let collection = collecion else { return }
        var dictionary: Dictionary<String,Bool> = Dictionary<String,Bool>()
        for key in collection.dictionary.keys {
            dictionary[key] = true
        }
        
        hashValues = dictionary
    }
    
    private func generate() -> String {
        let uuid = UUID().uuid
        let generated = String( format: "%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", uuid.0, uuid.1, uuid.2, uuid.3, uuid.4, uuid.5, uuid.6, uuid.7, uuid.8, uuid.9, uuid.10, uuid.11)
        return generated
    }
    
    private var collecion: PBXCollection?
    private var hashValues: Dictionary<String,Bool>?
    
    internal func generateHashValue() -> String? {
        guard collecion != nil else { return nil }
        var generated = self.generate()
        while hashValues?[generated] != nil {
            generated = self.generate()
        }
        return generated
    }
}
