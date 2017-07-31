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
            
            it("PBXFileReference parsing and generating test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                let container = try! Container<PBXFileReference>(data: dictionary)
                let backstring = container.toString(newline: false)
                let compareWith = "1FFB5EB61F173360002F4A12 = { isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Sample.app; sourceTree = BUILT_PRODUCTS_DIR; };\n1FFB5EB91F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = <group>; };\n1FFB5EBB1F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = <group>; };\n1FFB5EBE1F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = <group>; };\n1FFB5EC01F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = <group>; };\n1FFB5EC31F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = <group>; };\n1FFB5EC51F173360002F4A12 = { isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = <group>; };\n1FFB5ECF1F174CEC002F4A12 = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GF_1_Source_1.swift; sourceTree = <group>; };\n1FFB5ED01F174CEC002F4A12 = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GF_1_Source_2.swift; sourceTree = <group>; };\n1FFB5ED41F174CFE002F4A12 = { isa = PBXFileReference; lastKnownFileType = folder; path = ReferenceWithFolder; sourceTree = <group>; };\n1FFB5ED91F174D69002F4A12 = { isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist.xml; path = GO_1_PLIST_1.plist; sourceTree = <group>; };"
                expect(backstring).to(equal(compareWith))
            }
            
            it("PBXGroup parsing and generating test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                let container = try! Container<PBXGroup>(data: dictionary)
                _ = container.toString(newline: true)
//                print( backstring )
            }
            
            it("Replace with regex test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)

                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                var container = try! Container<PBXGroup>(data: dictionary)
                var group = container.groupByPath(path: "GroupWithFolder")
                expect( group ).notTo(beNil())
                group?.children = (group?.children!)! + ["AABBCCDD"]
                try! container.modify(new: group!)
                let result = try! container.generateProjectWithCurrent(string: string!, newline: true)
                
                let newdic = try! Parser().start(string: result).dictionary["objects"] as! PBXCollection
                let newcontainer = try! Container<PBXGroup>(data: newdic)
                let newgroup = newcontainer.groupByHashValue(hashValue: "1FFB5ECD1F174CEC002F4A12")
                expect( newgroup ).notTo(beNil())
                expect( newgroup?.children?.count ).to(equal(3))
            expect( newgroup?.children ).to(equal( ["AABBCCDD","1FFB5ECE1F174CEC002F4A12","1FFB5ED11F174CEC002F4A12"]))
                //                print( backstring )
            }
            
            it("group by path component test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                let container = try! Container<PBXGroup>(data: dictionary)
                
                let reversedPathcomponent = ("Sample/GroupWithFolder/GF_1" as NSString).pathComponents.reversed() as Array<String>
                let group = try! container.groupByPathComponents(reversed: reversedPathcomponent, inGroup: container.items.values.map({ (value) -> PBXGroup in
                    return value
                }))
                
                expect( group ).notTo(beNil())
                expect( group.uuid ).to(equal( "1FFB5ECE1F174CEC002F4A12" ) )
                
            }
        }
    }
}
