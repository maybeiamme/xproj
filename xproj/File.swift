//
//  File.swift
//  xproj
//
//  Created by Jin Hyong Park on 31/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

public protocol FileProtocol: AutoMockable {
    static func exists( path: String ) -> Bool
    static func isDirectory( path: String) -> Bool
    static func read( path: String ) throws -> String
    static func write( path: String, contents: String ) throws
    static func allContents( at path: String ) throws -> Array<String>
}

public struct File: FileProtocol {
    public static func exists( path: String ) -> Bool {
        return FileManager.default.fileExists(atPath: path )
    }
    
    public static func isDirectory( path: String) -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    public static func read( path: String ) throws -> String {
        print( "read file : [\(path)]")
        if File.exists(path: path) == false { throw FileError.notexist }
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            throw FileError.failedtoread
        }
    }
    
    public static func write( path: String, contents: String ) throws {
        print( "write file : [\(contents)]")
        if File.exists(path: path) == false { throw FileError.notexist }
        do {
            try contents.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            throw FileError.failedtowrite
        }
    }
    
    public static func allContents( at path: String ) throws -> Array<String> {
        do {
            let allContent = try FileManager.default.subpathsOfDirectory(atPath: path)
            return allContent.map{ (path as NSString).appendingPathComponent($0) }
        } catch {
            throw FileError.failedtoread
        }
    }
}
