//
//  CoreSpec.swift
//  xproj
//
//  Created by Jin Hyong Park on 1/8/17.
//  Copyright © 2017 PropertyGuru. All rights reserved.
//
import Quick
import Nimble

class CoreSpec: QuickSpec {
    
    override func spec() {
        describe("Core spec") {
            
//            class ArgumentsMockWithProjectFilePath: ArgumentsProtocol {
//                var target: String { return "Target" }
//                var destination: String { return "/path/from/sourcetoot" }
//                var recursive: Bool { return false }
//                var verbose: Bool { return false }
//                var files: Array<String> { return ["notdirectory", "notdirectory", "notdirectory"] }
//                var project: String { return "/project/p.xcproj" }
//            }
//            
//            class FileMock: FileProtocol {
//                static func exists(path: String) -> Bool {
//                    return true
//                }
//                
//                static func isDirectory( path: String) -> Bool {
//                    if path == "notdirectory" { return false }
//                    return true
//                }
//                static func read( path: String ) throws -> String {
//                    if path == "/project/p.xcproj/project.pbxproj" { return "Success" }
//                    return ""
//                }
//                static func write( path: String, contents: String ) throws {
//                    
//                }
//                static func allContents( at path: String ) throws -> Array<String> {
//                    return Array<String>()
//                }
//            }
//            
//            it("Project file test") {
//                let arg = ArgumentsMockWithProjectFilePath()
//                var core = Core(argument: arg)
//                core.fileManager = FileMock.self
//                core.processArgument()
//                expect( core.projectfile ).to(equal("Success"))
//            }
//            
//            it("files without recursive test") {
//                let arg = ArgumentsMockWithProjectFilePath()
//                var core = Core(argument: arg)
//                core.fileManager = FileMock.self
//                core.processArgument()
//                expect( core.filesMustBeAdded ).to(equal(["/path/from/sourcetoot/notdirectory", "/path/from/sourcetoot/notdirectory", "/path/from/sourcetoot/notdirectory"]))
//            }
//            
//            class FileMockRecursive: FileProtocol {
//                static func exists(path: String) -> Bool {
//                    return true
//                }
//                
//                static func isDirectory( path: String) -> Bool {
//                    if path.contains(".swift") { return false }
//                    return true
//                }
//                static func read( path: String ) throws -> String {
//                    if path == "/project/p.xcproj/project.pbxproj" { return "Success" }
//                    return ""
//                }
//                static func write( path: String, contents: String ) throws {
//                    
//                }
//                static func allContents( at path: String ) throws -> Array<String> {
//                    if path == "directory" { return ["1.swift","2.swift","3"] }
//                    else if path == "d" { return ["4.swift","5.swift","6"] }
//                    else { return ["7.swift","8.swift","9"] }
//                }
//            }
            class ArgumentsMockRecursive: ArgumentsProtocol {
                var target: String { return "Target" }
                var destination: String { return "/path/from/sourcetoot" }
                var recursive: Bool { return true }
                var verbose: Bool { return false }
                var files: Array<String> { return ["directory", "dir", "d"] }
                var project: String { return "/project/p.xcproj" }
            }
            
//            it( "files with recursive test" ) {
//                let arg = ArgumentsMockRecursive()
//                var core = Core(argument: arg)
//                core.fileManager = FileMockRecursive.self
//                core.processArgument()
//                
//                expect( core.filesMustBeAdded ).to(equal(["/path/from/sourcetoot/1.swift", "/path/from/sourcetoot/2.swift", "/path/from/sourcetoot/7.swift", "/path/from/sourcetoot/8.swift", "/path/from/sourcetoot/4.swift", "/path/from/sourcetoot/5.swift"]))
//                expect( core.groupsMustBeAdded ).to(equal(["/path/from/sourcetoot/3", "/path/from/sourcetoot/9", "/path/from/sourcetoot/6"]))
//            }
            
            class FileMockFulltest: FileProtocol {
                static func exists(path: String) -> Bool {
                    return true
                }
                
                static func isDirectory( path: String) -> Bool {
                    if path.contains(".swift") { return false }
                    return true
                }
                static func read( path: String ) throws -> String {
                    return "// !$*UTF8*$!\n{\n\tarchiveVersion = 1;\n\tclasses = {\n\t};\n\tobjectVersion = 46;\n\tobjects = {\n\n/* Begin PBXBuildFile section */\n\t\t1FFB5EBA1F173360002F4A12 /* AppDelegate.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1FFB5EB91F173360002F4A12 /* AppDelegate.swift */; };\n\t\t1FFB5EBC1F173360002F4A12 /* ViewController.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1FFB5EBB1F173360002F4A12 /* ViewController.swift */; };\n\t\t1FFB5EBF1F173360002F4A12 /* Main.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 1FFB5EBD1F173360002F4A12 /* Main.storyboard */; };\n\t\t1FFB5EC11F173360002F4A12 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = 1FFB5EC01F173360002F4A12 /* Assets.xcassets */; };\n\t\t1FFB5EC41F173360002F4A12 /* LaunchScreen.storyboard in Resources */ = {isa = PBXBuildFile; fileRef = 1FFB5EC21F173360002F4A12 /* LaunchScreen.storyboard */; };\n\t\t1FFB5ED21F174CEC002F4A12 /* GF_1_Source_1.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1FFB5ECF1F174CEC002F4A12 /* GF_1_Source_1.swift */; };\n\t\t1FFB5ED31F174CEC002F4A12 /* GF_1_Source_2.swift in Sources */ = {isa = PBXBuildFile; fileRef = 1FFB5ED01F174CEC002F4A12 /* GF_1_Source_2.swift */; };\n\t\t1FFB5ED51F174CFE002F4A12 /* ReferenceWithFolder in Resources */ = {isa = PBXBuildFile; fileRef = 1FFB5ED41F174CFE002F4A12 /* ReferenceWithFolder */; };\n\t\t1FFB5EDA1F174D69002F4A12 /* GO_1_PLIST_1.plist in Resources */ = {isa = PBXBuildFile; fileRef = 1FFB5ED91F174D69002F4A12 /* GO_1_PLIST_1.plist */; };\n/* End PBXBuildFile section */\n\n/* Begin PBXFileReference section */\n\t\t1FFB5EB61F173360002F4A12 /* Sample.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Sample.app; sourceTree = BUILT_PRODUCTS_DIR; };\n\t\t1FFB5EB91F173360002F4A12 /* AppDelegate.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = AppDelegate.swift; sourceTree = \"<group>\"; };\n\t\t1FFB5EBB1F173360002F4A12 /* ViewController.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ViewController.swift; sourceTree = \"<group>\"; };\n\t\t1FFB5EBE1F173360002F4A12 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/Main.storyboard; sourceTree = \"<group>\"; };\n\t\t1FFB5EC01F173360002F4A12 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = \"<group>\"; };\n\t\t1FFB5EC31F173360002F4A12 /* Base */ = {isa = PBXFileReference; lastKnownFileType = file.storyboard; name = Base; path = Base.lproj/LaunchScreen.storyboard; sourceTree = \"<group>\"; };\n\t\t1FFB5EC51F173360002F4A12 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = \"<group>\"; };\n\t\t1FFB5ECF1F174CEC002F4A12 /* GF_1_Source_1.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GF_1_Source_1.swift; sourceTree = \"<group>\"; };\n\t\t1FFB5ED01F174CEC002F4A12 /* GF_1_Source_2.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = GF_1_Source_2.swift; sourceTree = \"<group>\"; };\n\t\t1FFB5ED41F174CFE002F4A12 /* ReferenceWithFolder */ = {isa = PBXFileReference; lastKnownFileType = folder; path = ReferenceWithFolder; sourceTree = \"<group>\"; };\n\t\t1FFB5ED91F174D69002F4A12 /* GO_1_PLIST_1.plist */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = text.plist.xml; path = GO_1_PLIST_1.plist; sourceTree = \"<group>\"; };\n/* End PBXFileReference section */\n\n/* Begin PBXFrameworksBuildPhase section */\n\t\t1FFB5EB31F173360002F4A12 /* Frameworks */ = {\n\t\t\tisa = PBXFrameworksBuildPhase;\n\t\t\tbuildActionMask = 2147483647;\n\t\t\tfiles = (\n\t\t\t);\n\t\t\trunOnlyForDeploymentPostprocessing = 0;\n\t\t};\n/* End PBXFrameworksBuildPhase section */\n\n/* Begin PBXGroup section */\n\t\t1FFB5EAD1F173360002F4A12 = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5EB81F173360002F4A12 /* Sample */,\n\t\t\t\t1FFB5EB71F173360002F4A12 /* Products */,\n\t\t\t);\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5EB71F173360002F4A12 /* Products */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5EB61F173360002F4A12 /* Sample.app */,\n\t\t\t);\n\t\t\tname = Products;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5EB81F173360002F4A12 /* Sample */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5ED61F174D02002F4A12 /* GroupOnly */,\n\t\t\t\t1FFB5ED41F174CFE002F4A12 /* ReferenceWithFolder */,\n\t\t\t\t1FFB5ECD1F174CEC002F4A12 /* GroupWithFolder */,\n\t\t\t\t1FFB5EB91F173360002F4A12 /* AppDelegate.swift */,\n\t\t\t\t1FFB5EBB1F173360002F4A12 /* ViewController.swift */,\n\t\t\t\t1FFB5EBD1F173360002F4A12 /* Main.storyboard */,\n\t\t\t\t1FFB5EC01F173360002F4A12 /* Assets.xcassets */,\n\t\t\t\t1FFB5EC21F173360002F4A12 /* LaunchScreen.storyboard */,\n\t\t\t\t1FFB5EC51F173360002F4A12 /* Info.plist */,\n\t\t\t);\n\t\t\tpath = Sample;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5ECD1F174CEC002F4A12 /* GroupWithFolder */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5ECE1F174CEC002F4A12 /* GF_1 */,\n\t\t\t\t1FFB5ED11F174CEC002F4A12 /* GF_2 */,\n\t\t\t);\n\t\t\tpath = GroupWithFolder;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5ECE1F174CEC002F4A12 /* GF_1 */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5ECF1F174CEC002F4A12 /* GF_1_Source_1.swift */,\n\t\t\t\t1FFB5ED01F174CEC002F4A12 /* GF_1_Source_2.swift */,\n\t\t\t);\n\t\t\tpath = GF_1;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5ED11F174CEC002F4A12 /* GF_2 */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t);\n\t\t\tpath = GF_2;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5ED61F174D02002F4A12 /* GroupOnly */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5ED81F174D42002F4A12 /* GO_2 */,\n\t\t\t\t1FFB5ED71F174D24002F4A12 /* GO_1 */,\n\t\t\t);\n\t\t\tname = GroupOnly;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5ED71F174D24002F4A12 /* GO_1 */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5ED91F174D69002F4A12 /* GO_1_PLIST_1.plist */,\n\t\t\t);\n\t\t\tname = GO_1;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5ED81F174D42002F4A12 /* GO_2 */ = {\n\t\t\tisa = PBXGroup;\n\t\t\tchildren = (\n\t\t\t);\n\t\t\tname = GO_2;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n/* End PBXGroup section */\n\n/* Begin PBXNativeTarget section */\n\t\t1FFB5EB51F173360002F4A12 /* Sample */ = {\n\t\t\tisa = PBXNativeTarget;\n\t\t\tbuildConfigurationList = 1FFB5EC81F173360002F4A12 /* Build configuration list for PBXNativeTarget \"Sample\" */;\n\t\t\tbuildPhases = (\n\t\t\t\t1FFB5EB21F173360002F4A12 /* Sources */,\n\t\t\t\t1FFB5EB31F173360002F4A12 /* Frameworks */,\n\t\t\t\t1FFB5EB41F173360002F4A12 /* Resources */,\n\t\t\t);\n\t\t\tbuildRules = (\n\t\t\t);\n\t\t\tdependencies = (\n\t\t\t);\n\t\t\tname = Sample;\n\t\t\tproductName = Sample;\n\t\t\tproductReference = 1FFB5EB61F173360002F4A12 /* Sample.app */;\n\t\t\tproductType = \"com.apple.product-type.application\";\n\t\t};\n/* End PBXNativeTarget section */\n\n/* Begin PBXProject section */\n\t\t1FFB5EAE1F173360002F4A12 /* Project object */ = {\n\t\t\tisa = PBXProject;\n\t\t\tattributes = {\n\t\t\t\tLastSwiftUpdateCheck = 0830;\n\t\t\t\tLastUpgradeCheck = 0830;\n\t\t\t\tORGANIZATIONNAME = PropertyGuru;\n\t\t\t\tTargetAttributes = {\n\t\t\t\t\t1FFB5EB51F173360002F4A12 = {\n\t\t\t\t\t\tCreatedOnToolsVersion = 8.3.3;\n\t\t\t\t\t\tProvisioningStyle = Automatic;\n\t\t\t\t\t};\n\t\t\t\t};\n\t\t\t};\n\t\t\tbuildConfigurationList = 1FFB5EB11F173360002F4A12 /* Build configuration list for PBXProject \"Sample\" */;\n\t\t\tcompatibilityVersion = \"Xcode 3.2\";\n\t\t\tdevelopmentRegion = English;\n\t\t\thasScannedForEncodings = 0;\n\t\t\tknownRegions = (\n\t\t\t\ten,\n\t\t\t\tBase,\n\t\t\t);\n\t\t\tmainGroup = 1FFB5EAD1F173360002F4A12;\n\t\t\tproductRefGroup = 1FFB5EB71F173360002F4A12 /* Products */;\n\t\t\tprojectDirPath = \"\";\n\t\t\tprojectRoot = \"\";\n\t\t\ttargets = (\n\t\t\t\t1FFB5EB51F173360002F4A12 /* Sample */,\n\t\t\t);\n\t\t};\n/* End PBXProject section */\n\n/* Begin PBXResourcesBuildPhase section */\n\t\t1FFB5EB41F173360002F4A12 /* Resources */ = {\n\t\t\tisa = PBXResourcesBuildPhase;\n\t\t\tbuildActionMask = 2147483647;\n\t\t\tfiles = (\n\t\t\t\t1FFB5EC41F173360002F4A12 /* LaunchScreen.storyboard in Resources */,\n\t\t\t\t1FFB5EC11F173360002F4A12 /* Assets.xcassets in Resources */,\n\t\t\t\t1FFB5ED51F174CFE002F4A12 /* ReferenceWithFolder in Resources */,\n\t\t\t\t1FFB5EDA1F174D69002F4A12 /* GO_1_PLIST_1.plist in Resources */,\n\t\t\t\t1FFB5EBF1F173360002F4A12 /* Main.storyboard in Resources */,\n\t\t\t);\n\t\t\trunOnlyForDeploymentPostprocessing = 0;\n\t\t};\n/* End PBXResourcesBuildPhase section */\n\n/* Begin PBXSourcesBuildPhase section */\n\t\t1FFB5EB21F173360002F4A12 /* Sources */ = {\n\t\t\tisa = PBXSourcesBuildPhase;\n\t\t\tbuildActionMask = 2147483647;\n\t\t\tfiles = (\n\t\t\t\t1FFB5ED31F174CEC002F4A12 /* GF_1_Source_2.swift in Sources */,\n\t\t\t\t1FFB5ED21F174CEC002F4A12 /* GF_1_Source_1.swift in Sources */,\n\t\t\t\t1FFB5EBC1F173360002F4A12 /* ViewController.swift in Sources */,\n\t\t\t\t1FFB5EBA1F173360002F4A12 /* AppDelegate.swift in Sources */,\n\t\t\t);\n\t\t\trunOnlyForDeploymentPostprocessing = 0;\n\t\t};\n/* End PBXSourcesBuildPhase section */\n\n/* Begin PBXVariantGroup section */\n\t\t1FFB5EBD1F173360002F4A12 /* Main.storyboard */ = {\n\t\t\tisa = PBXVariantGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5EBE1F173360002F4A12 /* Base */,\n\t\t\t);\n\t\t\tname = Main.storyboard;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n\t\t1FFB5EC21F173360002F4A12 /* LaunchScreen.storyboard */ = {\n\t\t\tisa = PBXVariantGroup;\n\t\t\tchildren = (\n\t\t\t\t1FFB5EC31F173360002F4A12 /* Base */,\n\t\t\t);\n\t\t\tname = LaunchScreen.storyboard;\n\t\t\tsourceTree = \"<group>\";\n\t\t};\n/* End PBXVariantGroup section */\n\n/* Begin XCBuildConfiguration section */\n\t\t1FFB5EC61F173360002F4A12 /* Debug */ = {\n\t\t\tisa = XCBuildConfiguration;\n\t\t\tbuildSettings = {\n\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;\n\t\t\t\tCLANG_ANALYZER_NONNULL = YES;\n\t\t\t\tCLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;\n\t\t\t\tCLANG_CXX_LANGUAGE_STANDARD = \"gnu++0x\";\n\t\t\t\tCLANG_CXX_LIBRARY = \"libc++\";\n\t\t\t\tCLANG_ENABLE_MODULES = YES;\n\t\t\t\tCLANG_ENABLE_OBJC_ARC = YES;\n\t\t\t\tCLANG_WARN_BOOL_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_CONSTANT_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;\n\t\t\t\tCLANG_WARN_DOCUMENTATION_COMMENTS = YES;\n\t\t\t\tCLANG_WARN_EMPTY_BODY = YES;\n\t\t\t\tCLANG_WARN_ENUM_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_INFINITE_RECURSION = YES;\n\t\t\t\tCLANG_WARN_INT_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;\n\t\t\t\tCLANG_WARN_SUSPICIOUS_MOVE = YES;\n\t\t\t\tCLANG_WARN_UNREACHABLE_CODE = YES;\n\t\t\t\tCLANG_WARN__DUPLICATE_METHOD_MATCH = YES;\n\t\t\t\t\"CODE_SIGN_IDENTITY[sdk=iphoneos*]\" = \"iPhone Developer\";\n\t\t\t\tCOPY_PHASE_STRIP = NO;\n\t\t\t\tDEBUG_INFORMATION_FORMAT = dwarf;\n\t\t\t\tENABLE_STRICT_OBJC_MSGSEND = YES;\n\t\t\t\tENABLE_TESTABILITY = YES;\n\t\t\t\tGCC_C_LANGUAGE_STANDARD = gnu99;\n\t\t\t\tGCC_DYNAMIC_NO_PIC = NO;\n\t\t\t\tGCC_NO_COMMON_BLOCKS = YES;\n\t\t\t\tGCC_OPTIMIZATION_LEVEL = 0;\n\t\t\t\tGCC_PREPROCESSOR_DEFINITIONS = (\n\t\t\t\t\t\"DEBUG=1\",\n\t\t\t\t\t\"$(inherited)\",\n\t\t\t\t);\n\t\t\t\tGCC_WARN_64_TO_32_BIT_CONVERSION = YES;\n\t\t\t\tGCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;\n\t\t\t\tGCC_WARN_UNDECLARED_SELECTOR = YES;\n\t\t\t\tGCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;\n\t\t\t\tGCC_WARN_UNUSED_FUNCTION = YES;\n\t\t\t\tGCC_WARN_UNUSED_VARIABLE = YES;\n\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 10.3;\n\t\t\t\tMTL_ENABLE_DEBUG_INFO = YES;\n\t\t\t\tONLY_ACTIVE_ARCH = YES;\n\t\t\t\tSDKROOT = iphoneos;\n\t\t\t\tSWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;\n\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = \"-Onone\";\n\t\t\t\tTARGETED_DEVICE_FAMILY = \"1,2\";\n\t\t\t};\n\t\t\tname = Debug;\n\t\t};\n\t\t1FFB5EC71F173360002F4A12 /* Release */ = {\n\t\t\tisa = XCBuildConfiguration;\n\t\t\tbuildSettings = {\n\t\t\t\tALWAYS_SEARCH_USER_PATHS = NO;\n\t\t\t\tCLANG_ANALYZER_NONNULL = YES;\n\t\t\t\tCLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;\n\t\t\t\tCLANG_CXX_LANGUAGE_STANDARD = \"gnu++0x\";\n\t\t\t\tCLANG_CXX_LIBRARY = \"libc++\";\n\t\t\t\tCLANG_ENABLE_MODULES = YES;\n\t\t\t\tCLANG_ENABLE_OBJC_ARC = YES;\n\t\t\t\tCLANG_WARN_BOOL_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_CONSTANT_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;\n\t\t\t\tCLANG_WARN_DOCUMENTATION_COMMENTS = YES;\n\t\t\t\tCLANG_WARN_EMPTY_BODY = YES;\n\t\t\t\tCLANG_WARN_ENUM_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_INFINITE_RECURSION = YES;\n\t\t\t\tCLANG_WARN_INT_CONVERSION = YES;\n\t\t\t\tCLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;\n\t\t\t\tCLANG_WARN_SUSPICIOUS_MOVE = YES;\n\t\t\t\tCLANG_WARN_UNREACHABLE_CODE = YES;\n\t\t\t\tCLANG_WARN__DUPLICATE_METHOD_MATCH = YES;\n\t\t\t\t\"CODE_SIGN_IDENTITY[sdk=iphoneos*]\" = \"iPhone Developer\";\n\t\t\t\tCOPY_PHASE_STRIP = NO;\n\t\t\t\tDEBUG_INFORMATION_FORMAT = \"dwarf-with-dsym\";\n\t\t\t\tENABLE_NS_ASSERTIONS = NO;\n\t\t\t\tENABLE_STRICT_OBJC_MSGSEND = YES;\n\t\t\t\tGCC_C_LANGUAGE_STANDARD = gnu99;\n\t\t\t\tGCC_NO_COMMON_BLOCKS = YES;\n\t\t\t\tGCC_WARN_64_TO_32_BIT_CONVERSION = YES;\n\t\t\t\tGCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;\n\t\t\t\tGCC_WARN_UNDECLARED_SELECTOR = YES;\n\t\t\t\tGCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;\n\t\t\t\tGCC_WARN_UNUSED_FUNCTION = YES;\n\t\t\t\tGCC_WARN_UNUSED_VARIABLE = YES;\n\t\t\t\tIPHONEOS_DEPLOYMENT_TARGET = 10.3;\n\t\t\t\tMTL_ENABLE_DEBUG_INFO = NO;\n\t\t\t\tSDKROOT = iphoneos;\n\t\t\t\tSWIFT_OPTIMIZATION_LEVEL = \"-Owholemodule\";\n\t\t\t\tTARGETED_DEVICE_FAMILY = \"1,2\";\n\t\t\t\tVALIDATE_PRODUCT = YES;\n\t\t\t};\n\t\t\tname = Release;\n\t\t};\n\t\t1FFB5EC91F173360002F4A12 /* Debug */ = {\n\t\t\tisa = XCBuildConfiguration;\n\t\t\tbuildSettings = {\n\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;\n\t\t\t\tINFOPLIST_FILE = Sample/Info.plist;\n\t\t\t\tLD_RUNPATH_SEARCH_PATHS = \"$(inherited) @executable_path/Frameworks\";\n\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = pguru.Sample;\n\t\t\t\tPRODUCT_NAME = \"$(TARGET_NAME)\";\n\t\t\t\tSWIFT_VERSION = 3.0;\n\t\t\t};\n\t\t\tname = Debug;\n\t\t};\n\t\t1FFB5ECA1F173360002F4A12 /* Release */ = {\n\t\t\tisa = XCBuildConfiguration;\n\t\t\tbuildSettings = {\n\t\t\t\tASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;\n\t\t\t\tINFOPLIST_FILE = Sample/Info.plist;\n\t\t\t\tLD_RUNPATH_SEARCH_PATHS = \"$(inherited) @executable_path/Frameworks\";\n\t\t\t\tPRODUCT_BUNDLE_IDENTIFIER = pguru.Sample;\n\t\t\t\tPRODUCT_NAME = \"$(TARGET_NAME)\";\n\t\t\t\tSWIFT_VERSION = 3.0;\n\t\t\t};\n\t\t\tname = Release;\n\t\t};\n/* End XCBuildConfiguration section */\n\n/* Begin XCConfigurationList section */\n\t\t1FFB5EB11F173360002F4A12 /* Build configuration list for PBXProject \"Sample\" */ = {\n\t\t\tisa = XCConfigurationList;\n\t\t\tbuildConfigurations = (\n\t\t\t\t1FFB5EC61F173360002F4A12 /* Debug */,\n\t\t\t\t1FFB5EC71F173360002F4A12 /* Release */,\n\t\t\t);\n\t\t\tdefaultConfigurationIsVisible = 0;\n\t\t\tdefaultConfigurationName = Release;\n\t\t};\n\t\t1FFB5EC81F173360002F4A12 /* Build configuration list for PBXNativeTarget \"Sample\" */ = {\n\t\t\tisa = XCConfigurationList;\n\t\t\tbuildConfigurations = (\n\t\t\t\t1FFB5EC91F173360002F4A12 /* Debug */,\n\t\t\t\t1FFB5ECA1F173360002F4A12 /* Release */,\n\t\t\t);\n\t\t\tdefaultConfigurationIsVisible = 0;\n\t\t};\n/* End XCConfigurationList section */\n\t};\n\trootObject = 1FFB5EAE1F173360002F4A12 /* Project object */;\n}\n"
                }
                static func write( path: String, contents: String ) throws {
                    
                }
                static func allContents( at path: String ) throws -> Array<String> {
                    if path == "directory" { return ["1.swift","2.swift","3"] }
                    else if path == "d" { return ["4.swift","5.swift","6"] }
                    else { return ["7.swift","8.swift","9"] }
                }
            }
            
            class ArgumentsMockFullTest: ArgumentsProtocol {
                var target: String { return "Sample" }
                var destination: String { return "/Sample/GroupWithFolder/" }
                var recursive: Bool { return true }
                var verbose: Bool { return false }
                var files: Array<String> { return ["directory", "dir", "d"] }
                var project: String { return "/project/p.xcproj" }
            }
            
            it( "show result" ) {
                let arg = ArgumentsMockFullTest()
                var core = Core(argument: arg)
                core.fileManager = FileMockFulltest.self
                core.processArgument()
            }
        }
    }
}
