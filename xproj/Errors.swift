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
            print( "Help message should be here" )
            print( "    --destination, -d       Destination group to insert files." );
            print( "    \u{001B}[0;32m" +  "maybe colored?" )
            print( "    \u{001B}[0;37m" +  "maybe colored?" )
            print( "    \u{001B}[0;31m" +  "maybe colored?" )
            print( "    \u{001B}[0;33m" +  "maybe colored?" )
            print( "    \u{001B}[0;32m" +  "maybe colored?" )
        default:
            print( "What did you do...?" )
        }
    }
}
