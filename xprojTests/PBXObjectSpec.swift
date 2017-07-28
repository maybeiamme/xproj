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

class PBXObjectSpec: QuickSpec {
    
    override func spec() {
        describe("PBXObjectTest") {
            
            struct MockGenerator: UUIDGeneratorProtocol {
                static func generate() -> String {
                    generatorCalled += 1
                    if generatorCalled > 0 {
                        return "1FFB5EBA1F173360002F4AFF"
                    }
                    
                    return "1FFB5EBA1F173360002F4A12"
                }
            }
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                PBXObject.shared.set(collection: dictionary)
                PBXObject.shared.generator = MockGenerator.self
                var hash = PBXObject.shared.generateHashValue()
                expect(generatorCalled).to(equal(1))
                expect(hash).to(equal("1FFB5EBA1F173360002F4AFF"))
            }
        }
    }
}
