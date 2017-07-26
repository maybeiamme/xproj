//
//  PBXGroupSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

class PBXGroupSpec: QuickSpec {
    
    override func spec() {
        describe("Regex verification") {

            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let containter = try! PBXGroupContainer(string: string!)
                expect(containter.items.count).to(equal(9))
                for contain in containter.items {
                    if contain.uuid == "1FFB5EB81F173360002F4A12" {
                        expect(contain.children?.count).to(equal(9))
                        expect(contain.path).to(equal("Sample"))
                    }
                }

            }
        }
    }
}
