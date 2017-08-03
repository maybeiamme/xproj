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
        
            

            
            class MockGenerate: UUIDWithoutDuplicateProtocol {
                var uuids = ["1FFB5ECE1F174CEC00211111", "1FFB5ECE1F174CEC00222222", "1FFB5ECE1F174CEC00233333", "1FFB5ECE1F174CEC00244444"]
                func generateHashValue() -> String? {
                    return uuids.popLast()
                }
            }

            it("find group by path test" ) {
                let g = MockGenerate()
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                var container = try! Container<PBXGroup>(data: dictionary)
                let mainGroup = "1FFB5EAD1F173360002F4A12"
                
                let stack = "/Sample/GroupWithFolder/GF_2/".components(separatedBy: "/").reversed() as Array<String>
                let group = try? container.findGroupByPath(parent: mainGroup, reversedPathArray: stack, generateGroupIfNeeded: false, uuidGenerator: g)
                expect( group ).notTo( beNil() )
                expect( group!.uuid ).to( equal("1FFB5ED11F174CEC002F4A12"))
            }
            
            it( "find group by path and make group test") {
                let g = MockGenerate()
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                var container = try! Container<PBXGroup>(data: dictionary)
                let mainGroup = "1FFB5EAD1F173360002F4A12"
                
                let stack = "/Root/Not/Exist/".components(separatedBy: "/").reversed() as Array<String>
                let group = try? container.findGroupByPath(parent: mainGroup, reversedPathArray: stack, generateGroupIfNeeded: true, uuidGenerator: g)
                let result = container.toString(newline: true)
            }
        }
    }
}
