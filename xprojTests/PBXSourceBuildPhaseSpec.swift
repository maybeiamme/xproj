//
//  PBXSourceBuildPhaseSpec.swift
//  xproj
//
//  Created by Shepherd on 2017. 8. 6..
//  Copyright © 2017년 PropertyGuru. All rights reserved.
//
import Quick
import Nimble

class PBXSourcesBuildPhaseSpec: QuickSpec {
    
    override func spec() {
        describe("PBXSourcesBuildPhase parsing test") {
            
            it("Full parse test") {
        
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection

                let container = try! Container<PBXSourcesBuildPhase>(data: dictionary)
                let pbxfile = container.items["1FFB5EB21F173360002F4A12"]
                
                expect( pbxfile?.files ).to(equal(["1FFB5EBA1F173360002F4A12", "1FFB5EBC1F173360002F4A12", "1FFB5ED21F174CEC002F4A12", "1FFB5ED31F174CEC002F4A12"]))
                expect( pbxfile?.buildActionMask).to(equal("2147483647"))
                expect( pbxfile?.runOnlyForDeploymentPostprocessing).to(equal("0"))
            }
        }
    }
}
