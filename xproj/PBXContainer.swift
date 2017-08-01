//
//  PBXContainer.swift
//  xproj
//
//  Created by Jin Hyong Park on 27/7/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Cocoa

enum PBXError: Error {
    case hashgeneration
}

protocol PBXType {
    static var identity: String { get }
    init( uuid: String, data: Dictionary<String,Any> ) throws
    var uuid: String { get }
    var isa: String { get }
    func returnKeyvalue() throws -> KEYVALUE
}

protocol UUIDGeneratorProtocol {
    static func generate() -> String
}

internal struct UUIDGenerator: UUIDGeneratorProtocol {
    static func generate() -> String {
        let uuid = UUID().uuid
        let generated = String( format: "%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", uuid.0, uuid.1, uuid.2, uuid.3, uuid.4, uuid.5, uuid.6, uuid.7, uuid.8, uuid.9, uuid.10, uuid.11)
        return generated
    }
}

internal struct Container<T: PBXType> {
    internal var items: Dictionary<String,T>
    private var rawValue: PBXCollection
    
    init( data: PBXCollection ) throws {
        var dictionary: Dictionary<String,T> = Dictionary<String,T>()
        for (key, value) in data.dictionary {
            if let collection = value as? PBXCollection, let string = collection.dictionary["isa"] as? String, string == T.identity {
                dictionary[key] = try T(uuid: key, data: collection.dictionary)
            }
        }
        items = dictionary
        rawValue = PBXCollection(array: data.array.filter{ dictionary.keys.contains($0.key) == true }, dictionary: dictionary)
    }
    
    internal func toString( newline: Bool ) -> String {
        var strings: Array<String> = Array<String>()
        for keyvalue in rawValue.array {
            let newString = keyvalue.key + " = " + valueToString(value: keyvalue.value, newline: newline) + ";"
            strings.append(newString)
        }
        return strings.joined(separator: "\n")
    }
    
    internal func new() throws -> T {
        guard let hashValue = PBXObject.shared.generateHashValue() else { throw PBXError.hashgeneration }
        let new = try T(uuid: hashValue, data: ["isa": T.identity])
        return new
    }
    
    internal mutating func add( new: T ) throws {
        items[new.uuid] = new
        var keyvalues = rawValue.array
        keyvalues.append( try new.returnKeyvalue() )
        rawValue = PBXCollection(array: keyvalues, dictionary: items)
    }
    
    internal mutating func modify( new: T ) throws {
        items[new.uuid] = new
        var keyvalues = rawValue.array.filter{ $0.key != new.uuid }
        keyvalues.append( try new.returnKeyvalue() )
        rawValue = PBXCollection(array: keyvalues, dictionary: items)
    }
    
    internal mutating func generateAllGroupsIfNeeded( base: String, path: String ) throws {
        let baseInPathComponenets = (base as NSString).pathComponents
        
    }
    
    internal func generateProjectWithCurrent( string: String, newline: Bool ) throws -> String {
        let regex = try NSRegularExpression(pattern: "\\/\\* Begin \(T.identity) section \\*\\/[A-z|0-9|\\n|\\t| |\\/|\\*|.|=|{|}|(|)|;|\\\"|<|>|,|-|+|$|\\-|@]*\\/\\* End \(T.identity) section \\*\\/", options: NSRegularExpression.Options.caseInsensitive)
        let template = "/* Begin \(T.identity) section */\n" + toString(newline: newline) + "\n/* End \(T.identity) section */"
        return regex.stringByReplacingMatches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: string.characters.count), withTemplate: template)
    }
    
    private func valueToString( value: Any, newline: Bool ) -> String {
        if let string = value as? String {
            return string
        } else if let collection = value as? PBXCollection {
            var strings: Array<String> = Array<String>()
            let separator = newline == true ? "\n" : " "
            let tab = newline == true ? "\t" : ""
            for keyvalue in collection.array {
                let newString = tab + keyvalue.key + " = " + valueToString(value: keyvalue.value, newline: newline) + ";"
                strings.append(newString)
            }
            return "{" + separator + strings.joined(separator: separator) + separator + "}"
        } else if let array = value as? Array<Any> {
            var strings: Array<String> = Array<String>()
            let separator = newline == true ? "\n" : " "
            let tab = newline == true ? "\t" : ""
            for v in array {
                let newString = tab + valueToString(value: v, newline: newline) + (array.count > 1 ? "," : "")
                strings.append(newString)
            }
            return "(" + separator + strings.joined(separator: separator) + separator + ")"
        }
        return ""
    }
}

extension Container where T == PBXGroup {
    internal func groupByPath( path: String ) -> PBXGroup? {
        for (_, value) in items {
            if value.path == path { return value }
        }
        return nil
    }
    
    internal func groupsByPath( path: String ) -> Array<PBXGroup> {
        var array = Array<PBXGroup>()
        for (_, value) in items {
            if value.path == path { array.append(value) }
        }
        return array
    }
    
    internal func trace( path: String, mainGroupId: String ) {
        var current: String?
        current = mainGroupId
        let components = path.components(separatedBy: "/")
        for component in components {
            if let hashValue = current, let group = groupByHashValue(hashValue: hashValue) {
                let tracked = group.children?.map{ hash in
                    return groupByHashValue(hashValue: hash)!
                }.filter{ g in
                    return g.uuid == component
                }.first
                current = tracked?.uuid
            } else {
//                not found
            }
        }
        
    }
    
    internal func groupByPathComponents( reversed paths: Array<String>, inGroup: Array<PBXGroup> ) throws -> PBXGroup {
        var stack = paths
        if let last = stack.popLast() {
            if stack.isEmpty == true {
                let newgroup = inGroup.filter{ $0.path == last }
                if newgroup.count == 1 { return newgroup.first! }
                else { throw ArgumentError.wronggroup }
            } else {
                let newgroup = inGroup.filter{ $0.path == last }.flatMap{ $0.children }.flatMap{ $0.flatMap{ groupByHashValue(hashValue: $0) } }
                
                if newgroup.count <= 0 { throw ArgumentError.wronggroup }
                return try groupByPathComponents(reversed: stack, inGroup: newgroup)
            }
        }
        throw ArgumentError.wronggroup
    }
    
    internal func groupByHashValue( hashValue: String ) -> PBXGroup? {
        return items[hashValue]
    }
}

protocol PBXParserProtocol {
    func start( string: String ) throws -> PBXCollection
}
