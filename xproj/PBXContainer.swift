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

protocol UUIDWithoutDuplicateProtocol {
    func generateHashValue() -> String?
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
    
    internal func new( generator: UUIDWithoutDuplicateProtocol ) throws -> T {
        guard let hashValue = generator.generateHashValue() else { throw PBXError.hashgeneration }
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
    
    internal mutating func findGroupByPath( parent: String, reversedPathArray: Array<String>, generateGroupIfNeeded: Bool, uuidGenerator: UUIDWithoutDuplicateProtocol ) throws -> PBXGroup {
        
        print( "-------------------findGroupByPath--------------------")
        print( "parent : [\(parent)]")
        print( "reversedPathArray : [\(reversedPathArray)]")
        print( "-------------------findGroupByPath--------------------")
        if reversedPathArray.isEmpty == true {
            guard let returnValue = groupByHashValue(hashValue: parent) else { throw ArgumentError.wronggroup }
            return returnValue
        }
        
        var stack = reversedPathArray.filter{ $0 != "" && $0 != "/" }
        guard let path = stack.popLast(),
            var parentGroup = groupByHashValue(hashValue: parent)
            else { throw ArgumentError.wronggroup }
        guard let children = parentGroup.children else { throw ArgumentError.wronggroup }
        let candidate = children.flatMap{ groupByHashValue(hashValue: $0) }.filter{ $0.path == path }
        if candidate.count <= 0 && generateGroupIfNeeded == true {
            var newGroup = try self.new( generator: uuidGenerator )
            newGroup.path = path
            newGroup.children = Array<String>()
            try add(new: newGroup)
            parentGroup.children = parentGroup.children == nil ? [newGroup.uuid] : parentGroup.children! + [newGroup.uuid]
            try modify(new: parentGroup)
            return try findGroupByPath(parent: newGroup.uuid, reversedPathArray: stack, generateGroupIfNeeded: generateGroupIfNeeded, uuidGenerator: uuidGenerator )
        } else if candidate.count <= 0 && generateGroupIfNeeded == false {
            throw ArgumentError.wronggroup
        }
        
        if candidate.count == 1, let first = candidate.first {
            return try findGroupByPath(parent: first.uuid, reversedPathArray: stack, generateGroupIfNeeded: generateGroupIfNeeded, uuidGenerator: uuidGenerator )
        }
        
        if candidate.count > 2 {
            throw ArgumentError.wronggroup
        }
        
        throw ArgumentError.wronggroup
    }
    
    internal func groupByHashValue( hashValue: String ) -> PBXGroup? {
        return items[hashValue]
    }
}

extension Container where T == PBXNativeTarget {
    internal func targetByName( name: String ) -> PBXNativeTarget? {
        for (_, value) in items {
            if value.name == name { return value }
        }
        return nil
    }
}

extension Container where T == PBXSourcesBuildPhase {
    internal func sourceFromBuildPhases( uuids: Array<String> ) -> PBXSourcesBuildPhase? {
        for (key, value) in items {
            if uuids.contains(key) { return value }
        }
        return nil
    }
}

protocol PBXParserProtocol {
    func start( string: String ) throws -> PBXCollection
}
