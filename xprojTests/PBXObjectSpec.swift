//
//  PBXObject.swift
//  xproj
//
//  Created by Jin Hyong Park on 28/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

var generatorCalled = 0

class PBXObjectSpec: QuickSpec {
    
    override func spec() {
        describe("PBXObjectTest") {
            
            struct MockGenerator: UUIDGeneratorProtocol {
                static func generate() -> String {
                    generatorCalled += 1
                    if generatorCalled > 0 {
                        return "1FFB5EBA1F173360002F4AFF"
                    }
                    
                    return "1FFB5EBA1F173360002F4A12"
                }
            }
            
            it("Full parse test") {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let dictionary = try! Parser().start(string: string!).dictionary["objects"] as! PBXCollection
                PBXObject.shared.set(collection: dictionary)
                PBXObject.shared.generator = MockGenerator.self
                var hash = PBXObject.shared.generateHashValue()
                expect(generatorCalled).to(equal(1))
                expect(hash).to(equal("1FFB5EBA1F173360002F4AFF"))
            }
            
            it( "print" ) {
//                let contents = try! File.allContents(at: "/Users/jinhyongpark/Workspace/xproj")
//                print( contents )
//                let directories = contents.filter{ File.isDirectory(path: $0 ) == true }
//                print( directories )
                
//                try! File.allContents(at: "/Users/jinhyongpark/Workspace/xproj")
//                try! File.allContents(at: "/Users/jinhyongpark/Workspace/xproj")
                
//                let relativeDirectories = ["/Users/jinhyongpark/Workspace/xproj/xproj", "/Users/jinhyongpark/Workspace/xproj/xprojTests"].flatMap{ base in
//                        return try! File.allContents(at: base).filter{ File.isDirectory(path: $0) }.map{ $0.replacingOccurrences(of: base, with: "") }
//                }
//                print( relativeDirectories )
                
//                let allContents = ["/Users/jinhyongpark/Workspace/xproj/xproj", "/Users/jinhyongpark/Workspace/xproj/xprojTests"].flatMap{ try! File.allContents(at: $0 ) }
//                let allDirectories = allContents.filter{ File.isDirectory(path: $0) == true }
//                print( allDirectories )
            }
        }
    }
}
