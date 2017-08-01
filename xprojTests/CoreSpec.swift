//
//  CoreSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 1/8/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Quick
import Nimble

class CoreSpec: QuickSpec {
    
    override func spec() {
        describe("Core spec") {
            
            class ArgumentsMockWithProjectFilePath: ArgumentsProtocol {
                var target: String { return "Target" }
                var destination: String { return "/path/from/sourcetoot" }
                var recursive: Bool { return false }
                var verbose: Bool { return false }
                var files: Array<String> { return ["notdirectory", "notdirectory", "notdirectory"] }
                var project: String { return "/project/p.xcproj" }
            }
            
            class FileMock: FileProtocol {
                static func exists(path: String) -> Bool {
                    return true
                }
                
                static func isDirectory( path: String) -> Bool {
                    if path == "notdirectory" { return false }
                    return true
                }
                static func read( path: String ) throws -> String {
                    if path == "/project/p.xcproj/project.pbxproj" { return "Success" }
                    return ""
                }
                static func write( path: String, contents: String ) throws {
                    
                }
                static func allContents( at path: String ) throws -> Array<String> {
                    return Array<String>()
                }
            }
            
            it("Project file test") {
                let arg = ArgumentsMockWithProjectFilePath()
                var core = Core(argument: arg)
                core.fileManager = FileMock.self
                core.processArgument()
                expect( core.projectfile ).to(equal("Success"))
            }
            
            it("files without recursive test") {
                let arg = ArgumentsMockWithProjectFilePath()
                var core = Core(argument: arg)
                core.fileManager = FileMock.self
                core.processArgument()
                expect( core.filesMustBeAdded ).to(equal(["/path/from/sourcetoot/notdirectory", "/path/from/sourcetoot/notdirectory", "/path/from/sourcetoot/notdirectory"]))
            }
            
            class FileMockRecursive: FileProtocol {
                static func exists(path: String) -> Bool {
                    return true
                }
                
                static func isDirectory( path: String) -> Bool {
                    if path.contains(".swift") { return false }
                    return true
                }
                static func read( path: String ) throws -> String {
                    if path == "/project/p.xcproj/project.pbxproj" { return "Success" }
                    return ""
                }
                static func write( path: String, contents: String ) throws {
                    
                }
                static func allContents( at path: String ) throws -> Array<String> {
                    if path == "directory" { return ["1.swift","2.swift","3"] }
                    else if path == "d" { return ["4.swift","5.swift","6"] }
                    else { return ["7.swift","8.swift","9"] }
                }
            }
            class ArgumentsMockRecursive: ArgumentsProtocol {
                var target: String { return "Target" }
                var destination: String { return "/path/from/sourcetoot" }
                var recursive: Bool { return true }
                var verbose: Bool { return false }
                var files: Array<String> { return ["directory", "dir", "d"] }
                var project: String { return "/project/p.xcproj" }
            }
            
            it( "files with recursive test" ) {
                let arg = ArgumentsMockRecursive()
                var core = Core(argument: arg)
                core.fileManager = FileMockRecursive.self
                core.processArgument()
                
                expect( core.filesMustBeAdded ).to(equal(["/path/from/sourcetoot/1.swift", "/path/from/sourcetoot/2.swift", "/path/from/sourcetoot/7.swift", "/path/from/sourcetoot/8.swift", "/path/from/sourcetoot/4.swift", "/path/from/sourcetoot/5.swift"]))
                expect( core.groupsMustBeAdded ).to(equal(["/path/from/sourcetoot/3", "/path/from/sourcetoot/9", "/path/from/sourcetoot/6"]))
            }
        }
    }
}
