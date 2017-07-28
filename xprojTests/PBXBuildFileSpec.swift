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
        describe("Regex verification") {
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                
                let container = try! Container<PBXBuildFile>(data: dictionary)
                expect(container.items.count).to(equal(9))
                let pbxfile = container.items["1FFB5EBA1F173360002F4A12"]
                
                let stub = "{isa = PBXBuildFile; fileRef = 1FFB5EB91F173360002F4A12 /* AppDelegate.swift */; }"
                let comparable = try! Parser().start(string: stub)
                let component = try! PBXBuildFile(uuid: "1FFB5EBA1F173360002F4A12", data: comparable.dictionary)
                expect(pbxfile).to(equal(component))
            }
        }
    }
}
