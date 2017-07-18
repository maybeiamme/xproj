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

class AnnotationSpec: QuickSpec {
    
    override func spec() {
        describe("Regex verification") {
            it("simple check") {

            }
            
            it("check is operator : {") {
                expect( Parse.isOperator(value: "{") ).to(equal(true))
            }
            
            it("check is operator : }") {
                expect( Parse.isOperator(value: "}") ).to(equal(true))
            }
            
            it("check is ignorable : }") {
                expect( Parse.ignore(value: "\n") ).to(equal(true))
            }
            
            it("check is ignorable : }") {
                expect( Parse.ignore(value: "\t") ).to(equal(true))
            }
            
        }
        
        describe("Parse all annotations") {
            it("parse all annotation test") {
                
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                
                let matches = Parse.parseAnnotations(string: string!)
                matches?.forEach{ match in
                    let s = string as! NSString
                    print( "matches : [\(s.substring(with: match.range))]" )
                }
                print( "matches count : [\(matches?.count)]")
                //                print( "matches : [\(Parse.parseAnnotations(string: string!) )] " )
            }
        }
        
        describe("Parse simple dictionary") {
            it("check parse") {
                
                let path = Bundle(for: ParseSpec.self).path(forResource: "stub", ofType: "pbxproj")
                let string = try? String(contentsOfFile: path!, encoding: .utf8)
                
                //                print( Parse.generateParsable(string: string!))
            }
        }
    }
    
}
