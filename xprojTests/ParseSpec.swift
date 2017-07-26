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
        
        describe("Basic parser function test") {
            it("Is alphanumeric test should return all true") {
                let string = "abcdefghijklmnopqrstuvwxyz"
                let uppercase = string.uppercased()
                let numeric = "1234567890"
                
                for s in string.characters {
                    expect(Parser.isAlphaNumeric(value: s)).to(equal(true))
                }
                
                for s in uppercase.characters {
                    expect(Parser.isAlphaNumeric(value: s)).to(equal(true))
                }
                
                for s in numeric.characters {
                    expect(Parser.isAlphaNumeric(value: s)).to(equal(true))
                }
            }
            
            it("Is alphanumeric test should return all false") {
                let string = "{};="
                
                for s in string.characters {
                    expect(Parser.isAlphaNumeric(value: s)).to(equal(false))
                }
            }
            
            it("Is delimiter test should return all true") {
                let string = "{}=()"
                
                for s in string.characters {
                    expect(Parser.isAcceptedDelimiters(value: s)).to(equal(true))
                }
            }
            
            it("Is delimiter test should return all false") {
                let string = "abcdefghijklmnopqrstuvwxyz"
                let uppercase = string.uppercased()
                let numeric = "1234567890"
                
                for s in string.characters {
                    expect(Parser.isAcceptedDelimiters(value: s)).to(equal(false))
                }
                
                for s in uppercase.characters {
                    expect(Parser.isAcceptedDelimiters(value: s)).to(equal(false))
                }
                
                for s in numeric.characters {
                    expect(Parser.isAcceptedDelimiters(value: s)).to(equal(false))
                }
            }
        }
        
        describe("Basic parsing test") {
            it("Simple key and value test") {
                let stub = "{isa=PBXBuildFile;};"
                let result = try? parser?.start(string: stub)
                expect(result!).to(beAKindOf(Dictionary<String,Any>.self))
            }
            
            it("multiple key and values test") {
                let stub = "{isa=PBXBuildFile;fileRef=1FFB5EB91F173360002F4A12;};"
                let result = try? parser?.start(string: stub)
                expect(result!).to(beAKindOf(Dictionary<String,Any>.self))
                let dic = result as! Dictionary<String,Any>
                expect( dic["isa"] as? String ).to(equal("PBXBuildFile"))
                expect( dic["fileRef"] as? String ).to(equal("1FFB5EB91F173360002F4A12"))
            }
            
            it("dictionary in dictionary test") {
                let stub = "{1FFB5EB61F173360002F4A12={isa=PBXFileReference;explicitFileType=wrapper.application;includeInIndex=0;path=Sample.app;sourceTree=BUILT_PRODUCTS_DIR;};};"
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
            
            it("array parsing test") {
                let stub = "{1FFB5ECE1F174CEC002F4A12={isa = PBXGroup;children=(1FFB5ECF1F174CEC002F4A12,1FFB5ED01F174CEC002F4A12,);path=GF_1;sourceTree=\"<group>\";};};"
                let result = try? parser?.start(string: stub)
                expect(result!).to(beAKindOf(Dictionary<String,Any>.self))
                
                let dic = result as! Dictionary<String,Any>
                let indic = dic["1FFB5ECE1F174CEC002F4A12"] as! Dictionary<String,Any>
                expect( indic["children"] ).to(beAKindOf(Array<Any>.self))
                let ele = (indic["children"] as! Array<Any>)[0] as! String
                expect( ele ).to(equal("1FFB5ECF1F174CEC002F4A12"))
            }
        }
    }

}
