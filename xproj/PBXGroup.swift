//
//  PBXGroup.swift
//  xproj
//
//  Created by Jin Hyong Park on 26/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//

import Cocoa

internal struct PBXGroupContainer {
    internal static func parse( string: String ) -> Array<String>? {
        do {
            
            let regex = try NSRegularExpression(pattern: "\\/\\* Begin PBXGroup section \\*\\/[A-z|.|\\n|\\t|0-9| |=|{|}|(|)|;|\\*|\\/|,|\\\"|<|>]*\\/\\* End PBXGroup section \\*\\/", options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count) )
            
            let nsstring = string as NSString
            
            return matches.map{ nsstring.substring(with: $0.range) }
        } catch {
            print( error )
            return nil
        }
    }
    
    internal var items: Array<PBXGroup>
    
    init( string: String ) throws {
        guard let parsed = PBXGroupContainer.parse(string: string), let first = parsed.first else { throw ParseError.brokenSyntax }
        let readyToParse = "{" + Parser.clear(string: first) + "};"
        let parser = Parser()
        let dic = try parser.start(string: readyToParse)
        guard let dictionary = dic as? Dictionary<String,Dictionary<String,Any>> else { throw ParseError.brokenSyntax }
        
        items = dictionary.map{ key, value in
            let component = PBXGroup(uuid: key,
                                     children: value["children"] as? Array<String>,
                                     name: value["name"] as? String,
                                     sourceTree: value["sourceTree"] as? String,
                                     path: value["path"] as? String)
            return component
        }
    }
}

internal struct PBXGroup: AutoEquatable {
//    internal static func parse( string: String? ) throws -> PBXGroup? {
//        let parser = Parser()
//        guard let string = string else { return nil }
//        let readyToParse = "{" + Parser.clear(string: string) + "};"
//        let result = try parser.start(string: readyToParse)
//        
//        guard let dictionary = result as? Dictionary<String,Any>,
//            let uuid = dictionary.keys.first, let info = dictionary[uuid] as? Dictionary<String,Any> else { throw ParseError.brokenSyntax }
//
//        let component = PBXGroup(uuid: uuid,
//                                 children: info["children"] as? Array<String>,
//                                 name: info["name"] as? String,
//                                 sourceTree: info["sourceTree"] as? String,
//                                 path: info["path"] as? String)
//        return component
//    }
    
    let uuid: String
    let isa = "PBXGroup"
    let children: Array<String>?
    let name: String?
    let sourceTree: String?
    let path: String?
}

