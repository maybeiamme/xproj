//
//  ContainerSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 28/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

class ContainerSpec: QuickSpec {
    
    override func spec() {
        describe("Container tests") {
            
//            it("PBXFileReference parsing and generating test") {
//                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
//                let string = try? String(contentsOfFile: path!, encoding: .utf8)
//                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
//                let container = try! Container<PBXFileReference>(data: dictionary)
//                let backstring = container.toString(newline: false)
//                let compareWith = "1FFB5EB61F173360002F4A12 = { isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Sample.app; sourceTree = BUILT_PRODUCTS_DIR; };\n1FFB5EB91F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = <group>; };\n1FFB5EBB1F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = <group>; };\n1FFB5EBE1F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = <group>; };\n1FFB5EC01F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = <group>; };\n1FFB5EC31F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = <group>; };\n1FFB5EC51F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = <group>; };\n1FFB5ECF1F174CEC002F4A12 = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GF_1_Source_1.swift; sourceTree = <group>; };\n1FFB5ED01F174CEC002F4A12 = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GF_1_Source_2.swift; sourceTree = <group>; };\n1FFB5ED41F174CFE002F4A12 = { isa = PBXFileReference; lastKnownFileType = folder; path = ReferenceWithFolder; sourceTree = <group>; };\n1FFB5ED91F174D69002F4A12 = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist.xml; path = GO_1_PLIST_1.plist; sourceTree = <group>; };"
//                expect(backstring).to(equal(compareWith))
//            }
//            
//            it("PBXGroup parsing and generating test") {
//                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
//                let string = try? String(contentsOfFile: path!, encoding: .utf8)
//                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
//                let container = try! Container<PBXGroup>(data: dictionary)
//                let backstring = container.toString(newline: true)
////                print( backstring )
//            }
            
            it("Replace with regex test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                print( " ----------------------- origin --------------------------")
                print( string )
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                var container = try! Container<PBXGroup>(data: dictionary)
                var group = container.groupByPath(path: "GroupWithFolder")
                expect( group ).notTo(beNil())
                group?.children = (group?.children!)! + ["AABBCCDD"]
                try! container.modify(new: group!)
                let result = try! container.generateProjectWithCurrent(string: string!, newline: true)
                print( " ----------------------- result --------------------------")
                print( result )
                let backstring = container.toString(newline: true)
                //                print( backstring )
            }
        }
    }
}
