// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
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
    guard lhs.fileRef == rhs.fileRef else { return false }
    return true
}
// MARK: - PBXFileReference AutoEquatable
extension PBXFileReference: Equatable {}
internal func == (lhs: PBXFileReference, rhs: PBXFileReference) -> Bool {
    guard lhs.uuid == rhs.uuid else { return false }
    guard lhs.isa == rhs.isa else { return false }
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
