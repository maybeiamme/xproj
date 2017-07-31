//
//  File.swift
//  xproj
//
//  Created by Jin Hyong Park on 31/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

public enum FileError: Error {
    case notexist
    case failedtoread
    case failedtowrite
}

public struct File {
    public static func exists( path: String ) -> Bool {
        return FileManager.default.fileExists(atPath: path )
    }
    
    public static func read( path: String ) throws -> String {
        if File.exists(path: path) == false { throw FileError.notexist }
        do {
            return try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            throw FileError.failedtoread
        }
    }
    
    public static func write( path: String, contents: String ) throws {
        if File.exists(path: path) == false { throw FileError.notexist }
        do {
            try contents.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            throw FileError.failedtowrite
        }
    }
}
