//
//  PBXBuildFileSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 25/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Quick
import Nimble

class PBXBuildFileContainerSpec: QuickSpec {
    
    override func spec() {
        describe("Regex verification") {
            it("simple check") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let results = PBXBuildFileContainer.parse(string: string!)
                let compareStub = "1FFB5EBA1F173360002F4A12 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1FFB5EB91F173360002F4A12 /* AppDelegate.swift */; };"
                expect(results![0]).to(contain(compareStub))
            }
        }
    }
}
