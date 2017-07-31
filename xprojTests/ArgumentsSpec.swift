//
//  ArgumentsSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 31/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Quick
import Nimble

class ArgumentsSpec: QuickSpec {
    
    override func spec() {
        describe("Arguments test") {
            
            it("isOption test") {
                expect(Arguments.isOption(argument: "-v")).to(equal(true))
                expect(Arguments.isOption(argument: "--v")).to(equal(true))
                expect(Arguments.isOption(argument: "---v")).to(equal(true))
                expect(Arguments.isOption(argument: "+v")).to(equal(false))
                expect(Arguments.isOption(argument: "v")).to(equal(false))
                expect(Arguments.isOption(argument: "vvv")).to(equal(false))
            }
            
            
            it( "which option test") {
                expect(Arguments.whichOption(argument: "-verbose")).notTo(equal(ArgumentOption.verbose))
                expect(Arguments.whichOption(argument: "-verbose")).notTo(equal(ArgumentOption.verbose))
                expect(Arguments.whichOption(argument: "-recursive")).notTo(equal(ArgumentOption.verbose))
                expect(Arguments.whichOption(argument: "-else")).to(equal(ArgumentOption.unknown))
                expect(Arguments.whichOption(argument: "--else")).to(equal(ArgumentOption.unknown))
                expect(Arguments.whichOption(argument: "")).to(equal(ArgumentOption.unknown))
                
                expect(Arguments.whichOption(argument: "-v")).to(equal(ArgumentOption.verbose))
                expect(Arguments.whichOption(argument: "--verbose")).to(equal(ArgumentOption.verbose))
                expect(Arguments.whichOption(argument: "-t")).to(equal(ArgumentOption.target))
                expect(Arguments.whichOption(argument: "--target")).to(equal(ArgumentOption.target))
                expect(Arguments.whichOption(argument: "-r")).to(equal(ArgumentOption.recursive))
                expect(Arguments.whichOption(argument: "--recursive")).to(equal(ArgumentOption.recursive))
                expect(Arguments.whichOption(argument: "-d")).to(equal(ArgumentOption.destination))
                expect(Arguments.whichOption(argument: "--destination")).to(equal(ArgumentOption.destination))
                expect(Arguments.whichOption(argument: "-f")).to(equal(ArgumentOption.files))
                expect(Arguments.whichOption(argument: "--files")).to(equal(ArgumentOption.files))
            }
            
            it( "full arguemnt parse test should throw error" ) {
                expect{ try Arguments(args: ["--target", "target"]) }.to( throwError() )
                expect{ try Arguments(args: ["-v", "verbose"]) }.to( throwError() )
                expect{ try Arguments(args: ["-r", "verbose", "--files", "b", "c", "d"]) }.to( throwError() )
                expect{ try Arguments(args: ["--verbose", "verbose"]) }.to( throwError() )
                expect{ try Arguments(args: ["--random"]) }.to( throwError() )
            }
            
            it( "argument test success case test") {
                expect{ try Arguments(args: ["runningfile", "--target", "target", "--files", "a", "b", "c", "--verbose", "-v", "--destination", "dest", "-p", "./project"]) }.notTo( throwError() )
                let argu = try! Arguments(args: ["runningfile", "--target", "target", "--files", "a", "b", "c", "--verbose", "-v", "--destination", "dest", "-p", "./project"])
                expect(argu.files).to(equal(["a", "b", "c"]))
                expect(argu.target).to(equal("target"))
                expect(argu.verbose).to(equal(true))
                expect(argu.recursive).to(equal(false))
                expect(argu.destination).to(equal("dest"))
            }
            
            it( "argument help test") {
                expect{ try Arguments(args: ["runningfile", "--help", "--target", "target", "--files", "a", "b", "c", "--verbose", "-v", "--destination", "dest"]) }.to( throwError() )
            }
            
            it( "relative filepath test" ) {
                let argu = try! Arguments(args: ["/Absolute/File/Path/Run", "--target", "target", "--files", "./a", "/b", "./c/d/e", "--verbose", "-v", "--destination", "dest", "-p", "./project"])
                let absolutePath = "/Absolute/File/Path/"
                expect(argu.files).to(equal([absolutePath + "a","/b",absolutePath + "c/d/e"]))
                expect( argu.project ).to(equal(absolutePath + "project"))
            }
        }
    }
}
