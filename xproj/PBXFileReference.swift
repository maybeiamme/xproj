//
//  PBXFileReference.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXFileReferenceContainer {
    internal static func parse( string: String ) -> Array<String>? {
        do {
            let regex = try NSRegularExpression(pattern: ".*isa = PBXFileReference.*", options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count) )
            
            let nsstring = string as NSString
            return matches.map{ nsstring.substring(with: $0.range) }
        } catch {
            print( error )
            return nil
        }
    }
    
    internal var items: Array<PBXFileReference>
    
    init( string: String ) throws {
        guard let parsed = PBXFileReferenceContainer.parse(string: string) else { throw ParseError.brokenSyntax }
        items = try parsed.flatMap{ try PBXFileReference.parse(string: $0 ) }
    }
}

internal struct PBXFileReference: AutoEquatable {
    internal static func parse( string: String? ) throws -> PBXFileReference? {
        let parser = Parser()
        guard let string = string else { return nil }
        let readyToParse = "{" + Parser.clear(string: string) + "};"
        let result = try parser.start(string: readyToParse)
        
        guard let dictionary = result as? Dictionary<String,Any>,
            let uuid = dictionary.keys.first, let info = dictionary[uuid] as? Dictionary<String,Any> else { throw ParseError.brokenSyntax }
        
        let component = PBXFileReference(uuid: uuid,
                                         explicitFileType: info["explicitFileType"] as? String,
                                         includeInIndex: info["includeInIndex"] as? String,
                                         path: info["path"] as? String,
                                         sourceTree: info["sourceTree"] as? String,
                                         name: info["name"] as? String)
        return component
    }
    
    let uuid: String
    let isa = "PBXFileReference"
    let explicitFileType: String?
    let includeInIndex: String?
    let path: String?
    let sourceTree: String?
    let name: String?
}

