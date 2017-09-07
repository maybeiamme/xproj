//
//  Errors.swift
//  xproj
//
//  Created by Jin Hyong Park on 31/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

public enum ArgumentError: Error {
    case wrongargument
    case wronggroup
    case emptydestination
    case emptytarget
    case emptyfiles
    case emptyproject
    case helpme
}

public enum ParseError: Error {
    case brokenSyntax
    case unknownNode
    case expectedSTRING
    case expectedNODE
    case expectedKEY
    case expectedKEYVALUE
}

public enum FileError: Error {
    case notexist
    case failedtoread
    case failedtowrite
    case notdirectory
}

public enum FatalError: Error {
    case notgonnabehappen
}

public enum CustomError: Error {
    case error( message: String )
    
    var description: String {
        switch self {
        case let .error( message ):
            return message
        }
    }
}

public struct Errors {
    
    static func handle( error: Error ) {
        switch error {
        case ArgumentError.emptydestination:
            print( "Wrong argument : destination is empty. Use --destination or -d")
        case ArgumentError.emptyfiles:
            print( "Wrong argument : files are empty. Use --files or -f")
        case ArgumentError.emptytarget:
            print( "Wrong argument : target is empty. Use --target or -t")
        case ArgumentError.emptyproject:
            print( "Wrong argument : project file not specified. Use --project or -p")
        case ArgumentError.wrongargument:
            print( "Wrong argument : Please use --help or -h" )
        case ArgumentError.helpme:
            print( "    \u{001B}[0;31m" + "All of the options below are compulsory." )
            print( "    \u{001B}[0;37m" + "    --destination, -d  <groupname>       Destination group in xcode project to insert files." );
            print( "    \u{001B}[0;37m" + "    --files, -f <file>                   Files to be added to xcode project" );
            print( "    \u{001B}[0;37m" + "    --target, -t <target>                Target to contain new files" );
            print( "    \u{001B}[0;37m" + "    --project, -p <projectfilepath>      Path of xcode project file. e.g : xproj.xcodeproj" );
            print( "" )
            print( "" )
            print( "    \u{001B}[0;32m" + "All of the options below are optional." )
            print( "    \u{001B}[0;37m" + "    --recursive, -r                      Find all files under the directory of --files option recursivly. <file> should be directory" );
            print( "" )
            print( "Example : xproj --destination /xproj/source/class --files ~/newdirectory -r --target xproj --project ~/workspace/xproj/xproj.xcodeproj" )
        default:
            print( error )
        }
    }
}
