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
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!)["objects"] as! Dictionary<String,Any>
                let container = try! Container<PBXFileReference>(data: dictionary)
                expect(container.items.count).to(equal(11))
                let contain = container.items["1FFB5EB91F173360002F4A12"]
                
                let stub = "{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = \"<group>\"; }"
                let comparable = try! Parser().start(string: stub)
                let component = try! PBXFileReference(uuid: "1FFB5EB91F173360002F4A12", data: comparable)
                expect(contain).to(equal(component))
            }
        }
    }
}
