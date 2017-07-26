//
//  PBXBuildFile.swift
//  xproj
//
//  Created by Jin Hyong Park on 25/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXBuildFileContainer {
    internal static func parse( string: String ) -> Array<String>? {
        do {
            let regex = try NSRegularExpression(pattern: ".*isa = PBXBuildFile.*", options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count) )
            
            let nsstring = string as NSString
            return matches.map{ nsstring.substring(with: $0.range) }
        } catch {
            print( error )
            return nil
        }
    }
    
    internal var items: Array<PBXBuildFile>
    
    init( string: String ) throws {
        guard let parsed = PBXBuildFileContainer.parse(string: string) else { throw ParseError.brokenSyntax }
        items = try parsed.flatMap{ try PBXBuildFile.parse(string: $0 ) }
    }
}

internal struct PBXBuildFile: AutoEquatable {
    internal static func parse( string: String? ) throws -> PBXBuildFile? {
        let parser = Parser()
        guard let string = string else { return nil }
        let readyToParse = "{" + Parser.clear(string: string) + "};"
        let result = try parser.start(string: readyToParse)
        
        guard let dictionary = result as? Dictionary<String,Any>,
            let uuid = dictionary.keys.first,
            let content = dictionary[uuid] as? Dictionary<String,Any>,
            let fileRef = content["fileRef"] as? String else { throw ParseError.brokenSyntax }
        
        let component = PBXBuildFile(uuid: uuid, fileRef: fileRef)
        return component
    }
    
    init( uuid: String, fileRef: String ) {
        self.uuid = uuid
        self.fileRef = fileRef
    }


    
    let uuid: String
    let isa = "PBXBuildFile"
    let fileRef: String
}

