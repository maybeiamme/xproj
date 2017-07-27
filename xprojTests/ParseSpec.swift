//
//  ParseSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 13/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble
import XCTest

class ParseSpec: QuickSpec {

    override func spec() {
        var parser: Parser?
        
        beforeEach {
            parser = Parser()
        }
        
        describe("Basic parsing test") {
            it("Simple key and value test") {
                let stub = "{isa=PBXBuildFile;}"
                do {
                    let result = try parser?.start(string: stub)
                    expect(result).to(beAKindOf(Dictionary<String,Any>.self))
                } catch {
                    print( error )
                    expect(false).to(equal(true))
                }
            }
            
            it("multiple key and values test") {
                let stub = "{isa=PBXBuildFile;fileRef=1FFB5EB91F173360002F4A12;}"
                let result = try? parser?.start(string: stub)
                expect(result!).to(beAKindOf(Dictionary<String,Any>.self))
                let dic = result as! Dictionary<String,Any>
                expect( dic["isa"] as? String ).to(equal("PBXBuildFile"))
                expect( dic["fileRef"] as? String ).to(equal("1FFB5EB91F173360002F4A12"))
            }
            
            it("dictionary in dictionary test") {
                let stub = "{1FFB5EB61F173360002F4A12={isa=PBXFileReference;explicitFileType=wrapper.application;includeInIndex=0;path=Sample.app;sourceTree=BUILT_PRODUCTS_DIR;};}"
                let result = try? parser?.start(string: stub)
                expect(result!).to(beAKindOf(Dictionary<String,Any>.self))
                let dic = result as! Dictionary<String,Any>
                expect( dic["1FFB5EB61F173360002F4A12"]  ).to(beAKindOf(Dictionary<String,Any>.self))
                let indic = dic["1FFB5EB61F173360002F4A12"] as! Dictionary<String,String>
                expect( indic["isa"] ).to(equal("PBXFileReference"))
                expect( indic["explicitFileType"]! ).to(equal("wrapper.application"))
                expect( (indic["includeInIndex"])! ).to(equal("0"))
                expect( indic["path"]! ).to(equal("Sample.app"))
                expect( indic["sourceTree"] ).to(equal("BUILT_PRODUCTS_DIR"))
            }
//
            it("array parsing test") {
                let stub = "{1FFB5ECE1F174CEC002F4A12={isa = PBXGroup;children=(1FFB5ECF1F174CEC002F4A12,1FFB5ED01F174CEC002F4A12,);path=GF_1;sourceTree=\"<group>\";};}"
                do {
                    let result = try parser?.start(string: stub)
                    expect(result).to(beAKindOf(Dictionary<String,Any>.self))
                    
                    let dic = result as! Dictionary<String,Any>
                    let indic = dic["1FFB5ECE1F174CEC002F4A12"] as! Dictionary<String,Any>
                    expect( indic["children"] ).to(beAKindOf(Array<Any>.self))
                    let ele = (indic["children"] as! Array<Any>)[0] as! String
                    expect( ele ).to(equal("1FFB5ED01F174CEC002F4A12"))
                    
                }catch {
                    print( error )
                    expect(false).to(equal(true))
                }

            }
            
            it( "full parse test" ) {
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                let clean = Parser.clear(string: string!)
                
                do {
                    let result = try parser!.start(string: clean)
                    print( result )
                } catch {
                    print( "error : [\(error)]" )
                    expect(false).to(equal(true))
                }
                
            }
        }
    }

}
