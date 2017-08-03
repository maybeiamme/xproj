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
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                let container = try! Container<PBXGroup>(data: dictionary)
                expect(container.items.count).to(equal(9))
                let value = container.items["1FFB5EB81F173360002F4A12"]
                expect(value?.uuid).to(equal("1FFB5EB81F173360002F4A12"))
                expect(value?.children?.count).to(equal(9))
                expect(value?.path).to(equal("Sample"))
            }
        }
    }
}
