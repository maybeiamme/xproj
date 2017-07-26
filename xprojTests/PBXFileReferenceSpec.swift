//
//  PBXFileReferenceSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

class PBXFileReferenceSpec: QuickSpec {
    
    override func spec() {
        describe("Regex verification") {
            it("simple check") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let results = PBXFileReferenceContainer.parse(string: string!)
                let compareStub = "1FFB5EB61F173360002F4A12 /* Sample.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Sample.app; sourceTree = BUILT_PRODUCTS_DIR; };"
                expect(results![0]).to(contain(compareStub))
            }
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let containter = try! PBXFileReferenceContainer(string: string!)
                expect(containter.items.count).to(equal(11))
                let contain = containter.items[1]
                
                let stub = "1FFB5EB91F173360002F4A12 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = \"<group>\"; };"
                let component = try! PBXFileReference.parse(string: stub)
                expect(contain).to(equal(component!))
            }
        }
        
        describe("PBXFileReference parse verification") {
            
            it("PBXFileReference test") {
                let stub = "1FFB5EB61F173360002F4A12 /* Sample.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Sample.app; sourceTree = BUILT_PRODUCTS_DIR; };"
                let component = try! PBXFileReference.parse(string: stub)
                expect(component!.uuid).to(equal("1FFB5EB61F173360002F4A12"))
                expect(component!.sourceTree).to(equal("BUILT_PRODUCTS_DIR"))
                expect(component!.explicitFileType).to(equal("wrapper.application"))
            }
        }
    }
}
