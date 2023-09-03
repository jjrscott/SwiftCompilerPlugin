import SwiftCompilerPlugin

/// Implementation of the `Example` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #Example(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct ExpressionMacro: FreestandingMacro {
    public static func expandFreestandingMacro(
        macro: PluginMessage.MacroReference,
        macroRole: PluginMessage.MacroRole?,
        discriminator: String,
        expandingSyntax: PluginMessage.Syntax
    ) throws -> (expandedSource: String?,
                 diagnostics: [PluginMessage.Diagnostic]) {
        let source = expandingSyntax.source
        let start = source.index(source.startIndex, offsetBy: "#ExpressionMacro(".count)
        let end = source.index(source.endIndex, offsetBy:  0 - ")".count)
        let argument = source[start..<end]
        
        return ("(\(argument), \"\(argument)\")", [])
    }
}

public struct DeclarationMacro: FreestandingMacro {
    public static func expandFreestandingMacro(macro: SwiftCompilerPlugin.PluginMessage.MacroReference, macroRole: SwiftCompilerPlugin.PluginMessage.MacroRole?, discriminator: String, expandingSyntax: SwiftCompilerPlugin.PluginMessage.Syntax) throws -> (expandedSource: String?, diagnostics: [SwiftCompilerPlugin.PluginMessage.Diagnostic]) {
        return ("", [])
    }
}

public struct PeerMacro: AttachedMacro {
    public static func expandAttachedMacro(macro: SwiftCompilerPlugin.PluginMessage.MacroReference, macroRole: SwiftCompilerPlugin.PluginMessage.MacroRole, discriminator: String, attributeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, declSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, parentDeclSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, extendedTypeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, conformanceListSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?) throws -> (expandedSource: String?, diagnostics: [SwiftCompilerPlugin.PluginMessage.Diagnostic]) {
        return ("", [])
    }
}

public struct AccessorMacro: AttachedMacro {
    public static func expandAttachedMacro(macro: SwiftCompilerPlugin.PluginMessage.MacroReference, macroRole: SwiftCompilerPlugin.PluginMessage.MacroRole, discriminator: String, attributeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, declSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, parentDeclSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, extendedTypeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, conformanceListSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?) throws -> (expandedSource: String?, diagnostics: [SwiftCompilerPlugin.PluginMessage.Diagnostic]) {
        return ("get { \"some value\"} set {}", [])
    }
}

public struct MemberAttributeMacro: AttachedMacro {
    public static func expandAttachedMacro(macro: SwiftCompilerPlugin.PluginMessage.MacroReference, macroRole: SwiftCompilerPlugin.PluginMessage.MacroRole, discriminator: String, attributeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, declSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, parentDeclSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, extendedTypeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, conformanceListSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?) throws -> (expandedSource: String?, diagnostics: [SwiftCompilerPlugin.PluginMessage.Diagnostic]) {
        return ("", [])
    }
}

public struct MemberMacro: AttachedMacro {
    public static func expandAttachedMacro(macro: SwiftCompilerPlugin.PluginMessage.MacroReference, macroRole: SwiftCompilerPlugin.PluginMessage.MacroRole, discriminator: String, attributeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, declSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, parentDeclSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, extendedTypeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, conformanceListSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?) throws -> (expandedSource: String?, diagnostics: [SwiftCompilerPlugin.PluginMessage.Diagnostic]) {
        return ("", [])
    }
}

public struct ExtensionMacro: AttachedMacro {
    public static func expandAttachedMacro(macro: SwiftCompilerPlugin.PluginMessage.MacroReference, macroRole: SwiftCompilerPlugin.PluginMessage.MacroRole, discriminator: String, attributeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, declSyntax: SwiftCompilerPlugin.PluginMessage.Syntax, parentDeclSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, extendedTypeSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?, conformanceListSyntax: SwiftCompilerPlugin.PluginMessage.Syntax?) throws -> (expandedSource: String?, diagnostics: [SwiftCompilerPlugin.PluginMessage.Diagnostic]) {
        return ("", [])
    }
}

@main
struct ExamplePlugin: CompilerPlugin {

    
    let providingMacros: [Macro.Type] = [
        ExpressionMacro.self,
        DeclarationMacro.self,
        PeerMacro.self,
        AccessorMacro.self,
        MemberAttributeMacro.self,
        MemberMacro.self,
        ExtensionMacro.self,
    ]
}
