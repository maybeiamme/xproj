//
//  PBXObject.swift
//  xproj
//
//  Created by Jin Hyong Park on 28/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

var generatorCalled = 0

class PBXUUIDGeneratorSpec: QuickSpec {
    
    override func spec() {
        describe("PBXObjectTest") {
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let collection = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                PBXUUIDGenerator.shared.set(collection: collection)
                let hash = PBXUUIDGenerator.shared.generateHashValue()
                
                expect(collection.dictionary[hash!]).to(beNil())
            }
        }
    }
}
