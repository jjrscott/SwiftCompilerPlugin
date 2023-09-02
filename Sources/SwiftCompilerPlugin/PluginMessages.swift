//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift open source project
//
// Copyright (c) 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// NOTE: Types in this file should be self-contained and should not depend on any non-stdlib types.

public enum HostToPluginMessage: Codable {
    /// Send capability of the host, and get capability of the plugin.
    case getCapability(
        capability: PluginMessage.HostCapability?
    )
    
    /// Expand a '@freestanding' macro.
    case expandFreestandingMacro(
        macro: PluginMessage.MacroReference,
        macroRole: PluginMessage.MacroRole? = nil,
        discriminator: String,
        syntax: PluginMessage.Syntax
    )
    
    /// Expand an '@attached' macro.
    case expandAttachedMacro(
        macro: PluginMessage.MacroReference,
        macroRole: PluginMessage.MacroRole,
        discriminator: String,
        attributeSyntax: PluginMessage.Syntax,
        declSyntax: PluginMessage.Syntax,
        parentDeclSyntax: PluginMessage.Syntax?,
        extendedTypeSyntax: PluginMessage.Syntax?,
        conformanceListSyntax: PluginMessage.Syntax?
    )
    
    /// Optionally implemented message to load a dynamic link library.
    /// 'moduleName' can be used as a hint indicating that the library
    /// provides the specified module.
    case loadPluginLibrary(
        libraryPath: String,
        moduleName: String
    )
}

public enum PluginToHostMessage: Codable {
    case getCapabilityResult(
        capability: PluginMessage.PluginCapability
    )
    
    /// Unified response for freestanding/attached macro expansion.
    case expandMacroResult(
        expandedSource: String?,
        diagnostics: [PluginMessage.Diagnostic]
    )
    
    // @available(*, deprecated: "use expandMacroResult() instead")
    case expandFreestandingMacroResult(
        expandedSource: String?,
        diagnostics: [PluginMessage.Diagnostic]
    )
    
    // @available(*, deprecated: "use expandMacroResult() instead")
    case expandAttachedMacroResult(
        expandedSources: [String]?,
        diagnostics: [PluginMessage.Diagnostic]
    )
    
    case loadPluginLibraryResult(
        loaded: Bool,
        diagnostics: [PluginMessage.Diagnostic]
    )
}

public enum PluginMessage {
    public static var PROTOCOL_VERSION_NUMBER: Int { 7 }  // Pass extension protocol list
    
    public struct HostCapability: Codable {
        var protocolVersion: Int
        
        public init(protocolVersion: Int) {
            self.protocolVersion = protocolVersion
        }
    }
    
    public struct PluginCapability: Codable {
        public var protocolVersion: Int
        
        /// Optional features this plugin provides.
        ///  * 'load-plugin-library': 'loadPluginLibrary' message is implemented.
        public var features: [String]?
        
        public init(protocolVersion: Int, features: [String]? = nil) {
            self.protocolVersion = protocolVersion
            self.features = features
        }
    }
    
    public struct MacroReference: Codable {
        public var moduleName: String
        public var typeName: String
        
        // The name of 'macro' declaration the client is using.
        public var name: String
        
        public init(moduleName: String, typeName: String, name: String) {
            self.moduleName = moduleName
            self.typeName = typeName
            self.name = name
        }
    }
    
    public enum MacroRole: String, Codable {
        case expression
        case declaration
        case accessor
        case memberAttribute
        case member
        case peer
        case conformance
        case codeItem
        case `extension`
    }
    
    public struct SourceLocation: Codable {
        /// A file ID consisting of the module name and file name (without full path),
        /// as would be generated by the macro expansion `#fileID`.
        public var fileID: String
        
        /// A full path name as would be generated by the macro expansion `#filePath`,
        /// e.g., `/home/taylor/alison.swift`.
        public var fileName: String
        
        /// UTF-8 offset of the location in the file.
        public var offset: Int
        
        public var line: Int
        public var column: Int
        
        public init(fileID: String, fileName: String, offset: Int, line: Int, column: Int) {
            self.fileID = fileID
            self.fileName = fileName
            self.offset = offset
            self.line = line
            self.column = column
        }
    }
    
    public struct Diagnostic: Codable {
        public enum Severity: String, Codable {
            case error
            case warning
            case note
        }
        public struct Position: Codable {
            public var fileName: String
            /// UTF-8 offset in the file.
            public var offset: Int
            
            public init(fileName: String, offset: Int) {
                self.fileName = fileName
                self.offset = offset
            }
            
            public static var invalid: Self {
                .init(fileName: "", offset: 0)
            }
        }
        public struct PositionRange: Codable {
            public var fileName: String
            /// UTF-8 offset of the start of the range in the file.
            public var startOffset: Int
            /// UTF-8 offset of the end of the range in the file.
            public var endOffset: Int
            
            public init(fileName: String, startOffset: Int, endOffset: Int) {
                self.fileName = fileName
                self.startOffset = startOffset
                self.endOffset = endOffset
            }
            
            public static var invalid: Self {
                .init(fileName: "", startOffset: 0, endOffset: 0)
            }
        }
        public struct Note: Codable {
            public var position: Position
            public var message: String
            
            public init(position: Position, message: String) {
                self.position = position
                self.message = message
            }
        }
        public struct FixIt: Codable {
            public struct Change: Codable {
                public var range: PositionRange
                public var newText: String
                
                internal init(range: PositionRange, newText: String) {
                    self.range = range
                    self.newText = newText
                }
            }
            public var message: String
            public var changes: [Change]
            
            internal init(message: String, changes: [Change]) {
                self.message = message
                self.changes = changes
            }
        }
        public var message: String
        public var severity: Severity
        public var position: Position
        public var highlights: [PositionRange]
        public var notes: [Note]
        public var fixIts: [FixIt]
        
        internal init(message: String, severity: Severity, position: Position, highlights: [PositionRange], notes: [Note], fixIts: [FixIt]) {
            self.message = message
            self.severity = severity
            self.position = position
            self.highlights = highlights
            self.notes = notes
            self.fixIts = fixIts
        }
    }
    
    public struct Syntax: Codable {
        public enum Kind: String, Codable {
            case declaration
            case statement
            case expression
            case type
            case pattern
            case attribute
        }
        public var kind: Kind
        public var source: String
        public var location: SourceLocation
        
        public init(kind: Kind, source: String, location: SourceLocation) {
            self.kind = kind
            self.source = source
            self.location = location
        }
    }
}
