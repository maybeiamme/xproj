// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// swiftlint:disable file_length
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - PBXBuildFile AutoEquatable
extension PBXBuildFile: Equatable {}
internal func == (lhs: PBXBuildFile, rhs: PBXBuildFile) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
    guard compareOptionals(lhs: lhs.fileRef, rhs: rhs.fileRef, compare: ==) else { return false }
    return true
}
// MARK: - PBXFileReference AutoEquatable
extension PBXFileReference: Equatable {}
internal func == (lhs: PBXFileReference, rhs: PBXFileReference) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
    guard compareOptionals(lhs: lhs.fileEncoding, rhs: rhs.fileEncoding, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.lastKnownFileType, rhs: rhs.lastKnownFileType, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.explicitFileType, rhs: rhs.explicitFileType, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.includeInIndex, rhs: rhs.includeInIndex, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.path, rhs: rhs.path, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.sourceTree, rhs: rhs.sourceTree, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    return true
}
// MARK: - PBXGroup AutoEquatable
extension PBXGroup: Equatable {}
internal func == (lhs: PBXGroup, rhs: PBXGroup) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
    guard compareOptionals(lhs: lhs.children, rhs: rhs.children, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.sourceTree, rhs: rhs.sourceTree, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.path, rhs: rhs.path, compare: ==) else { return false }
    return true
}
// MARK: - PBXNativeTarget AutoEquatable
extension PBXNativeTarget: Equatable {}
internal func == (lhs: PBXNativeTarget, rhs: PBXNativeTarget) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
    guard compareOptionals(lhs: lhs.buildConfigurationList, rhs: rhs.buildConfigurationList, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.buildPhases, rhs: rhs.buildPhases, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.buildRules, rhs: rhs.buildRules, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.dependencies, rhs: rhs.dependencies, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.name, rhs: rhs.name, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.productName, rhs: rhs.productName, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.productReference, rhs: rhs.productReference, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.productType, rhs: rhs.productType, compare: ==) else { return false }
    return true
}
// MARK: - PBXProject AutoEquatable
extension PBXProject: Equatable {}
internal func == (lhs: PBXProject, rhs: PBXProject) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
    guard compareOptionals(lhs: lhs.mainGroup, rhs: rhs.mainGroup, compare: ==) else { return false }
    return true
}
// MARK: - PBXSourcesBuildPhase AutoEquatable
extension PBXSourcesBuildPhase: Equatable {}
internal func == (lhs: PBXSourcesBuildPhase, rhs: PBXSourcesBuildPhase) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
    guard compareOptionals(lhs: lhs.buildActionMask, rhs: rhs.buildActionMask, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.files, rhs: rhs.files, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.runOnlyForDeploymentPostprocessing, rhs: rhs.runOnlyForDeploymentPostprocessing, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatable for Enums

// swiftlint:disable file_length
// swiftlint:disable line_length

fileprivate func combineHashes(_ hashes: [Int]) -> Int {
    return hashes.reduce(0, combineHashValues)
}

fileprivate func combineHashValues(_ initial: Int, _ other: Int) -> Int {
    #if arch(x86_64) || arch(arm64)
        let magic: UInt = 0x9e3779b97f4a7c15
    #elseif arch(i386) || arch(arm)
        let magic: UInt = 0x9e3779b9
    #endif
    var lhs = UInt(bitPattern: initial)
    let rhs = UInt(bitPattern: other)
    lhs ^= rhs &+ magic &+ (lhs << 6) &+ (lhs >> 2)
    return Int(bitPattern: lhs)
}


// MARK: - AutoHashable for classes, protocols, structs

// MARK: - AutoHashable for Enums

// MARK: - ArgumentOption AutoHashable
extension ArgumentOption: Hashable {
    public var hashValue: Int {
        switch self {
        case .verbose:
            return 1.hashValue
        case .target:
            return 2.hashValue
        case .files:
            return 3.hashValue
        case .destination:
            return 4.hashValue
        case .recursive:
            return 5.hashValue
        case .project:
            return 6.hashValue
        case .unknown:
            return 7.hashValue
        case .help:
            return 8.hashValue
        }
    }
}

// swiftlint:disable line_length

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif





class ArgumentsProtocolMock: ArgumentsProtocol {
    var target: String
    var destination: String
    var recursive: Bool
    var verbose: Bool
    var files: Array<String> = []
    var project: String


    init( target: String, destination: String, recursive: Bool, verbose: Bool, files: Array<String>, project: String ) {
        self.target = target
        self.destination = destination
        self.recursive = recursive
        self.verbose = verbose
        self.files = files
        self.project = project
    }

}

class FileProtocolMock: FileProtocol {

    //MARK: - exists

    static var existsReturnValue: Bool?

    static func exists( path: String ) -> Bool {

        return existsReturnValue!
    }
    //MARK: - isDirectory

    static var isDirectoryReturnValue: Bool?

    static func isDirectory( path: String) -> Bool {

        return isDirectoryReturnValue!
    }
    //MARK: - read

    static var readReturnValue: String?

    static func read( path: String ) -> String {

        return readReturnValue!
    }
    //MARK: - write


    static func write( path: String, contents: String ) {

    }
    //MARK: - allContents

    static var allContentsReturnValue: Array<String>?

    static func allContents( at path: String ) -> Array<String> {

        return allContentsReturnValue!
    }


}


// swiftlint:disable file_length
// MARK: - PBXBuildFile PBXType
extension PBXBuildFile {
    func returnKeyvalue() throws -> KEYVALUE {
        let key = KEY(node: STRING(content: uuid))
        var allvalues: Array<KEYVALUE> = Array<KEYVALUE>()
        var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()

        allvalues.append( try KEYVALUE(key: STRING(content: "isa"), value: STRING(content: PBXBuildFile.identity)))
        if let fileRef = fileRef {
            allvalues.append( try KEYVALUE(key: STRING(content: "fileRef"), value: STRING(content: fileRef)) )
            dictionary["fileRef"] = fileRef
        }
        return try KEYVALUE(key: key, value: PBXCollection(array: allvalues, dictionary: dictionary) )
    }
}
// MARK: - PBXFileReference PBXType
extension PBXFileReference {
    func returnKeyvalue() throws -> KEYVALUE {
        let key = KEY(node: STRING(content: uuid))
        var allvalues: Array<KEYVALUE> = Array<KEYVALUE>()
        var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()

        allvalues.append( try KEYVALUE(key: STRING(content: "isa"), value: STRING(content: PBXFileReference.identity)))
        if let fileEncoding = fileEncoding {
            allvalues.append( try KEYVALUE(key: STRING(content: "fileEncoding"), value: STRING(content: fileEncoding)) )
            dictionary["fileEncoding"] = fileEncoding
        }
        if let lastKnownFileType = lastKnownFileType {
            allvalues.append( try KEYVALUE(key: STRING(content: "lastKnownFileType"), value: STRING(content: lastKnownFileType)) )
            dictionary["lastKnownFileType"] = lastKnownFileType
        }
        if let explicitFileType = explicitFileType {
            allvalues.append( try KEYVALUE(key: STRING(content: "explicitFileType"), value: STRING(content: explicitFileType)) )
            dictionary["explicitFileType"] = explicitFileType
        }
        if let includeInIndex = includeInIndex {
            allvalues.append( try KEYVALUE(key: STRING(content: "includeInIndex"), value: STRING(content: includeInIndex)) )
            dictionary["includeInIndex"] = includeInIndex
        }
        if let path = path {
            allvalues.append( try KEYVALUE(key: STRING(content: "path"), value: STRING(content: path)) )
            dictionary["path"] = path
        }
        if let sourceTree = sourceTree {
            allvalues.append( try KEYVALUE(key: STRING(content: "sourceTree"), value: STRING(content: sourceTree)) )
            dictionary["sourceTree"] = sourceTree
        }
        if let name = name {
            allvalues.append( try KEYVALUE(key: STRING(content: "name"), value: STRING(content: name)) )
            dictionary["name"] = name
        }
        return try KEYVALUE(key: key, value: PBXCollection(array: allvalues, dictionary: dictionary) )
    }
}
// MARK: - PBXGroup PBXType
extension PBXGroup {
    func returnKeyvalue() throws -> KEYVALUE {
        let key = KEY(node: STRING(content: uuid))
        var allvalues: Array<KEYVALUE> = Array<KEYVALUE>()
        var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()

        allvalues.append( try KEYVALUE(key: STRING(content: "isa"), value: STRING(content: PBXGroup.identity)))
        if let children = children {
            allvalues.append( try KEYVALUE(key: STRING(content: "children"), value: children) )
            dictionary["children"] = children
        }
        if let name = name {
            allvalues.append( try KEYVALUE(key: STRING(content: "name"), value: STRING(content: name)) )
            dictionary["name"] = name
        }
        if let sourceTree = sourceTree {
            allvalues.append( try KEYVALUE(key: STRING(content: "sourceTree"), value: STRING(content: sourceTree)) )
            dictionary["sourceTree"] = sourceTree
        }
        if let path = path {
            allvalues.append( try KEYVALUE(key: STRING(content: "path"), value: STRING(content: path)) )
            dictionary["path"] = path
        }
        return try KEYVALUE(key: key, value: PBXCollection(array: allvalues, dictionary: dictionary) )
    }
}
// MARK: - PBXNativeTarget PBXType
extension PBXNativeTarget {
    func returnKeyvalue() throws -> KEYVALUE {
        let key = KEY(node: STRING(content: uuid))
        var allvalues: Array<KEYVALUE> = Array<KEYVALUE>()
        var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()

        allvalues.append( try KEYVALUE(key: STRING(content: "isa"), value: STRING(content: PBXNativeTarget.identity)))
        if let buildConfigurationList = buildConfigurationList {
            allvalues.append( try KEYVALUE(key: STRING(content: "buildConfigurationList"), value: STRING(content: buildConfigurationList)) )
            dictionary["buildConfigurationList"] = buildConfigurationList
        }
        if let buildPhases = buildPhases {
            allvalues.append( try KEYVALUE(key: STRING(content: "buildPhases"), value: buildPhases) )
            dictionary["buildPhases"] = buildPhases
        }
        if let buildRules = buildRules {
            allvalues.append( try KEYVALUE(key: STRING(content: "buildRules"), value: buildRules) )
            dictionary["buildRules"] = buildRules
        }
        if let dependencies = dependencies {
            allvalues.append( try KEYVALUE(key: STRING(content: "dependencies"), value: dependencies) )
            dictionary["dependencies"] = dependencies
        }
        if let name = name {
            allvalues.append( try KEYVALUE(key: STRING(content: "name"), value: STRING(content: name)) )
            dictionary["name"] = name
        }
        if let productName = productName {
            allvalues.append( try KEYVALUE(key: STRING(content: "productName"), value: STRING(content: productName)) )
            dictionary["productName"] = productName
        }
        if let productReference = productReference {
            allvalues.append( try KEYVALUE(key: STRING(content: "productReference"), value: STRING(content: productReference)) )
            dictionary["productReference"] = productReference
        }
        if let productType = productType {
            allvalues.append( try KEYVALUE(key: STRING(content: "productType"), value: STRING(content: productType)) )
            dictionary["productType"] = productType
        }
        return try KEYVALUE(key: key, value: PBXCollection(array: allvalues, dictionary: dictionary) )
    }
}
// MARK: - PBXProject PBXType
extension PBXProject {
    func returnKeyvalue() throws -> KEYVALUE {
        let key = KEY(node: STRING(content: uuid))
        var allvalues: Array<KEYVALUE> = Array<KEYVALUE>()
        var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()

        allvalues.append( try KEYVALUE(key: STRING(content: "isa"), value: STRING(content: PBXProject.identity)))
        if let mainGroup = mainGroup {
            allvalues.append( try KEYVALUE(key: STRING(content: "mainGroup"), value: STRING(content: mainGroup)) )
            dictionary["mainGroup"] = mainGroup
        }
        return try KEYVALUE(key: key, value: PBXCollection(array: allvalues, dictionary: dictionary) )
    }
}
// MARK: - PBXSourcesBuildPhase PBXType
extension PBXSourcesBuildPhase {
    func returnKeyvalue() throws -> KEYVALUE {
        let key = KEY(node: STRING(content: uuid))
        var allvalues: Array<KEYVALUE> = Array<KEYVALUE>()
        var dictionary: Dictionary<String,Any> = Dictionary<String,Any>()

        allvalues.append( try KEYVALUE(key: STRING(content: "isa"), value: STRING(content: PBXSourcesBuildPhase.identity)))
        if let buildActionMask = buildActionMask {
            allvalues.append( try KEYVALUE(key: STRING(content: "buildActionMask"), value: STRING(content: buildActionMask)) )
            dictionary["buildActionMask"] = buildActionMask
        }
        if let files = files {
            allvalues.append( try KEYVALUE(key: STRING(content: "files"), value: files) )
            dictionary["files"] = files
        }
        if let runOnlyForDeploymentPostprocessing = runOnlyForDeploymentPostprocessing {
            allvalues.append( try KEYVALUE(key: STRING(content: "runOnlyForDeploymentPostprocessing"), value: STRING(content: runOnlyForDeploymentPostprocessing)) )
            dictionary["runOnlyForDeploymentPostprocessing"] = runOnlyForDeploymentPostprocessing
        }
        return try KEYVALUE(key: key, value: PBXCollection(array: allvalues, dictionary: dictionary) )
    }
}
