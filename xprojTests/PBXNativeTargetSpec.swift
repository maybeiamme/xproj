//
//  PBXNativeTargetSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 27/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

class PBXNativeTargetSpec: QuickSpec {
    
    override func spec() {
        describe("Regex verification") {
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!)["objects"] as! Dictionary<String,Any>
                let container = try! Container<PBXNativeTarget>(data: dictionary)
                expect(container.items.count).to(equal(1))
                
            }
        }
    }
}
