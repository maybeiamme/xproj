//
//  PBXBuildFileSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 25/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

class PBXBuildFileSpec: QuickSpec {
    
    override func spec() {
        describe("PBXBuildFileAnnotation test") {
            it("simple check") {
                let stub = "1FFB5EBA1F173360002F4A12 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1FFB5EB91F173360002F4A12 /* AppDelegate.swift */; };"
                let result = PBXBuildFile.removeAnnotation(string: stub)
                expect(result!).to(equal("1FFB5EBA1F173360002F4A12  = {isa = PBXBuildFile; fileRef = 1FFB5EB91F173360002F4A12 ; };"))
            }
        }
    }
}
